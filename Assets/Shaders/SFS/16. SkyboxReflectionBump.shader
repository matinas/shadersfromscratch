Shader "SFS/SkyboxReflectionBump" {
	
	// This shader is a combination of 4 and 9, so it includes reflection based on a cubemap
	// as well as bump mapping based on a given normal map and a few parameters settings (intensity
	// of bump, bump amount, etc)

	// NOTE: not working very well though... seems there are some bugs with Unity related to this

	Properties {
		_Color ("Color", Color) = (0,0,0,1)
		_Range ("Range Value", Range(0,5)) = 1
		_MainTex ("Main Texture (RGB)", 2D) = "white" {}
		_NormalTex ("Normal Map", 2D) = "bump" {}
		_Cubemap ("Cube Map", CUBE) = "" {}
		_Bump ("Bump Amount", Range(0,10)) = 1
		_Intensity ("Intensity", Range(0,10)) = 1
	}
	SubShader {

		CGPROGRAM

		#pragma surface surf Lambert

		uniform fixed4 _Color;
		uniform half _Range;
		uniform sampler2D _MainTex;
		uniform samplerCUBE _Cubemap;
		uniform sampler2D _NormalTex;
		uniform half _Bump, _Intensity;

		struct Input
		{
			float2 uv_MainTex;
			float2 uv_NormalTex;
			float3 worldRefl; INTERNAL_DATA
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = _Color.rgb + (tex2D(_MainTex, IN.uv_MainTex) * _Range).rgb;
			
			o.Normal = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex));
			o.Normal *= float3(_Bump,_Bump,_Intensity);
			
			// The product by (-1,1,-1) is to invert X and Z, because it seems the WorldReflectionVector is returning
			// a vector pointing to the wrong direction. To see it delete the product and set the Intensity to zero.
			// The model will look transparent but what's happening it's just that the front face is reflecting the
			// back of the cubemap and visceversa

			o.Emission = texCUBE(_Cubemap, float3(-1,1,-1) * WorldReflectionVector(IN, o.Normal)).rgb; // We can change rgb here by gbr for example to tweak the color of the reflection (kinda X-Ray)

			// o.Emission = texCUBE(_Cubemap, IN.worldRefl).rgb; // Put only this line (remove all others) to get a mirrored
																 // "disco-ball" shading when using a flat shaded model
		}
		ENDCG
	}
	FallBack "Diffuse"
}
