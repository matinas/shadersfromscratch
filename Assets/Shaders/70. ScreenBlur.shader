// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Example/ScreenBlur" {

	// Applies a blur screen effect given the actual Unity Render Texture as an input
	// This shader must be used together with the BlurRenderImage script applied to the Camera

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
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
			uniform float4 _MainTex_TexelSize;
			uniform float _BlurAmount;
	
			fixed4 frag(v2f_img i) : SV_TARGET
			{
				float tsize = _MainTex_TexelSize.x;

				// Get colors from the render texture and UVs from v2f_img struct
				fixed4 renderTex = tex2D(_MainTex, i.uv + float2(-tsize,-tsize)) + tex2D(_MainTex, i.uv + float2(-tsize,0)) +
								   tex2D(_MainTex, i.uv + float2(-tsize,-tsize)) + tex2D(_MainTex, i.uv + float2(0,-tsize)) +
								   tex2D(_MainTex, i.uv + float2(tsize,-tsize)) + tex2D(_MainTex, i.uv + float2(tsize,0)) +
								   tex2D(_MainTex, i.uv + float2(tsize,tsize)) + tex2D(_MainTex, i.uv + float2(0,tsize)) +
								   tex2D(_MainTex, i.uv);

				renderTex *= 0.1111; // Calculate average multiplying by 1/9

				return renderTex;
			}

			ENDCG
		}
	}
}