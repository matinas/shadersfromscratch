// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "SFS/LightingSimpleBlinnPhong" {

	// Shades the geometry with a basic form of a custom Blinn Phong
	// lightinng including a simple Sin-based color change over time

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_DiffuseColor ("Diffuse Color", Color) = (0,0,0,1)
		_Specular ("Specular Coverage", Range(0,1)) = 0.5
		_SpecColor ("Specular Color", Color) = (0,0,0,1) // This one is already declared by Unity as part if the the CGPROGRAM so we don't have to
		_Shininness ("Shininness", Range(0,100)) = 1
	}

 	SubShader {

    	Tags { "RenderType"="Opaque" }
 
    	CGPROGRAM

    	#pragma surface surf SimpleBlinnPhong // As we redefined the lighting model function the program expects to find a LightingSimpleLighting function
 
    	sampler2D _MainTex;
		fixed4 _DiffuseColor;
		half _Specular, _Shininness;
 
    	struct Input
		{
        	float2 uv_MainTex;
    	};
 
    	void surf (Input IN, inout SurfaceOutput o)
    	{
            o.Albedo = _DiffuseColor + tex2D(_MainTex,IN.uv_MainTex).rgb;
			o.Specular = _Specular;
    	}

		half4 LightingSimpleBlinnPhong(SurfaceOutput s, half3 lightDir, fixed3 viewDir, half atten)
		{
			half NdotL_dif = max(0,dot(s.Normal, lightDir));

			half3 halfv = normalize(lightDir + viewDir);
			half NdotL_spec = max(0,dot(s.Normal, halfv));

			half3 diff = s.Albedo * NdotL_dif;
			half3 spec = s.Specular * _SpecColor * pow(NdotL_spec, _Shininness); // Just a note: Unity uses 48 as the Shininness factor by default

			half4 color;
			color.rgb = (diff + spec) * _LightColor0.rgb * atten * _SinTime.z; // LightColor0 maintains the intensity of all lights affecting the object, not just one

			color.a = s.Alpha;

			return color;
		}

    	ENDCG
 }

 FallBack "Diffuse"
}