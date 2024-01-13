Shader "z/Test2"
{
	Properties
	{
		_MainTex1 ("Main Texture 1", 2D) = "white" {} //�������� � ��� ������ ��� �����������
		_MainTex2 ("Main Texture 2", 2D) = "white" {} //�������� � ��� ������ ��� �����������
		_MainTex3 ("Main Texture 3", 2D) = "white" {} //�������� � ��� ������ ��� �����������

		_MaskTex ("Mask Texture ", 2D) = "black" {} //�������� � ��� ������ ��� �����������
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert // ������� ��� ������� (������������� ����) ��� �������� � ������� surf.
									//� ������ ��������� Lanbert

		sampler2D _MainTex1; // ��������� �� �������� �� ��������, �� ��� ������ ����
		sampler2D _MainTex2; // ��������� �� �������� �� ��������, �� ��� ������ ����
		sampler2D _MainTex3; // ��������� �� �������� �� ��������, �� ��� ������ ����

		sampler2D _MaskTex;

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
		}

		ENDCG
	}

	Fallback "Diffuse"
}
