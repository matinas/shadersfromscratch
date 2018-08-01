Shader "SFS/DecalOverTex" {
	
	// Shades the geometry with a given base texture plus a decal texture drawn right onto the base one

	Properties
	{
		_MainTex ("Main Texture", 2D) = "black" {}
		_Decal ("Decal Texture", 2D) = "black" {}
		[Toggle] _ShowDecal ("Show Decal", Float) = 1
	}

	SubShader {

		Tags { "Queue" = "Geometry" }

		CGPROGRAM

		#pragma surface surf Lambert

		sampler2D _MainTex, _Decal;
		float _ShowDecal;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			fixed4 m = tex2D(_MainTex, IN.uv_MainTex);
			fixed4 d = tex2D(_Decal, IN.uv_MainTex);

			o.Albedo = _ShowDecal ? (m * d).rgb : m.rgb;
			//o.Albedo = d.r > 0.8 ? m.rgb : d.rgb; // In case we want just the original color from the decal (not blended with the one of the base texture)
		}

		ENDCG
	}

	FallBack "Diffuse"
}