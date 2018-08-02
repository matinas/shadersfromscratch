Shader "SFS/NormalExtrusion" {
	
	// Extrudes the vertices based on the extrude amount parameter

	Properties {
		_AlbedoTex ("Albedo Texture", 2D) = "white" {}
		_Amount ("Extrusion Amount", Range(-0.2,0.5)) = 0
	}
	
	SubShader {
		
		CGPROGRAM
		
		#pragma surface surf Lambert vertex:vert // Add 'addshadow' at the end here if we want to extrude also the projected shadows

		uniform sampler2D _AlbedoTex;
		uniform half _Amount;

		struct Input
		{
			float2 uv_AlbedoTex;
		};

		// In case we'd want to define our own appdata structure, just add this and update the input structure on vert()...
		// struct appdata
		// {
		// 	float4 vertex : POSITION;
		// 	float3 normal : NORMAL;
		// 	float4 texcoord: TEXCOORD0; // This should be named 'texcoord' in order to be correctly mapped to IN.uv_AlbedoTex
		// };

		void vert(inout appdata_full v)
		{
			v.vertex.xyz += v.normal * _Amount;
		}

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_AlbedoTex, IN.uv_AlbedoTex).rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}