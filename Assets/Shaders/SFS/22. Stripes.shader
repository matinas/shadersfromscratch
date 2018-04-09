Shader "SFS/Stripes" {
	
	// Shades the geometry by interchanging two colors depending on the world
	// position, giving a multicolor horizontal band effect as a result

	Properties
	{
		_Color1 ("Color 1", Color) = (0.5,0,0,1)
		_Color2 ("Color 2", Color) = (0,0.5,0,1)
		_Threshold ("Threshold", Range(0.0,1.0)) = 0.4
	}

	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		fixed4 _Color1, _Color2;
		float _Threshold;

		struct Input
		{
			float3 worldPos;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = (frac(IN.worldPos.y*10) > _Threshold) ? _Color1 : _Color2;
		}
		ENDCG
	}

	FallBack "Diffuse"
}
