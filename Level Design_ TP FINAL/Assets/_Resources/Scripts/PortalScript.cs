using UnityEngine;
using UnityEngine.SceneManagement;

public class PortalScript : MonoBehaviour
{
    private SceneActions _sceneActions;

    private void Start()
    {
        _sceneActions = GetComponent<SceneActions>();
        SceneManager.activeSceneChanged += DestroyOnSceneChange;
    }

    private void OnTriggerEnter(Collider other)
    {
        DontDestroyOnLoad(gameObject);
        _sceneActions.LoadScene();
    }
    
    private void DestroyOnSceneChange (Scene scene, Scene scene2)
    {
        SceneManager.activeSceneChanged -= DestroyOnSceneChange;
        Destroy(gameObject,2f);
    }
}
