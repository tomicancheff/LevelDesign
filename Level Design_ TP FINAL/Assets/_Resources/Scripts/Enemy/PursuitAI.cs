using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PursuitAI : MonoBehaviour
{
    [SerializeField]
    private LayerMask _obstacle;
    [Range(1, 5)][SerializeField]
    private float _speed;
    [Range(5, 30)][SerializeField]
    private float _canSeeRadius;
    [SerializeField]
    private LayerMask _player;
    
    private Transform _target;
    private Rigidbody _rb;
    private Vector3 _moveDirection;
    private Animator _animator;
    
    private static readonly int Walking = Animator.StringToHash("Walking");

    private void Start()
    {
        _rb = GetComponent<Rigidbody>();
        _animator = GetComponent<Animator>();
    }

    private void Update()
    {
        var viewArea = Physics.OverlapSphere(transform.position, _canSeeRadius, _player);
        if (viewArea.Length > 0)
        {
            _target = viewArea[0].transform;
            Pursuit();
        }
        else
        {
            _animator.SetBool(Walking, false);
        }
    }


    private void Pursuit()
    {
        if (CanPursuit())
        {
            _moveDirection = (_target.position - transform.position).normalized * _speed; 
            _moveDirection.y = _rb.velocity.y;
            transform.LookAt(_target);
            _animator.SetBool(Walking, true);
            _rb.velocity = _moveDirection;
        }
        else
        {
            _animator.SetBool(Walking, false);
            _rb.velocity = Vector3.zero;
        }
    }

    private bool CanPursuit()
    {
        if (Physics.Raycast(transform.position, _moveDirection, Vector3.Distance(transform.position, _target.position), _obstacle))
        {
            _animator.SetBool(Walking, false);
            return false;
        }
        return true;
    }
    
    private void OnDrawGizmos()
    {
        Gizmos.color = Color.green;
        Gizmos.DrawWireSphere(transform.position, _canSeeRadius);
        Gizmos.color = Color.magenta;
        Gizmos.DrawLine(transform.position, transform.position + _moveDirection * 3f);
    }
}
