using System;
using System.Collections;
using UnityEngine;
using UnityEngine.SceneManagement;
using UnityEngine.UI;

public enum LevelSelector
{
    Tutorial,
    Level1,
    Level2
}
public class SceneActions : MonoBehaviour
{
    private GameObject _loadingScreenGo;
    
    [Header("LoadScene")][Space(5)][SerializeField]
    private string sceneToLoadName = "Tutorial";

    private void Start()
    {
        _loadingScreenGo = FindObjectOfType<LoadingController>(true).gameObject;
    }

    public void QuitApplication()
    {
#if UNITY_EDITOR
        UnityEditor.EditorApplication.isPlaying = false;
#endif
#if UNITY_STANDALONE_WIN
        Application.Quit();
#endif
    }

    public void LevelSelect(string level)
    {
        if (Enum.TryParse(level,true, out LevelSelector levelValue))
        {
            var levelName = levelValue.ToString();
            if (SceneManager.GetActiveScene().name != levelName)
            {
                StartCoroutine(StartLoad(levelName));
            }
        }
        else
            Debug.LogWarning("The desired levelname was not found");
    }

    private IEnumerator StartLoad(string sceneToLoad)
    {
        _loadingScreenGo.SetActive(true);
        var slider = _loadingScreenGo.GetComponentInChildren<Slider>();
        yield return StartCoroutine(FadeLoadingScreen(1, 1));
        AsyncOperation operation = SceneManager.LoadSceneAsync(sceneToLoad);
        while (!operation.isDone)
        {
            slider.value = Mathf.Clamp01(operation.progress / 0.9f);
            yield return null;
        }
        yield return StartCoroutine(FadeLoadingScreen(0, 1));
        _loadingScreenGo.SetActive(false);
    }

    private IEnumerator FadeLoadingScreen(float targetValue, float duration)
    {
        var canvasGroup = _loadingScreenGo.GetComponent<CanvasGroup>();
        float startValue = canvasGroup.alpha;
        float time = 0;
        while (time < duration)
        {
            canvasGroup.alpha = Mathf.Lerp(startValue, targetValue, time / duration);
            time += Time.deltaTime;
            yield return null;
        }
        canvasGroup.alpha = targetValue;
    }

    public void LoadScene()
    {
        StartCoroutine(StartLoad(sceneToLoadName));
    }
}
