// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Example/AdvancedHologram" {

	// Similar to 37-38 but it also combines the rimmed hologram effect with a base color plus a base texture
	// Aditionally, it allows to control the transparency level and even the direction of the transparency (in-out or out-in)
	// and allows to configure a kind of scanline animation so to better simulate the hologram effect as well as simple flickering and wobbling

	Properties
	{
		_MainColor ("Main Color", Color) = (0,0,0,1)
		_MainTex ("MainTexture", 2D) = "white" {}
		_MainColorIntensity ("Main Color Intensity", Range(0,2)) = 1
		_RimColor ("Rim Color", Color) = (0,0,0,1)
		_RimThreshold ("Rim Threshold", Range(0,1)) = 0.5
		_RimIntensity ("Rim Intensity", Range(0,2)) = 0.5
		_RimPower ("Rim Power", Range(0,5)) = 0.5
		_TransparencySlider ("Transparency Amount", Range(-1,1)) = 0
		[Toggle] _InOutTransparency ("Transparency In-Out or Out-In", Float) = 0
		_ScanlineAmount ("Scanline Amount", Range(1,100)) = 10
		_ScanlineThreshold ("Scanline Thresohold", Range(0,1)) = 0.1
		_ScanlineFreq ("Scanline Frequency", Range(1,50)) = 10
		_WobbleFreq ("Wobble Frequency", Range(0,100)) = 1
		_WobbleSpeed ("Wobble Speed", Range(0,100)) = 1
		_WobbleAmount ("Wobble Amount", Range(0.005,0.02)) = 0
	}

 	SubShader {

		Tags { "Queue" = "Transparent" }

		// Pass // FIXME: This pass doesn't work fine with the vertex modification done in the following pass...
		// {
		// 	ZWrite On
		// 	ColorMask 0
		// }

		// ZWrite Off

		CGPROGRAM

		#pragma surface surf Lambert alpha:fade vertex:vert // As there is no requirement to simulate a realistic material we use just a cheap Lambert lighting model

		sampler2D _MainTex;
		fixed4 _MainColor, _RimColor;
		half _RimThreshold, _MainColorIntensity, _RimIntensity, _RimPower, _TransparencySlider, _InOutTransparency;
		half _ScanlineAmount, _ScanlineThreshold, _ScanlineFreq, _WobbleFreq, _WobbleAmount, _WobbleSpeed;

		struct Input
		{
			half2 uv_MainTex;
			float3 viewDir;
			float3 worldPos;
		};

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input,o);

			float vibrationHeight = sin(v.vertex.x * _WobbleFreq + _Time.y*_WobbleSpeed) * _WobbleAmount + cos(v.vertex.x * _WobbleFreq*2 + _Time*2) * _WobbleAmount;
			
			v.vertex.y += vibrationHeight;
			v.vertex.x += vibrationHeight;
			v.normal = normalize(float3(v.normal.x + vibrationHeight, v.normal.y, v.normal.z + vibrationHeight)); // Update normal so to get proper Lighting

			o.worldPos = mul(unity_ObjectToWorld, v.vertex);
		}

		void surf (Input IN, inout SurfaceOutput o)
		{
			fixed4 tex = tex2D(_MainTex, IN.uv_MainTex);

			float dotn = saturate(abs(dot(o.Normal, IN.viewDir)));
			float transp = _InOutTransparency ? saturate(dotn + _TransparencySlider) : 1-saturate(dotn + _TransparencySlider);

			o.Emission = dotn > _RimThreshold ? lerp(_RimColor, _MainColor+tex, dotn) * _MainColorIntensity : _RimColor * (1-pow(dotn,_RimPower)) * _RimIntensity;

			o.Alpha = frac(_Time.y) < _ScanlineThreshold ? 0.25 : frac(_Time.y*0.5) > (0.85 + _ScanlineThreshold) ? 0.2:
					  frac(IN.worldPos.y*_ScanlineAmount + _Time.y*_ScanlineFreq) > _ScanlineThreshold ? 0.5 :
					  transp;
		}

		ENDCG
	}

	FallBack "Diffuse"
}