using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GunScript : MonoBehaviour
{
   
    
    void Update()
    {

        // Only to Show
        transform.Rotate(new Vector3(0f, 0f, 50f) * Time.deltaTime);
    }
}
