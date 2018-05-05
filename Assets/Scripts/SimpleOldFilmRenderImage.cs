using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent (typeof(Camera))]
public class SimpleOldFilmRenderImage : MonoBehaviour {

	#region Properties
	public Material material
	{
		get
		{
			if (curMaterial == null)
			{
				curMaterial = new Material(curShader);
				curMaterial.hideFlags = HideFlags.HideAndDontSave;
			}

			return curMaterial;
		}
	}
	#endregion

	#region Variables
	private Material curMaterial;
	public Shader curShader;

	public Texture2D vignetteTex;

	[Range(0.0f,1.0f)]
	public float vignetteOpacity;

	public Color filmColor;
	

	public Texture2D noiseTex;

	public Texture2D dustTex;

	[Range(0,1)]
	public float dustJumpiness;

	public Texture2D scratchTex;

	[Range(0,1)]
	public float scratchJumpiness;

	[Range(0,100)]
	public float flickeringSpeed;

	#endregion

	// Use this for initialization
	void Start ()
	{
		if (!SystemInfo.supportsImageEffects)
		{
			enabled = false;
			return;
		}

		if (curShader && !curShader.isSupported)
		{
			enabled = false;
		}

		Camera.main.depthTextureMode = DepthTextureMode.Depth;
	}
	
	void Update ()
	{
	}

	void OnRenderImage(RenderTexture srcTexture, RenderTexture dstTexture)
	{
		if (curShader != null)
		{
			material.SetTexture("_VignetteTex", vignetteTex);
			material.SetFloat("_VignetteOpacity", vignetteOpacity);
			material.SetTexture("_NoiseTex", noiseTex);
			material.SetTexture("_DustTex", dustTex);
			material.SetTexture("_ScratchTex", scratchTex);
			material.SetColor("_FilmColor", filmColor);
			material.SetFloat("_FlickeringSpeed", flickeringSpeed);
			material.SetFloat("_DustJumpiness", dustJumpiness);
			material.SetFloat("_ScratchJumpiness", scratchJumpiness);

			Graphics.Blit(srcTexture,dstTexture,material);
		}
		else
			Graphics.Blit(srcTexture,dstTexture);
	}

	void OnDisable()
	{
		if (curMaterial)
		{
			DestroyImmediate(curMaterial);
		}
	}
}
