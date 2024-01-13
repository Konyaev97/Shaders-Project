Shader "z/Test"
{
	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {} //название и тип ячейки для прокидываня
	}

	SubShader {
		CGPROGRAM
		#pragma surface surf Lambert // описали тип Шейдера (Сурфействного типа) его описание в функции surf.
									//а модель освещения Lanbert

		sampler2D _MainTex; // указатель на текстуру из Проперти, тк это разные вещи

		struct Input{ // мешовые данные которые мы изменяем и передаем вторым параметром в функцию surf
			half2 uv_MainTex;
		};

		// Описывает набор команд того что должно быт на поверхности материалла
		void surf (Input IN, inout SurfaceOutput o) //создаем переменные, задает IN , возвращает значение o
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex); // задаем цвет альбедо каналу в материалле имеет тип fixed3
		}

		ENDCG
	}

	Fallback "Diffuse"
}
