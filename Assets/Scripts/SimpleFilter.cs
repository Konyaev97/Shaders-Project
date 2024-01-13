using UnityEngine;

public class SimpleFilter : MonoBehaviour
{
    [SerializeField] private Shader shader;

    protected Material mat;

    private bool useFilter = true;

    private void Awake()
    {
        mat = new Material(shader);
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.F))
        {
            useFilter = !useFilter;
        }

        OnUpdate();
    }

    protected virtual void OnUpdate()
    {
        
    }

    protected virtual void UseFilter(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, mat);
    }

    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (useFilter)
        {
            UseFilter(source, destination);
        }
        else
        {
            Graphics.Blit(source, destination);
        }
    }
}
