Shader "SFS/Billboard" {
	
	// Shades the geometry with transparency considering it will be used as part of a billboard
	// so it is drawn from both sides (front-face and back-face, no back-face culling)

	Properties
	{
		_MainTex ("Main Texture", 2D) = "black" {}
	}

	SubShader {

		Tags { "Queue" = "Transparent" }

		Blend SrcAlpha OneMinusSrcAlpha
		Cull Off

		Pass
		{
			SetTexture [_MainTex] { combine texture } // Note from Unity doc: SetTexture commands have no effect when fragment programs are used;
													  // as in that case pixel operations are completely described in the shader. It is advisable to use
													  // programmable shaders these days instead of SetTexture commands.
		}
	}

	FallBack "Diffuse"
}
