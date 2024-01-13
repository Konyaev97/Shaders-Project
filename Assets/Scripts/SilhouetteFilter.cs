using UnityEngine;

public class SilhouetteFilter : SimpleFilter
{
    [SerializeField] private Color nearColor;
    [SerializeField] private Color farColor;

    protected override void OnUpdate()
    {
        mat.SetColor("_NearColor", nearColor);
        mat.SetColor("_FarColor", farColor);
    }




}
