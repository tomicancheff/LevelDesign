using UnityEngine;
using Quaternion = UnityEngine.Quaternion;
using Vector3 = UnityEngine.Vector3;

public class PlayerWeaponController : MonoBehaviour
{
    private Player _player;
    private Vector3 _shootingPoint;
    private float _lastProjectileShot;

    [Header("Weapon Stats")] [Space(5)] 
    [SerializeField] private float weaponFireRate = 0.3f;
    [SerializeField] private float weaponReloadTime = 0.3f;
    
    [Header("Bullet Stats")][Space(5)]
    [SerializeField] private SimpleProjectile bullet;
    [SerializeField] private float bulletSpeed = 1f;
    [SerializeField] private float bulletDamage = 1f;
    [SerializeField] private float bulletLifespan = 1f;
    
    private void Awake()
    {
        _player = GetComponent<Player>();
    }

    private void Update()
    {
        Shoot();
        Reload();
    }

    private void Shoot()
    {
        if (_player.Ammo.IsEmpty) return;
        if (!_player.Inputs.shoot)
        {
            _lastProjectileShot = 0.07f;
            return;
        }
        if (_lastProjectileShot <= 0)
        {
            _shootingPoint = _player.ShootingPoint.position;
            
            var projectile = Instantiate(bullet, _shootingPoint, transform.rotation);
            projectile.SetUp(bulletSpeed,bulletDamage,bulletLifespan,_shootingPoint,transform.forward);
            _player.Ammo.ConsumeAmmo(1f);
            _lastProjectileShot = weaponFireRate;
        }
        else
        {
            _lastProjectileShot -= Time.deltaTime;
        }
    }

    private void Reload()
    {
        if (!_player.Inputs.reload) return;
        print("Reloading");
        _player.Inputs.reload = false;
        Invoke(nameof(FullLoadAmmo),weaponReloadTime);
    }

    private void FullLoadAmmo()
    {
        _player.Ammo.ResetToMax();
    }
}