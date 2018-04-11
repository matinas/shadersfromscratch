Shader "SFS/SimpleBlend" {
	
	// Shades the geometry using a few different blend approaches

	Properties
	{
		_MainTex ("Main Texture", 2D) = "black" {}
	}

	SubShader {

		Tags { "Queue" = "Transparent" }

		// Blend One One
		Blend SrcAlpha OneMinusSrcAlpha // This one is the traditional blend that happens when we set transparency. In particular, it will multiply the texture
										// color by its alpha (SrcAlpha), multiply the frame buffer color by 1-alpha (OneMinusSrcAlpha), and add them together
		// Blend DstColor Zero

		Pass
		{
			SetTexture [_MainTex] { combine texture } // Note from Unity doc: SetTexture commands have no effect when fragment programs are used;
													  // as in that case pixel operations are completely described in the shader. It is advisable to use
													  // programmable shaders these days instead of SetTexture commands.
		}
	}

	FallBack "Diffuse"
}
