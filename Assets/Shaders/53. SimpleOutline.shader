Shader "SFS/SimpleOutline" {
	
	// Shades the geometry with an outline of the specified color and width. Take into account that this solution,
	// although simple, requires the shader to be set on the Transparency render queue, which might not be desirable

	Properties {
		_AlbedoTex ("Albedo Texture", 2D) = "white" {}
		_OutlineColor ("Outline Color", Color) = (1,0,0,1)
		_OutlineWidth ("Outline Width", Range(0,0.1)) = 0
	}
	
	SubShader {

		Tags { "Queue" = "Transparent" } // So to ensure that it's drawn always after the rest of the geometry (including the background
										 // which can override it if we use just the Geometry queue, as it's commonly the last thing to draw)
		
		// First pass

		ZWrite Off // Disable ZBuffer write

		CGPROGRAM
	
			#pragma surface surf Lambert vertex:vert

			uniform half _OutlineWidth;
			uniform fixed4 _OutlineColor;

			struct Input
			{
				float2 uv_AlbedoTex;
			};

			void vert(inout appdata_full v)
			{
				v.vertex.xyz += v.normal * _OutlineWidth;
			}

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Emission = _OutlineColor.rgb;
			}

		ENDCG

		// Second pass

		ZWrite On // Enable ZBuffer write

		CGPROGRAM
	
			#pragma surface surf Lambert

			uniform sampler2D _AlbedoTex;

			struct Input
			{
				float2 uv_AlbedoTex;
			};

			void surf (Input IN, inout SurfaceOutput o)
			{
				o.Albedo = tex2D(_AlbedoTex, IN.uv_AlbedoTex).rgb;
			}

		ENDCG
	}

	FallBack "Diffuse"
}