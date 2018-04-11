// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

Shader "SFS/SimpleAlpha" {

	// Shades the geometry using the alpha channel of the main texture to drive the transparency

	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}

 	SubShader {

		// If we put Geometry here, as alpha objects do not write to ZBuffer every object behind this one will draw above it
		// When setting Transparency as the Queue we make sure that this object will be drawn after the rest

    	Tags { "Queue" = "Transparent" } 
 
    	CGPROGRAM

    	#pragma surface surf Lambert alpha:fade // Check this for the alpha parameters: https://docs.unity3d.com/Manual/SL-SurfaceShaders.html
 
    	sampler2D _MainTex;
 
    	struct Input
		{
        	float2 uv_MainTex;
    	};
 
    	void surf (Input IN, inout SurfaceOutput o)
    	{
			fixed4 c = tex2D(_MainTex,IN.uv_MainTex);
            o.Albedo = c.rgb;
			o.Alpha = c.a;
    	}

    	ENDCG
 }

 FallBack "Diffuse"
}