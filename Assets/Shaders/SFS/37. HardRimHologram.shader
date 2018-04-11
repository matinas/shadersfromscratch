Shader "SFS/HardRimHologram" {
	
	// Creates a Rim effect highlighting just the borders of the geometry with the given color and
	// intensity parameters, considering also a threshold used to control the start of the Rim area.
	// The shading is also done so that the geometry gets more transparent at the center and less
	// transparent at the edges achieving a kind of a Hologram effect

	Properties
	{
		_RimColor ("Rim Color", Color) = (0,0.5,0.5,1)
		_RimPower ("Rim Power", Range(0.5,10)) = 3.0
		_RimIntensity ("Rim Intensity", Range(0.1,10)) = 1.0
		_RimThreshold ("Rim Threshold", Range(0.0,0.9)) = 0
		_Transparency ("Transparency Intensity", Range(0,1)) = 1
	}

	SubShader {

		Tags { "Queue" = "Transparent" }

		Pass
		{
			ZWrite On	// Write the geometry to the Z buffer (as it won't otherwise cause its transparent). This will avoid drawing self overlapping geometry
			ColorMask 0 // There's not need to write to the frame/color buffer
		}

		CGPROGRAM

		#pragma surface surf Lambert alpha:fade

		fixed4 _RimColor;
		float _RimPower, _RimIntensity, _RimThreshold, _Transparency;

		struct Input
		{
			fixed3 viewDir;
		};

		void surf (Input IN, inout SurfaceOutput o)
		{
			half rim = 1 - saturate(dot(o.Normal,IN.viewDir));

			o.Emission = _RimColor * (rim > _RimThreshold ? pow(rim,_RimPower) : 0) * _RimIntensity;
			o.Alpha = (1 - _Transparency) * pow(rim,_RimPower);
		}
		
		ENDCG
	}

	FallBack "Diffuse"
}
