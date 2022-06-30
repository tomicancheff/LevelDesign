using UnityEngine;

public class OpenDoors : MonoBehaviour
{
    [SerializeField] private GameObject door1;
    
    private AudioSource _audioSource;
    
    private void Start()
    {
        _audioSource = GetComponent<AudioSource>();
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            _audioSource.Play();
            door1.SetActive(false);
            Destroy(gameObject, 0.1f);
        }
    }
}
