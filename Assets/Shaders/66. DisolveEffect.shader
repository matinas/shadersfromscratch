Shader "Example/DisolveEffect" {

	// Disolves the geometry from top to bottom as if it is burning/melting
	// It uses a kind of fire texture and a noise texture to achieve the non-uniform burning effect

	Properties
	{
		_MainTex ("Main Texture", 2D) = "black" {}
		_BumpTex ("Bump Texture", 2D) = "black" {}
		_Bump ("Bump Amount", Range(0,10)) = 1
		_RampTex ("Ramp Texture", 2D) = "black" {}
		_NoiseTex ("Noise Texture", 2D) = "black" {}
		_RampOffset ("Ramp Offset", Range(-0.5,0.5)) = 0
		_ClipRange ("Clip Range", Range(-2,1)) = 0
		_BurnThreshold ("Burn Threshold", Range(0,10)) = 0.2
		_BurnIntensity ("Burn Intensity", Range(0,10)) = 5
	}

 	SubShader {

    	CGPROGRAM

    	#pragma surface surf Lambert nolightmap
 
		sampler2D _MainTex, _BumpTex, _RampTex, _NoiseTex;
		float _RampOffset, _ClipRange, _BurnThreshold, _Bump, _BurnIntensity;
 
    	struct Input
		{
        	fixed2 uv_MainTex;
			fixed2 uv_NoiseTex;
			float3 worldPos;
    	};
 
		void surf (Input IN, inout SurfaceOutput o)
		{
			float rand = tex2D(_NoiseTex, IN.uv_NoiseTex).r;
			float rampRand = saturate(rand + _RampOffset);

			o.Normal = UnpackNormal(tex2D(_BumpTex, IN.uv_MainTex));
			o.Normal *= float3(_Bump,_Bump,1);

			float clipLine = (_ClipRange - IN.worldPos.y) + sin(rand);

			clip(clipLine);

			// One alternative...
			o.Albedo = lerp(tex2D(_RampTex, float2(rampRand,0.5)).rgb*_BurnIntensity, tex2D(_MainTex, IN.uv_MainTex).rgb, saturate(clipLine*_BurnThreshold));

			// Another quite similar alternative... (for this case _BurnThreshold should be in [0,1])
			// if (clipLine > 0 && clipLine < _BurnThreshold)
			// 	o.Emission = tex2D(_RampTex, float2(rampRand,0.5)).rgb*_BurnIntensity;
			// else
			// 	o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

    	ENDCG
	}

	FallBack "Diffuse"
}