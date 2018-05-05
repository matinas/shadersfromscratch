using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
[RequireComponent (typeof(Camera))]
public class AdvancedOldFilmRenderImage : MonoBehaviour {

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

	public float oldFilmEffectAmount = 1.0f;

	public Color sepiaColor = Color.white;

	public Texture2D vignetteTex;

	public float vignetteAmount = 1.0f;

	public Texture2D dustTex;

	public float dustXSpeed = 10.0f;
	public float dustYSpeed = 10.0f;

	public Texture2D scratchesTex;

	public float scratchesXSpeed = 10.0f;
	public float scratchesYSpeed = 10.0f;

	private float randomValue; // This will be used instead of the NoiseTex in the previous solution

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
		vignetteAmount = Mathf.Clamp(vignetteAmount, 0.0f, 1.0f);
		oldFilmEffectAmount = Mathf.Clamp(oldFilmEffectAmount, 0.0f, 1.5f);

		randomValue = Random.Range(-1f,1f);
	}

	void OnRenderImage(RenderTexture srcTexture, RenderTexture dstTexture)
	{
		if (curShader != null)
		{
			material.SetColor("_SepiaColor", sepiaColor);
			material.SetFloat("_VignetteAmount", vignetteAmount);
			material.SetFloat("_EffectAmount", oldFilmEffectAmount);

			if (vignetteTex)
			{
				material.SetTexture("_VignetteTex", vignetteTex);
			}

			if (scratchesTex)
			{
				material.SetTexture("_ScratchesTex", scratchesTex);
				material.SetFloat("_ScratchesXSpeed", scratchesXSpeed);
				material.SetFloat("_ScratchesYSpeed", scratchesYSpeed);
			}
			
			if (dustTex)
			{
				material.SetTexture("_DustTex", dustTex);
				material.SetFloat("_DustXSpeed", dustXSpeed);
				material.SetFloat("_DustYSpeed", dustYSpeed);
				material.SetFloat("_RandomValue", randomValue);
			}
			
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
