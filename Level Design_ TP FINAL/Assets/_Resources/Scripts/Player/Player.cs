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
    

    private void Awake()
    {
        MakeSingleton();
        Health = GetComponent<Health>();
        Ammo = GetComponent<Ammo>();
    }
    
}
