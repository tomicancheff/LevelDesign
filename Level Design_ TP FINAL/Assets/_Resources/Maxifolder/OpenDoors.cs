using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OpenDoors : MonoBehaviour
{
    [SerializeField] private GameObject Door1;
    


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
            Door1.SetActive(false);
        }

        
    }

    
}
