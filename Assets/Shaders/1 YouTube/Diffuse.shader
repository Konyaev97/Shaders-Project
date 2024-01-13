Shader "z/Diffuse"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Base (RGB)", 2D) = "white" {}

        _Extrude ("Extrude", Float) = 0.0
        _DisMap ("DIS Map", 2D) = "black" {}
    }
    SubShader
    {
        Tags {
            "RenderType"="Opaque" 
            }
        LOD 200

        CGPROGRAM
        #pragma target 3.0
        #pragma surface surf Lambert vertex:vert

        sampler2D 
        _MainTex,
        _DisMap
        ;

        struct Input
        {
            float2 uv_MainTex;
        };
        float _Extrude;
        fixed4 _Color;

        void vert (inout appdata_full v, out Input o)
        {
            UNITY_INITIALIZE_OUTPUT(Input,o);
            v.vertex.xyz += v.normal * _Extrude * tex2Dlod(_DisMap, float4( v.texcoord.xy, 0.0 , 0.0)).r;
        }

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;

            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
