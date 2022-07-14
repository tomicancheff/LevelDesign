using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerStart : MonoBehaviour
{
    private Player _player;
    
    private void Start()
    {
        _player = FindObjectOfType<Player>();
        _player.Teleport(transform);
    }
}
