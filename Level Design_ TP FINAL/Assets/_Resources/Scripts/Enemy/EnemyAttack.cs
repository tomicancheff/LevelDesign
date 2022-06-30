using System;
using System.Diagnostics;
using UnityEngine;

public class EnemyAttack : MonoBehaviour
{
    [SerializeField] private int _attackTimer;
    [SerializeField] private int _damage;

    private Animator _animator;
    
    private Stopwatch _sw;
    private TimeSpan _ts;
    
    private static readonly int Attack1 = Animator.StringToHash("Attack1");

    private void Awake()
    {
        _animator = GetComponent<Animator>();
    }

    private void Start()
    {
        _sw = new Stopwatch();
        _sw.Start();
        _ts = new TimeSpan(0, 0, _attackTimer);
    }

    private void OnTriggerStay(Collider other)
    {
        if (!other.CompareTag("Player") || _sw.Elapsed < _ts) return;
        var healthDamage = other.GetComponent<Health>();
        _animator.SetTrigger(Attack1);
        healthDamage.TakeDamage(_damage);
        print(healthDamage.CurrentHealth);
        _sw.Restart();
    }
}
