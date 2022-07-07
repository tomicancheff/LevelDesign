using UnityEngine;

public class SimpleProjectile : MonoBehaviour
{
    private float _speed;
    private float _damage;
    private float _lifespan;
    private Vector3 _direction;

    [SerializeField] private LayerMask collisionLayers;

    public void SetUp(float speed, float damage, float lifespan, Vector3 position, Vector3 direction)
    {
        _speed = speed;
        _damage = damage;
        _lifespan = lifespan;
        transform.position = position;
        _direction = direction;
    }
    
    private void Update()
    {
        if (_lifespan <= 0) Destroy(gameObject);

        _lifespan -= Time.deltaTime;
        transform.Translate(_direction * (_speed * Time.deltaTime), Space.World);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Enemy"))
        {
            if (other.GetComponent<Enemy>() != null)
            {
                other.GetComponent<Enemy>().Health.TakeDamage(_damage);
            }
            Destroy(gameObject);
        }
    }
    
    private void OnCollisionEnter(Collision other)
    {
        if (other.gameObject.layer == collisionLayers)
        {
            Destroy(gameObject);
        }
    }
    
}