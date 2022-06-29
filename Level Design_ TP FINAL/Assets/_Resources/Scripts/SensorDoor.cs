using UnityEngine;

[RequireComponent(typeof(BoxCollider))]
public class SensorDoor : MonoBehaviour
{
    private DoorSensed _doorSensed;
    private GameObject _door;

    private void Awake()
    {
        _doorSensed = GetComponentInChildren<DoorSensed>();
        _door = _doorSensed.gameObject;
    }

    private void ChangeState()
    {
        var curr = _door.activeInHierarchy;
        _door.SetActive(!curr);
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            print("change in");
            ChangeState();
        }
    }

    private void OnTriggerExit(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            print("change out");
            ChangeState();
        }
    }
}
