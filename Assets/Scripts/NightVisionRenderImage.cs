using System.Collections;
using System.Collections.Generic;
using UnityEngine;

// This scripts allows to visualize the depth of the scene as a screen effect
// NOTE: it's not working 100% fine...

[ExecuteInEditMode]
[RequireComponent (typeof(Camera))]
public class NightVisionRenderImage : MonoBehaviour {

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

	public float nightVisionEffectAmount = 1.0f;

	public Color greenColor = Color.white;

	public Texture2D vignetteTex;

	public float vignetteAmount = 1.0f;

	public Texture2D scanlinesTex;

	[Range(1,10)]
	public float scanlinesYScale;

	[Range(0,5)]
	public float scanlinesIntensity;

	public float scanlinesEffectAmount;

	public Texture2D noiseTex;

	[Range(1,10)]
	public float noiseXScale;

	[Range(1,10)]
	public float noiseYScale;

	[Range(1,10)]
	public float noiseXSpeed;

	[Range(1,10)]
	public float noiseYSpeed;

	public float noiseEffectAmount;

	public float distortion;

	public float scale;

	public float randomValue;

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
		nightVisionEffectAmount = Mathf.Clamp(nightVisionEffectAmount, 0.0f, 1.5f);
		scanlinesEffectAmount = Mathf.Clamp(scanlinesEffectAmount, 0.0f, 1.0f);
		noiseEffectAmount = Mathf.Clamp(noiseEffectAmount, 0.0f, 1.0f);
		distortion = Mathf.Clamp(distortion, -1.0f, 1.0f);
		scale = Mathf.Clamp(scale, 1.0f, 3.0f);

		randomValue = Random.Range(-1.0f,1.0f);
	}

	void OnRenderImage(RenderTexture srcTexture, RenderTexture dstTexture)
	{
		if (curShader != null)
		{
			material.SetColor("_GreenColor", greenColor);
			material.SetFloat("_VignetteAmount", vignetteAmount);
			material.SetFloat("_EffectAmount", nightVisionEffectAmount);
			material.SetFloat("_Distortion", distortion);
			material.SetFloat("_Scale", scale);
			material.SetFloat("_RandomValue", randomValue);

			if (vignetteTex)
			{
				material.SetTexture("_VignetteTex", vignetteTex);
			}

			if (scanlinesTex)
			{
				material.SetTexture("_ScanlinesTex", scanlinesTex);
				material.SetFloat("_ScanlinesYScale", scanlinesYScale);
				material.SetFloat("_ScanlinesIntensity", scanlinesIntensity);
				material.SetFloat("_ScanlinesEffectAmount", scanlinesEffectAmount);
			}

			if (noiseTex)
			{
				material.SetTexture("_NoiseTex", noiseTex);
				material.SetFloat("_NoiseXScale", noiseXScale);
				material.SetFloat("_NoiseYScale", noiseYScale);
				material.SetFloat("_NoiseXSpeed", noiseXSpeed);
				material.SetFloat("_NoiseYSpeed", noiseYSpeed);
				material.SetFloat("_NoiseEffectAmount", noiseEffectAmount);
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
