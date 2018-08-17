Shader "Example/ScreenBSC" {

	// Allows to change Brightness, Saturation and Contrast of image on screen
	// This shader must be used together with the BSCRenderImage script applied to the Camera

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_Brightness ("Brightness", Range(0,1)) = 0
		_Saturation ("Saturation", Range(0,1)) = 0
		_Contrast ("Contrast", Range(0,1)) = 0
	}

 	SubShader {

		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform fixed _Brightness, _Saturation, _Contrast;
	
			fixed3 BSC(fixed3 color, fixed brt, fixed sat, fixed con)
			{
				float AvgLuminR = 0.5;
				float AvgLuminG = 0.5;
				float AvgLuminB = 0.5;

				fixed3 AvgLumin = float3(AvgLuminR, AvgLuminG, AvgLuminB);

				float3 LuminanceCoeff = float3(0.2125, 0.7154, 0.0721); // Stores the values that will give us the overall brightness of the current image
																		// Coefficients are based on the CIE color matching functions and are pretty standard
																		// Luminance is basically brightness information in an image minus the color
				fixed3 brtColor = color * brt;

				float intensityF = dot(brtColor, LuminanceCoeff); 		// Overall brightness of the image

				fixed3 intensity = float3(intensityF, intensityF, intensityF);

				fixed3 satColor = lerp(intensity, brtColor, sat);		// Blend from the grayscale version of the image with brightness applied, and the image alone with brightness applied
				fixed3 conColor = lerp(AvgLumin, satColor, con);		// Blend from the average luminance color and the actual color (already saturated and brightened)

				return conColor;
			}

			fixed4 frag(v2f_img i) : SV_TARGET
			{
				// Get colors from the render texture and UVs from v2f_img struct
				fixed4 renderTex = tex2D(_MainTex, i.uv);

				return fixed4(BSC(renderTex.rgb, _Brightness, _Saturation, _Contrast),1);
			}

			ENDCG
		}
	}

	FallBack Off
}