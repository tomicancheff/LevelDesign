using System.Collections;
using StarterAssets;
using UnityEngine;

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

    private PlayerStart _playerStart;

    private void Awake()
    {
        MakeSingleton();
        _playerStart = FindObjectOfType<PlayerStart>();
        Health = GetComponent<Health>();
        Ammo = GetComponent<Ammo>();
        Health.OnDeath += OnDeathHandler;
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
}
