using System;
using UnityEngine;

public class Ammo : MonoBehaviour
{
    [SerializeField][Tooltip("Maximum amount of ammo")] 
    private float maxAmmo = 100f;

    public event Action OnConsumed;
    public event Action OnGained;
    public event Action OnEmpty;
    
    public float CurrentAmmo { get; private set; }
    public float MaxAmmo => maxAmmo;
    public float GetRatio => CurrentAmmo / maxAmmo;
    
    public bool IsEmpty { get; private set; }

    private void Awake()
    {
        CurrentAmmo = maxAmmo;
    }

    public void GainAmmo(float ammoAmount)
    {
        var ammoBefore = CurrentAmmo;
        CurrentAmmo += ammoAmount;
        CurrentAmmo = Mathf.Clamp(CurrentAmmo, 0f, maxAmmo);

        // call OnGained action
        var trueGainedAmount = CurrentAmmo - ammoBefore;
        if (trueGainedAmount > 0f)
        {
            // use this to display amount gained on screen
            OnGained?.Invoke();
        }
    }
   
    public void ConsumeAmmo(float bulletsUsed)
    {
        if (IsEmpty) return;
        var ammoBefore = CurrentAmmo;
        CurrentAmmo -= bulletsUsed;
        CurrentAmmo = Mathf.Clamp(CurrentAmmo, 0f, maxAmmo);

        // call OnUsed action
        var trueConsumedAmmo = ammoBefore - CurrentAmmo;
        if (trueConsumedAmmo > 0f)
        {
            // use this to display on screen
            OnConsumed?.Invoke();
        }

        HandleEmpty();
    }
    
    private void HandleEmpty()
    {
        if (IsEmpty) return;

        // call OnEmpty action
        if (CurrentAmmo <= 0f)
        {
            IsEmpty = true;
            OnEmpty?.Invoke();
        }
    }
    
    public void ResetToMax()
    {
        GainAmmo(maxAmmo);
        IsEmpty = false;
    }
}