Shader "Example/AnisotropicSpecular" {

	// Shades the geometry with an Anisotropic Specular effect (similar to a specular
	// effect but in this case the specular area is concentric and seems brushed)

	Properties
	{
		_MainTex ("Main Texture", 2D) = "black" {}
		_MainColor("Main Color", Color) = (1,1,1,1)
		_Specular("Specular Intensity", Range(0,1)) = 0.5
		_SpecularColor("Specular Color", Color) = (1,1,1,1)
		_Shininness("Shininness", Range(0,1)) = 0.5
		_AnisoDir("Anisotropic Direction", 2D) = "" {} // NOTE: anisotropic normal map shouldn't be a Unity Normal Map texture
		_AnisoOffset(" Anisotropic Offset", Range(-1,1)) = 0.2
	}

 	SubShader {

    	CGPROGRAM

    	#pragma surface surf AnisotropicSpecular
 
		sampler2D _MainTex, _AnisoDir;
		fixed3 _MainColor, _SpecularColor;
		float _Specular, _Shininness, _AnisoOffset;
 
    	struct Input
		{
        	fixed2 uv_MainTex;
			fixed2 uv_AnisoDir;
    	};
 
		struct SurfaceAnisoOutput
		{
			fixed3 Albedo;
			fixed3 Emission;
			float3 Normal;
			fixed3 AnisoDir;
			half Specular;
			fixed Alpha;
			fixed Gloss;
		};

		void surf (Input IN, inout SurfaceAnisoOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex) + _MainColor;
			o.AnisoDir = UnpackNormal(tex2D(_AnisoDir, IN.uv_AnisoDir));
			o.Specular = _Specular;
			o.Gloss = _Shininness;
			o.Alpha = 1;
		}

		fixed4 LightingAnisotropicSpecular(SurfaceAnisoOutput s, half3 lightDir, half3 viewDir, half atten)
		{
			half ndotl = max(0, dot(s.Normal, lightDir));
			fixed3 diffuse = s.Albedo * ndotl;

			half3 halfv = normalize(lightDir + viewDir);
			half hdota = max(0, dot(normalize(s.Normal + s.AnisoDir), halfv));
			float aniso = max(0, sin(radians((hdota + _AnisoOffset)*180))); // Same as max(0, sin((hdota + _AnisoOffset)*UNITY_PI));

			float specular = saturate(pow(aniso, s.Gloss*128) * s.Specular) * _SpecularColor; // If we put hdota here instead of aniso we would get a kind of shifted specular lighting
																							  // But as we are using the sin function with aniso we get that consentric effect

			fixed4 color;
			color.rgb = (diffuse + specular) * _LightColor0.rgb * atten;
			color.a = s.Alpha;

			return color;
		}

    	ENDCG
	}

	FallBack "Diffuse"
}