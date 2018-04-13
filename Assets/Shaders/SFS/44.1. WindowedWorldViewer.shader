Shader "SFS/WindowedWorldViewer" {
	
	// Writes the geometry to the stencil buffer given the Ref number, the Comp function to use and the
	// Operation to apply on the buffer. These parameters are passed as an input to the shader so they
	// can be set per-material (they should be set with the values added as a comment in the Stencil section)
	// Note that the shader does not write to the Frame Buffer (ColorMarsk 0), it does only fills the stencil

	Properties
	{
		_MainTex ("Main Texture", 2D) = "white" {}

		_SRef("Stencil Ref", Float) = 1
		[Enum(UnityEngine.Rendering.CompareFunction)] _SComp("Stencil Comparison Function", Float) = 8
		[Enum(UnityEngine.Rendering.StencilOp)] _SOp("Stencil Operation", Float) = 2
	}

	SubShader {

		Tags { "Queue" = "Geometry-1" }

		ZWrite Off
		ColorMask 0

		Stencil
		{
			Ref[_SRef]		// 1 or the proper window ID
			Comp[_SComp]	// always
			Pass[_SOp]		// replace
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