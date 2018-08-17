Shader "Example/ScreenSimpleOldFilm" {

	// Allows to simulate an old film effect including Sepia Tone effect, Vignette Effect and Dust and Scratches
	// This shader must be used together with the SimpleOldFilmRenderImage script applied to the Camera
	// A few examples of this kind of effect: https://www.youtube.com/watch?v=Y0QOpCwKyGI and https://www.youtube.com/watch?v=hlIDspN0d34

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}
		_FilmColor ("Film Color", Color) = (0,0,0,1)
		_VignetteTex ("Vignette Texture", 2D) = "white" {}
		_VignetteOpacity ("Vignette Opacity", Range(0,1)) = 0
		_NoiseTex ("Noise Texture", 2D) = "white" {}
		_DustTex ("Dust Texture", 2D) = "white" {}
		_DustJumpiness ("Dust Jumpiness", Range(0,1)) = 0.25
		_ScratchTex ("Scratch Texture", 2D) = "white" {}
		_FlickeringSpeed ("Flickering Speed", Range(0,100)) = 0
		_ScratchJumpiness ("Scratch Jumpiness", Range(0,1)) = 0.25
	}

 	SubShader {

		Pass
		{
			CGPROGRAM
			
			#pragma vertex vert_img
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest

			#include "UnityCG.cginc"

			uniform sampler2D _MainTex, _VignetteTex, _NoiseTex, _DustTex, _ScratchTex;
			uniform half _VignetteOpacity, _FlickeringSpeed, _DustJumpiness, _ScratchJumpiness;
			uniform fixed4 _FilmColor;
	
			fixed4 frag(v2f_img i) : SV_TARGET
			{
				// Fill pseudorandom numbers data
				// TODO: this random value could have been passed directly from the SimpleOldFilmRenderImage script (updated every frame in the Update() like random=Random.Range(-1f,1f))
				fixed3 noise = tex2D(_NoiseTex, i.uv);
				float sinT = sin(_Time.x);
				float rand = sin(sinT + noise.r); 

				// Get colors from the render and vignette textures and UVs from v2f_img struct
				fixed3 renderTex = tex2D(_MainTex, i.uv).rgb;
				fixed3 vignetteTex = tex2D(_VignetteTex, i.uv).rgb;

				 // Apply Sepia Tone and Flickering effect

				float3 LuminanceCoeff = float3(0.2125, 0.7154, 0.0721); // These coefficients are based on the CIE color matching functions and are pretty standard
				float intensityF = dot(renderTex, LuminanceCoeff);
				fixed3 baseIntensity = float3(intensityF, intensityF, intensityF);

				baseIntensity = lerp(baseIntensity, baseIntensity+0.35, floor(frac(_SinTime.y*_FlickeringSpeed) + 0.9)*0.2); // Simple Sin-based Flickering

				renderTex = baseIntensity + _FilmColor.rgb;

				// Apply Vignette effect

				fixed3 blendTex = renderTex * vignetteTex;
				fixed3 vignetteBlend = lerp(renderTex, blendTex, _VignetteOpacity); // Blend the actual render texture with the vignette blended one

				// Apply Dust effect

				// We use floor to simulate a "low frame rate" effect (so the movement is a bit jumpy/discrete)
				// For example, the displacement in X will be 0 until times reaches 1, when the displacement will be _DustJumpiness, and so on
				fixed3 dustTex = tex2D(_DustTex, i.uv*2 + float2(floor(_Time.w + rand)*_DustJumpiness, floor(_Time.w*4 + rand)*_DustJumpiness));

				// Apply Scratches Effect

				fixed3 scratchTex = tex2D(_ScratchTex, i.uv + float2(floor(_Time.w*4 + rand)*_ScratchJumpiness, rand*20));

				// Generate final blend...

				fixed3 finalBlend = vignetteBlend * dustTex * scratchTex;

				return fixed4(finalBlend,1);
			}

			ENDCG
		}
	}

	FallBack Off
}