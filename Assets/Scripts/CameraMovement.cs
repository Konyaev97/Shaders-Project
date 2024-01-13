
using UnityEngine;
[RequireComponent(typeof(Rigidbody))]
public class CameraMovement : MonoBehaviour
{
    [SerializeField] private float moveSpeed = 10f;
    [SerializeField] private float rotationSpeed = 3f;

    private Vector2 rotation = Vector2.zero;
    private Vector3 moveVector = Vector3.zero;

    private Rigidbody rb;

    private void Start()
    {
        rb = GetComponent<Rigidbody>(); 
        rb.useGravity = false;
        Cursor.lockState = CursorLockMode.Locked;
    }

    
    private void Update()
    {
        rotation += new Vector2(-Input.GetAxis("Mouse Y"), Input.GetAxis("Mouse X"));
        transform.eulerAngles = rotation * rotationSpeed;

        var x = Input.GetAxis("Horizontal");
        var z = Input.GetAxis("Vertical");

        moveVector = new Vector3(x, 0, z) * moveSpeed;
    }

    private void FixedUpdate()
    {
            rb.velocity = transform.TransformDirection(moveVector);
    }
}
