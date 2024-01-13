using UnityEngine;

public class NeonFilter : SimpleFilter
{
    protected override void UseFilter(RenderTexture source, RenderTexture destination)
    {
        RenderTexture neonTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);
        RenderTexture thresholdTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);
        RenderTexture blurTex = RenderTexture.GetTemporary(source.width, source.height, 0, source.format);

        Graphics.Blit(source, neonTex, mat, 0);
        Graphics.Blit(neonTex, thresholdTex, mat, 1);
        Graphics.Blit(thresholdTex, blurTex, mat, 2);
        mat.SetTexture("_SrcTex", neonTex);
        Graphics.Blit(blurTex, destination, mat, 3);

        RenderTexture.ReleaseTemporary(neonTex);
        RenderTexture.ReleaseTemporary(thresholdTex);
        RenderTexture.ReleaseTemporary(blurTex);
    }
}
