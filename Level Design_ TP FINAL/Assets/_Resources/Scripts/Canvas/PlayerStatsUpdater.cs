using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PlayerStatsUpdater : MonoBehaviour
{
    [SerializeField] private Slider healthBar;
    [SerializeField] private TextMeshProUGUI healthText;
    [SerializeField] private TextMeshProUGUI ammoText;
    
    private Player _player;
    private Health _playerHealth;
    private float _playerMaxHealth;
    private Ammo _playerAmmo;
    private float _playerMaxAmmo;
    
    private void Start()
    {
        _player = Player.Instance;
        FirstLoad();
        CharacterSubscriptions();
    }

    private void FirstLoad()
    {
        _playerHealth = _player.Health;
        _playerMaxHealth = _playerHealth.MaxHealth;
        HealthBarUpdate(_playerHealth.CurrentHealth, _playerHealth.GetRatio);
        _playerAmmo = _player.Ammo;
        _playerMaxAmmo = _playerAmmo.MaxAmmo;
        AmmoCountUpdate(_playerAmmo.CurrentAmmo);
    }

    private void CharacterSubscriptions()
    {
        _playerHealth.OnConsumed += delegate
        {
            //DamageTakenVFX();
            HealthBarUpdate(_playerHealth.CurrentHealth, _playerHealth.GetRatio);
        };
        _playerHealth.OnGained += delegate
        {
            HealthBarUpdate(_playerHealth.CurrentHealth, _playerHealth.GetRatio);
        };
        _playerAmmo.OnConsumed += delegate
        {
            AmmoCountUpdate(_playerAmmo.CurrentAmmo);
        };
        _playerAmmo.OnGained += delegate
        {
            AmmoCountUpdate(_playerAmmo.CurrentAmmo);
        };
    }
    
    private void HealthBarUpdate(float currHp, float hpPercent)
    {
        healthBar.value = hpPercent;
        healthText.text = $"{currHp} / {_playerMaxHealth}";
    }
    private void AmmoCountUpdate(float currAmmo)
    {
        ammoText.text = $"{currAmmo} / {_playerMaxAmmo}";
    }
}
