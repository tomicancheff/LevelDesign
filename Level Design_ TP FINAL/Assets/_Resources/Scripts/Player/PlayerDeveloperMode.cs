using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.SceneManagement;

public class PlayerDeveloperMode : MonoBehaviour
{
    private bool _isDeveloper;
    private Player _player;
    private bool _hasSuperSpeed;
    private bool _isConsoleVisible;
    private List<DoorKey> _doorList;
    
    private void Awake()
    {
        _player = GetComponent<Player>();
        SceneManager.activeSceneChanged += SceneManagerOnactiveSceneChanged;
    }

    private void SceneManagerOnactiveSceneChanged(Scene arg0, Scene arg1)
    {
        DoorList();
    }

    private void DoorList()
    {
        _doorList = FindObjectsOfType<DoorKey>().ToList();;
        foreach (var door in _doorList)
        {
            print(door.name);
        }
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.F8))
        {
            _isDeveloper = !_isDeveloper;
        }

        if (!_isDeveloper) return;

        if (Input.GetKeyDown(KeyCode.H))
        {
            _player.Health.TakeDamage(20f);
        }
        
        if (Input.GetKeyDown(KeyCode.J))
        {
            _player.Health.Heal(20f);
        }

        if (Input.GetKeyDown(KeyCode.K))
        {
            if (_doorList.Count <= 0) return;
            var door = _doorList[_doorList.Count - 1];
            door.gameObject.SetActive(false);
            _doorList.Remove(door);
        }

        if (Input.GetKeyDown(KeyCode.L))
        {
            _hasSuperSpeed = !_hasSuperSpeed;
            _player.ThirdPersonController.MoveSpeed = _hasSuperSpeed ? 30f : 6f;
        }

        if (Input.GetKeyDown(KeyCode.Y))
        {
            _isConsoleVisible = !_isConsoleVisible;
            Debug.developerConsoleVisible = _isConsoleVisible;
        }

        if (Input.GetKeyDown(KeyCode.U))
        {
            var keyList = FindObjectsOfType(typeof(OpenDoors));
            foreach (var key in keyList)
            {
                Debug.LogError(key.name);
            }

            _isConsoleVisible = true;
        }
    }
}
