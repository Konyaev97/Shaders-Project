Shader "z/Test3"
{
	Properties
	{
		_MaskTex ("Mask Texture ", 2D) = "black" {} //название и тип €чейки дл€ прокидыван€
		_EmossionMaskTex ("EmissionMask Texture ", 2D) = "black" {} //название и тип €чейки дл€ прокидыван€

		_MainTex1 ("Main Texture 1", 2D) = "white" {} //название и тип €чейки дл€ прокидыван€ = это дефолтное
														//значение
		_MainTex2 ("Main Texture 2", 2D) = "white" {} //название и тип €чейки дл€ прокидыван€
		_MainTex3 ("Main Texture 3", 2D) = "white" {} //название и тип €чейки дл€ прокидыван€

		_EmissionColor ("Emission Color", Color) = (1,1,1,1) //белый стандартный цвет
		_VectorParm ("Vector Parametr", Vector) = (1.0, 0.5, 0.1 , 0.0)

		_FloatParm ("Intensity Float", Float) = 1.0
		_IntParm ("Intensity Int", Int) = 1 // в инспекторе как дробный, но сбрасывает в < сторону 10.9 = 10
		_RangeParm ("Itensity Range", Range(0 , 1)) = 1

		_BumpMap ("Normal Map", 2D) = "bump" {}

		_Shiness1 ("Shiness1", Range(0 , 1)) = 0.07
		_Shiness2 ("Shiness2", Range(0 , 1)) = 0.07
		_Shiness3 ("Shiness3", Range(0 , 1)) = 0.07

		_Specularity1 ("Specularity 1", Range(0 , 1)) = 0.5
		_Specularity2 ("Specularity 2", Range(0 , 1)) = 0.5
		_Specularity3 ("Specularity 3", Range(0 , 1)) = 0.5

		_SpecColor ("Specular Color", Color) = (1 , 1 , 1 , 1)

	}

	SubShader {
		CGPROGRAM
		#pragma surface surf BlinnPhong // описали тип Ўейдера (—урфействного типа) его описание в функции surf.
									//а модель освещени€ Lanbert

		sampler2D _MainTex1; // указатель на текстуру из ѕроперти, тк это разные вещи
		sampler2D _MainTex2; // указатель на текстуру из ѕроперти, тк это разные вещи
		sampler2D _MainTex3; // указатель на текстуру из ѕроперти, тк это разные вещи

		sampler2D _MaskTex;
		sampler2D _EmissionMaskTex;

		sampler2D _BumpMap;

		fixed3 _EmissionColor;
		fixed 
		_Specularity1,
		_Specularity2,
		_Specularity3 
		;
		float _RangeParm;

		half _Shiness1;
		half _Shiness2;
		half _Shiness3;



		struct Input{ // мешовые данные которые мы измен€ем и передаем вторым параметром в функцию surf
			half2 uv_MainTex1;
			half2 uv_MaskTex;
		};

		// ќписывает набор команд того что должно быт на поверхности материалла
		void surf (Input IN, inout SurfaceOutput o) //создаем переменные, задает IN , возвращает значение o
		{
			fixed3 masks = tex2D(_MaskTex, IN.uv_MaskTex).rgb;

			fixed3 clr =  tex2D(_MainTex1, IN.uv_MainTex1).rgb * masks.x;
			clr += tex2D(_MainTex2, IN.uv_MainTex1) * masks.y;
			clr += tex2D(_MainTex3, IN.uv_MainTex1) * masks.z;
			o.Albedo = clr;// второй параметр это координты и он отвечает за тайлинг

			fixed3 emTex = tex2D(_EmissionMaskTex , IN.uv_MaskTex).rgb; // —читали текстуры и записали ее каналы
			half appearMask = emTex.b;

			appearMask = smoothstep (_RangeParm * 2 ,_RangeParm * 2 - 1 , appearMask);
			o.Emission = appearMask * emTex.g * _EmissionColor;

			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_MaskTex));
			o.Specular = _Shiness1 * masks.r + _Shiness2 * masks.g +_Shiness3 * masks.b ;
			o.Gloss = _Specularity1 * masks.r + _Specularity2 * masks.g +_Specularity3 * masks.b;
		}

		ENDCG
	}

	Fallback "Diffuse"
}
