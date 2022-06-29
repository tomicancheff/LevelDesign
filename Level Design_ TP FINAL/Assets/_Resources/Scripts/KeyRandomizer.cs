using System.Collections.Generic;
using UnityEngine;

public class KeyRandomizer : MonoBehaviour
{
    [SerializeField] private List<OpenDoors> keyList;

    private void Start()
    {
        keyList[Random.Range(0, keyList.Count)].gameObject.SetActive(true);
    }
}
