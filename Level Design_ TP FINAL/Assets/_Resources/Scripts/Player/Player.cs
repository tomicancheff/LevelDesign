using System.Collections;
using StarterAssets;
using UnityEngine;
using UnityEngine.SceneManagement;

public class Player : MonoBehaviour
{
    #region Singleton

    public static Player Instance;
    private void MakeSingleton()
    {
        if (Instance == null)
        {
            Instance = this;
            DontDestroyOnLoad(this);
        }
        else
            Destroy(gameObject);
    }

    #endregion
    
    public Health Health { get; private set; }
    public Ammo Ammo { get; private set; }
    public ThirdPersonController ThirdPersonController { get; private set; }
    public StarterAssetsInputs Inputs { get; private set; }

    public Transform ShootingPoint => shootingPoint;

    private PlayerStart _playerStart;
    private CanvasManager _canvasManager;

    [SerializeField] private Transform shootingPoint;

    private void Awake()
    {
        MakeSingleton();
        Health = GetComponent<Health>();
        Ammo = GetComponent<Ammo>();
        ThirdPersonController = GetComponent<ThirdPersonController>();
        Inputs = GetComponent<StarterAssetsInputs>();
        Health.OnDeath += OnDeathHandler;
        SceneManager.activeSceneChanged += OnSceneChange;
        Inputs.OnInputPause += PauseInputHandler;
    }

    private void OnSceneChange(Scene arg0, Scene arg1)
    {
        _playerStart = FindObjectOfType<PlayerStart>();
        _canvasManager = FindObjectOfType<CanvasManager>();
        Inputs.pause = false;
    }

    private void OnDeathHandler()
    {
        var pos = _playerStart.gameObject.transform;
        Teleport(pos);
        Health.ResetToMax();
    }
    
    public void Teleport(Transform pos)
    {
        StartCoroutine(TeleportTo(pos));
    }

    private IEnumerator TeleportTo(Transform pos)
    {
        var charCont = GetComponent<ThirdPersonController>();
        charCont.enabled = false;
        var playerTransform = transform;
        playerTransform.position = pos.position;
        playerTransform.rotation = pos.rotation;
        yield return new WaitForSeconds(0.15f);
        charCont.enabled = true;
    }

    private void PauseInputHandler()
    {
        _canvasManager.SwitchCanvas(Inputs.pause ? CanvasType.PauseScreen : CanvasType.GameUI);
    }
}
