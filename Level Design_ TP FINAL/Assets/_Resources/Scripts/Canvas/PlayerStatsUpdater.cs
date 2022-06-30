using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class PlayerStatsUpdater : MonoBehaviour
{
    [SerializeField] private Slider _healthBar;
    [SerializeField] private TextMeshProUGUI _healthText;
    
    private Player _player;
    private Health _playerHealth;
    private float _playerMaxHealth;
    
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
    }

    private void CharacterSubscriptions()
    {
        _playerHealth.OnConsumed += delegate
        {
            //DamageTakenVFX();
            HealthBarUpdate(_playerHealth.CurrentHealth, _playerHealth.GetRatio);
        };
    }
    
    private void HealthBarUpdate(float currHp, float hpPercent)
    {
        _healthBar.value = hpPercent;
        _healthText.text = $"{currHp} / {_playerMaxHealth}";
    }
}
