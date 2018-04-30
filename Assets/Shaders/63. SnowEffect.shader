Shader "Example/SnowEffect" {

	// Shades the geometry with a given texture and color adding an effect so part
	// of the geometry gets whitened as it was snow. The direction, color and amount
	// of snow is configurable through a couple of input parameters

	Properties
	{
		_MainTex ("Main Texture", 2D) = "black" {}
		_SnowColor ("Snow Color", Color) = (1,1,1,1)
		_SnowAmount ("Snow Amount", Range(0,0.05)) = 0
		_SnowDirection ("Snow Direction", Vector) = (0,1,0)
		_SnowDirThreshold ("Snow Direction Threshold", Range(0,1)) = 0
	}

 	SubShader {

    	CGPROGRAM

    	#pragma surface surf Lambert vertex:vert
 
		sampler2D _MainTex;
		fixed3 _SnowColor;
		float3 _SnowDirection;
		float _SnowAmount, _SnowDirThreshold;
 
    	struct Input
		{
        	fixed2 uv_MainTex;
			float dotsnowdir;
    	};
 
		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);

			// Convert _SnowDirection from world space to object space so the snow falls from _SnowDirection even if the object is rotated
			// It also negates the X coordinate because the Zombunny with which we tried has a weird rotation by default
			float4 sn = mul(_SnowDirection, unity_WorldToObject);
			sn.x *= -1;

			o.dotsnowdir = dot(v.normal, sn);
			if (o.dotsnowdir >= _SnowDirThreshold)
				v.vertex.xyz += v.normal*_SnowAmount;
		}

		void surf (Input IN, inout SurfaceOutput o)
		{
			o.Albedo = (IN.dotsnowdir >= _SnowDirThreshold) ? _SnowColor.rgb : tex2D(_MainTex, IN.uv_MainTex).rgb;
			o.Alpha = 1;
		}

    	ENDCG
	}

	FallBack "Diffuse"
}