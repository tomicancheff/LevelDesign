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

[RequireComponent(typeof(Button))]
public class ButtonActions : MonoBehaviour
{
    [SerializeField] private Transform loadingScreenGo;
    
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
        loadingScreenGo.gameObject.SetActive(true);
        var slider = loadingScreenGo.gameObject.GetComponentInChildren<Slider>();
        yield return StartCoroutine(FadeLoadingScreen(1, 1));
        AsyncOperation operation = SceneManager.LoadSceneAsync(sceneToLoad);
        while (!operation.isDone)
        {
            slider.value = Mathf.Clamp01(operation.progress / 0.9f);
            yield return null;
        }
        yield return StartCoroutine(FadeLoadingScreen(0, 1));
        loadingScreenGo.gameObject.SetActive(false);
    }

    private IEnumerator FadeLoadingScreen(float targetValue, float duration)
    {
        var canvasGroup = loadingScreenGo.GetComponent<CanvasGroup>();
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
}
