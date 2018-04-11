Shader "SFS/Decal" {
	
	// Shades the geometry using a decal texture. All pixels will be we visible except for black ones

	Properties
	{
		_MainTex ("Main Texture", 2D) = "black" {}
	}

	SubShader {

		Tags { "Queue" = "Transparent" }

		Blend One One

		Pass
		{
			SetTexture [_MainTex] { combine texture } // Note from Unity doc: SetTexture commands have no effect when fragment programs are used;
													  // as in that case pixel operations are completely described in the shader. It is advisable to use
													  // programmable shaders these days instead of SetTexture commands.
		}
	}

	FallBack "Diffuse"
}
