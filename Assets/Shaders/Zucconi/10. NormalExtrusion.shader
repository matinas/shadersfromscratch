Shader "SFS/NormalExtrusion" {
	
	Properties {
		_AlbedoTex ("Albedo Texture", 2D) = "white" {}
		_Amount ("Extrusion Amount", Range(-0.01,0.01)) = 0
	}
	
	SubShader {
		
		Tags { "RenderType" = "Opaque" }

		CGPROGRAM
		
		#pragma surface surf Lambert vertex:vert

		uniform sampler2D _AlbedoTex;
		uniform half _Amount;

		struct Input
		{
			float2 uv_AlbedoTex;
		};

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