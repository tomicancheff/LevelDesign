using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OpenDoor2 : MonoBehaviour
{
    [SerializeField] private GameObject Door2;
    void Start()
    {
        
    }

   
    void Update()
    {
        
    }

    // TRIGGER ZONE COLLIDER----------


    private void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Player")
        {
            Door2.SetActive(false);
        }


    }
}
