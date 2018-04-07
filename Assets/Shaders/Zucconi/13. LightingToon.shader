// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "Example/LightingToon" {

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_RampTex ("Ramp (RGB)", 2D) = "white" {}
	}

 	SubShader {

    	Tags { "RenderType"="Opaque" }
 
    	CGPROGRAM

    	#pragma surface surf Toon // As we redefined the lighting model function the program expects to find a LightingToon function
 
    	sampler2D _MainTex;
		 
    	struct Input
		{
        	float2 uv_MainTex;
    	};
 
    	void surf (Input IN, inout SurfaceOutput o)
    	{
            o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
    	}

		sampler2D _RampTex;

		fixed4 LightingToon(SurfaceOutput s, half3 lightDir, half atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));

			fixed4 color;
			color.rgb = s.Albedo * _LightColor0.rgb * (NdotL * atten * 2);
			color.a = s.Alpha;

			return color;
		}

    	ENDCG
 }

 FallBack "Diffuse"
}