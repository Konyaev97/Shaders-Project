Shader "z/Test"
{
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {} //�������� � ��� ������ ��� �����������
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert // ������� ��� ������� (������������� ����) ��� �������� � ������� surf.
									//� ������ ��������� Lanbert

		sampler2D _MainTex; // ��������� �� �������� �� ��������, �� ��� ������ ����

		struct Input{ // ������� ������ ������� �� �������� � �������� ������ ���������� � ������� surf
			half2 uv_MainTex;
		};

		// ��������� ����� ������ ���� ��� ������ ��� �� ����������� ����������
		void surf (Input IN, inout SurfaceOutput o) //������� ����������, ������ IN , ���������� �������� o
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex); // ������ ���� ������� ������ � ���������� ����� ��� fixed3
		}

		ENDCG
	}

	Fallback "Diffuse"
}
