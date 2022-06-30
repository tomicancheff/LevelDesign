using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerStart : MonoBehaviour
{
    private Player _player;

    private void Awake()
    {
        _player = FindObjectOfType<Player>();
    }

    private void Start()
    {
        var pTransform = _player.gameObject.transform;
        var transform1 = transform;
        pTransform.position = transform1.position;
        pTransform.rotation = transform1.rotation;
    }
}
