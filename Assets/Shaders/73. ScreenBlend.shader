Shader "Example/ScreenBlend" {

	// Allows to blend the actual content of the screen with a given texture using different blend modes
	// This shader must be used together with the BlendRenderImage script applied to the Camera

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_BlendTex ("Blend Texture", 2D) = "white" {}
		_BlendMode ("Blend Mode", Range(0,2)) = 0 // 0: Multiply, 1: Additive, 2: Screen Blend, 3: Overlay Blend
		_Opacity ("Blend Texture Opacity", Range(0,1)) = 0
	}

 	SubShader {

		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex, _BlendTex;
			uniform half _BlendMode, _Opacity;
	
			fixed OverlayBlendMode(fixed basePixel, fixed blendPixel)
			{
				if (basePixel < 0.5)
				{
					return (2.0 * basePixel * blendPixel);
				}
				else
				{
					return (1.0 - 2.0 * (1.0-basePixel) * (1.0-blendPixel));
				}
			}

			fixed4 frag(v2f_img i) : SV_TARGET
			{
				// Get colors from the render texture and UVs from v2f_img struct
				fixed3 renderTex = tex2D(_MainTex, i.uv).rgb;
				fixed3 blendTex = tex2D(_BlendTex, i.uv).rgb;

				fixed3 blendedRenderTex = 0;
				switch(_BlendMode)
				{
					case 0: // Multiply
					{
						blendedRenderTex = renderTex * blendTex;
						break;
					}
					case 1: // Additive
					{
						blendedRenderTex = renderTex + blendTex;
						break;
					}
					case 2: // Screen Blend
					{
						blendedRenderTex = 1.0 - ((1.0 - renderTex) * (1.0 - blendTex));
						break;
					}
					case 3: // Overlay Blend
					{
						blendedRenderTex.r = OverlayBlendMode(renderTex.r, blendTex.r);
						blendedRenderTex.g = OverlayBlendMode(renderTex.g, blendTex.g);
						blendedRenderTex.b = OverlayBlendMode(renderTex.b, blendTex.b);

						break;
					}
				}

				fixed3 finalBlend = lerp(renderTex, blendedRenderTex, _Opacity); // Blend the original Render Texture with the blended one

				return fixed4(finalBlend,1);
			}

			ENDCG
		}
	}

	FallBack Off
}