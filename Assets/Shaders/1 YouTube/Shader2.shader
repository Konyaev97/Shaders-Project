Shader "z/Test2"
{
	Properties
	{
		_MainTex1 ("Main Texture 1", 2D) = "white" {} //название и тип ячейки для прокидываня
		_MainTex2 ("Main Texture 2", 2D) = "white" {} //название и тип ячейки для прокидываня
		_MainTex3 ("Main Texture 3", 2D) = "white" {} //название и тип ячейки для прокидываня

		_MaskTex ("Mask Texture ", 2D) = "black" {} //название и тип ячейки для прокидываня
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert // описали тип Шейдера (Сурфействного типа) его описание в функции surf.
									//а модель освещения Lanbert

		sampler2D _MainTex1; // указатель на текстуру из Проперти, тк это разные вещи
		sampler2D _MainTex2; // указатель на текстуру из Проперти, тк это разные вещи
		sampler2D _MainTex3; // указатель на текстуру из Проперти, тк это разные вещи

		sampler2D _MaskTex;

		struct Input{ // мешовые данные которые мы изменяем и передаем вторым параметром в функцию surf
			half2 uv_MainTex1;
			half2 uv_MaskTex;
		};

		// Описывает набор команд того что должно быт на поверхности материалла
		void surf (Input IN, inout SurfaceOutput o) //создаем переменные, задает IN , возвращает значение o
		{
			fixed3 masks = tex2D(_MaskTex, IN.uv_MaskTex);
			fixed3 clr =  tex2D(_MainTex1, IN.uv_MainTex1) * masks.x;
			clr += tex2D(_MainTex2, IN.uv_MainTex1) * masks.y;
			clr += tex2D(_MainTex3, IN.uv_MainTex1) * masks.z;

			o.Albedo = clr;// второй параметр это координты и он отвечает за тайлинг
		}

		ENDCG
	}

	Fallback "Diffuse"
}
