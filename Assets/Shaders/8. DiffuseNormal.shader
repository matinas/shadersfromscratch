Shader "SFS/DiffuseNormal" {
	
	// Shades the geometry with a given albedo texture and a normal map,
	// which bumpinness is driven by another parameter

	Properties {
		_AlbedoTex ("Albedo Texture", 2D) = "white" {}
		_NormalTex ("Normal Map", 2D) = "bump" {}
		_Bump ("Bump Amount", Range(0,10)) = 1
	}
	
	SubShader {
		
		CGPROGRAM
		
		#pragma surface surf Lambert

		uniform sampler2D _AlbedoTex;
		uniform sampler2D _NormalTex;
		uniform half _Bump;

		struct Input
		{
			float2 uv_AlbedoTex;
			float2 uv_NormalTex;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_AlbedoTex, IN.uv_AlbedoTex).rgb;
			o.Normal = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));
			
			o.Normal *= float3(_Bump,_Bump,1); // We have to multiply just the X and Y to "flat them" even more
		}

		ENDCG
	}

	FallBack "Diffuse"
}