Shader "z/Test3"
{
	Properties
	{
		_MaskTex ("Mask Texture ", 2D) = "black" {} //�������� � ��� ������ ��� �����������
		_EmossionMaskTex ("EmissionMask Texture ", 2D) = "black" {} //�������� � ��� ������ ��� �����������

		_MainTex1 ("Main Texture 1", 2D) = "white" {} //�������� � ��� ������ ��� ����������� = ��� ���������
														//��������
		_MainTex2 ("Main Texture 2", 2D) = "white" {} //�������� � ��� ������ ��� �����������
		_MainTex3 ("Main Texture 3", 2D) = "white" {} //�������� � ��� ������ ��� �����������

		_EmissionColor ("Emission Color", Color) = (1,1,1,1) //����� ����������� ����
		_VectorParm ("Vector Parametr", Vector) = (1.0, 0.5, 0.1 , 0.0)

		_FloatParm ("Intensity Float", Float) = 1.0
		_IntParm ("Intensity Int", Int) = 1 // � ���������� ��� �������, �� ���������� � < ������� 10.9 = 10
		_RangeParm ("Itensity Range", Range(0 , 1)) = 1

	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert // ������� ��� ������� (������������� ����) ��� �������� � ������� surf.
									//� ������ ��������� Lanbert

		sampler2D _MainTex1; // ��������� �� �������� �� ��������, �� ��� ������ ����
		sampler2D _MainTex2; // ��������� �� �������� �� ��������, �� ��� ������ ����
		sampler2D _MainTex3; // ��������� �� �������� �� ��������, �� ��� ������ ����

		sampler2D _MaskTex;
		sampler2D _EmissionMaskTex;

		fixed3 _EmissionColor;
		float _RangeParm;

		struct Input{ // ������� ������ ������� �� �������� � �������� ������ ���������� � ������� surf
			half2 uv_MainTex1;
			half2 uv_MaskTex;
		};

		// ��������� ����� ������ ���� ��� ������ ��� �� ����������� ����������
		void surf (Input IN, inout SurfaceOutput o) //������� ����������, ������ IN , ���������� �������� o
		{
			fixed3 masks = tex2D(_MaskTex, IN.uv_MaskTex);

			fixed3 clr =  tex2D(_MainTex1, IN.uv_MainTex1) * masks.x;
			clr += tex2D(_MainTex2, IN.uv_MainTex1) * masks.y;
			clr += tex2D(_MainTex3, IN.uv_MainTex1) * masks.z;
			o.Albedo = clr;// ������ �������� ��� ��������� � �� �������� �� �������

			fixed3 emTex = tex2D(_EmissionMaskTex , IN.uv_MaskTex).rgb; // ������� �������� � �������� �� ������
			half appearMask = emTex.b;

			appearMask = smoothstep (_RangeParm * 2 ,_RangeParm * 2 - 1 , appearMask);
			o.Emission = appearMask * emTex.g * _EmissionColor;
		}

		ENDCG
	}

	Fallback "Diffuse"
}
