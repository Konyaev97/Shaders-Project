using UnityEngine;
using UnityEngine.AI;

public class NPS_Navigation : MonoBehaviour
{
    private NavMeshAgent agent;
    [SerializeField] private Transform[] targetPoints;
    private int currentIndex = 0;
    private int targetPointLenght;

    private void Awake()
    {
        agent = GetComponent<NavMeshAgent>();
    }

    private void Start()
    {
        targetPointLenght = targetPoints.Length;
    }

    private void Update()
    {
        if (agent.remainingDistance < 0.2f)
        {
            MoveToWayPoint();
        }
    }

    private void MoveToWayPoint()
    {
        if (currentIndex >= 0 && currentIndex < targetPointLenght)
        {
            Vector3 targetPosition = targetPoints[currentIndex].position;
            agent.destination = targetPosition;
            currentIndex++;
        }
        else 
        {
            currentIndex = 0;
        }
    }
}
