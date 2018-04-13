Shader "SFS/WindowedWorldObject" {
	
	// Writes the geometry considering ony what is into the corresponding stencil buffer (given by Ref).
	// The Comp function and the Operation to apply on the buffer are passed as an input to the shader
	// so they can be set per-material (they should be set with the values added as a comment in the Stencil section)
	// Note that the shader does write to the Frame Buffer (no ColorMarsk parameter)

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}

		_SRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comparison Function", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Operation", Float) = 2
	}

	SubShader {

		Tags { "Queue" = "Geometry+1" }

		Stencil
		{
			Ref[_SRef]		// 1 or the proper window ID
			Comp[_SComp]	// equal
			Pass[_SOp]		// keep
		}

		CGPROGRAM

		#pragma surface surf Standard

		sampler2D _MainTex;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		ENDCG
	}

	FallBack "Diffuse"
}