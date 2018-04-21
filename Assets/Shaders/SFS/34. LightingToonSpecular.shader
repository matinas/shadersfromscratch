// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "SFS/RampAlbedo" {

	// Shades the geometry by applying a ramp map to the surface albedo based on the normal
	// and the view direction to determine the UVs. It uses a Blinn-Phong shading to support specular highlights

	Properties {
		_Color ("Base Color", Color) = (1,1,1,1)
		_RampTex ("Ramp (RGB)", 2D) = "white" {}
		_Offset ("Ramp Offset", Range(-1,1)) = 0
		_SpecColor ("Specular Color", Color) = (0,0,0,1) // This one is already declared by Unity as part if the the CGPROGRAM so we don't have to
		_Shininness ("Shininness", Range(0,1)) = 0
		_Specular ("Specular", Range(0,1)) = 0
	}

 	SubShader {

    	Tags { "RenderType"="Opaque" }
 
    	CGPROGRAM

    	#pragma surface surf BlinnPhong
 
    	sampler2D _RampTex;
		fixed4 _Color;
		half _Offset, _Shininness, _Specular;
		 
    	struct Input
		{
        	float2 uv_MainTex;
			fixed3 viewDir;
    	};
 
    	void surf (Input IN, inout SurfaceOutput o)
    	{
			half NdotL = dot(o.Normal, normalize(IN.viewDir)) + _Offset;

            o.Albedo = _Color + tex2D(_RampTex, fixed2(NdotL,0.5)).rgb;
			o.Specular = _Specular * _SpecColor;
			o.Gloss = _Shininness;
    	}

    	ENDCG
 }

 FallBack "Diffuse"
}