Shader "SFS/SimpleAlphaCutoff" {

	// Shades the geometry using the alpha channel of the main texture to drive the transparency
	// and it also enables alpha cutout transparency and shadows so the shadows get properly casted
	// NOT WORKING PROPERLY ANYWAY...

	Properties
	{
       _MainTex ("Base (RGB)", 2D) = "white" {}
    }

    SubShader
	{        
		Tags
		{
            "Queue" = "Transparent"
        }

        AlphaTest Greater 0.5

        CGPROGRAM

        #pragma surface surf Lambert alphatest:_Cutoff addshadow

        sampler2D _MainTex;

        struct Input
		{
            float2 uv_MainTex;
        };

        void surf(Input IN, inout SurfaceOutput o)
		{
            fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }

        ENDCG
    }

	FallBack "Transparent/Cutout/VertexLit"
}