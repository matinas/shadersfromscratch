// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "SFS/LightingSimpleLambert" {

	// Shades the geometry with a basic form of a custom Lambert lightinng

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}

 	SubShader {

    	Tags { "RenderType"="Opaque" }
 
    	CGPROGRAM

    	#pragma surface surf SimpleLambert // As we redefined the lighting model function the program expects to find a LightingSimpleLighting function
 
    	sampler2D _MainTex;
 
    	struct Input
		{
        	float2 uv_MainTex;
    	};
 
    	void surf (Input IN, inout SurfaceOutput o)
    	{
            o.Albedo = tex2D(_MainTex,IN.uv_MainTex).rgb;
    	}

		half4 LightingSimpleLambert(SurfaceOutput s, half3 lightDir, half atten)
		{
			half3 NdotL = dot(s.Normal, lightDir);

			half4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten * 2); // LightColor0 maintains the intensity of all lights affecting the object, not just one
			color.a = s.Alpha;

			return color;
		}

    	ENDCG
 }

 FallBack "Diffuse"
}