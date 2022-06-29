using System;
using System.Diagnostics;
using UnityEngine;

public class EnemyAttack : MonoBehaviour
{
    [SerializeField] private int _attackTimer;
    [SerializeField] private int _damage;
    
    private Stopwatch _sw;
    private TimeSpan _ts;

    private void Start()
    {
        _sw = new Stopwatch();
        _sw.Start();
        _ts = new TimeSpan(0, 0, _attackTimer);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (!other.CompareTag("Player") || _sw.Elapsed < _ts) return;
        other.GetComponent<Health>().TakeDamage(_damage);
        _sw.Restart();
    }
}
