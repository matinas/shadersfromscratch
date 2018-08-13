// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Example/ScreenGrayscale" {

	// Applies a grayscale screen effect given the actual Unity Render Texture as an input
	// This shader must be used together with the GrayscaleRenderImage script applied to the Camera

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_LuminosityAmount ("Grayscale Amount", Range(0,1)) = 1
	}

 	SubShader {

		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert_img // Use the Unity predefined vertex function which does just the basics (otherwise we have to include our own basic vert)
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float _LuminosityAmount;
	
			fixed4 frag(v2f_img i) : SV_TARGET
			{
				// Get colors from the render texture and UVs from v2f_img struct
				fixed4 renderTex = tex2D(_MainTex, i.uv);

				float luminosity = 0.299 * renderTex.r + 0.587 * renderTex.g + 0.114 * renderTex.b; // Setup grayed out version of the actual screen image (check luminosity value here: https://stackoverflow.com/questions/596216/formula-to-determine-brightness-of-rgb-color)
				fixed4 finalColor = lerp(renderTex, luminosity, _LuminosityAmount);					// Interpolate between screen imagen and grayed out version

				return finalColor;
			}

			ENDCG
		}
	}
}