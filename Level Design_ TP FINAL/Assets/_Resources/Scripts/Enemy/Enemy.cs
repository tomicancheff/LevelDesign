using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Enemy : MonoBehaviour
{
    public Health Health { get; private set; }

    private void Awake()
    {
        Health = GetComponent<Health>();
        Health.OnDeath += OnDeathHandler;
    }

    private void OnDeathHandler()
    {
        Destroy(gameObject);
    }
}
