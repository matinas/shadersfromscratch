Shader "Example/ExplodeEffect" {

	// Makes an explosion effect based on the geometry of a sphere
	// and a ramp and noise texture for setting the color

	Properties
	{
		_RampTex ("Ramp Texture", 2D) = "black" {}
		_NoiseTex ("Noise Texture", 2D) = "black" {}
		_Freq ("Frequency", Range(0,2)) = 1
		_Amount ("Amount", Range(0,2)) = 1
		_Speed ("Speed", Range(-5,5)) = 1
		_NoiseOffset ("Noise Offset", Range(-2,2)) = 0.2
		_RampOffset ("Ramp Offset", Range(-0.5,0.5)) = 0
		_ClipRange ("Clip Range", Range(0,1)) = 0
	}

 	SubShader {

    	CGPROGRAM

    	#pragma surface surf Lambert vertex:vert nolightmap
 
		sampler2D _RampTex, _NoiseTex;
		float _RampOffset, _Amount, _Freq, _Speed, _NoiseOffset, _ClipRange;
 
    	struct Input
		{
        	fixed2 uv_NoiseTex;
    	};
 
		void vert(inout appdata_full v)
		{
			float rand = tex2Dlod(_NoiseTex, float4(v.texcoord.xy,0,0)).r;
			float noise = sin(_Time.w * _Freq + rand * _Speed) + _NoiseOffset; // NoiseOffset allows to set a minimum vertex distorsion, so it doesn't seems like a star for example

			v.vertex.xyz += v.normal * _Amount * noise * rand;
		}

		void surf (Input IN, inout SurfaceOutput o)
		{
			float rand = tex2D(_NoiseTex, IN.uv_NoiseTex).r;
			float rampRand = saturate(rand + _RampOffset); // Allows to set whether we get more samples from the right side (light) or the left side (dark) of the ramp texture

			clip(_ClipRange - rampRand); // Avoid drawing some of the pixels to eventually allow simulating post-explode distorsion

			fixed4 c = tex2D(_RampTex, float2(rampRand,0.5));
			
			o.Albedo = c.rgb;
			o.Emission = c.rgb * c.a;
		}

    	ENDCG
	}

	FallBack "Diffuse"
}