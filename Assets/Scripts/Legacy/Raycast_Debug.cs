using UnityEngine;

public class Raycast_Debug : MonoBehaviour
{
    [SerializeField] private float rayDistance = 10;
    RaycastHit hit;
    [SerializeField] private LayerMask layerMask;
    private void Start()
    {
        Collider[] colliders = Physics.OverlapBox(transform.position, transform.localScale,
            Quaternion.identity);

        foreach (Collider coll in colliders)
        {
            Debug.Log(coll.gameObject.name);
        }
    }

    private void OnDrawGizmos()
    {
        Gizmos.DrawWireCube(transform.position, transform.localScale *2);
    }

    private void Update()
    {
       
    }
}
