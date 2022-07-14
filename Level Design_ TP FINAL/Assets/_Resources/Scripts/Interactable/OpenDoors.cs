using UnityEngine;

public class OpenDoors : MonoBehaviour
{
    [SerializeField] private GameObject door;  
    [SerializeField] private GameObject keyReader;  
    
    private AudioSource _audioSource;
    private Material _keyReaderMat;
    private static readonly int EmissionColor = Shader.PropertyToID("_EmissionColor");

    private void Start()
    {
        _audioSource = GetComponent<AudioSource>();
        _keyReaderMat = keyReader.GetComponent<MeshRenderer>().material;
    }

    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            _audioSource.Play();
            door.SetActive(false);
            ChangeEmission();
            Destroy(gameObject, 0.1f);         
        }
    }

    private void ChangeEmission()
    {
        _keyReaderMat.SetColor(EmissionColor, Color.green);
    }
}
