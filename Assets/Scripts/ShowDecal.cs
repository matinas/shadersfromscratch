using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ShowDecal : MonoBehaviour {

	Material material;
	bool isShown;

	// Use this for initialization
	void Start ()
	{
		material = GetComponent<Renderer>().sharedMaterial;
		isShown = false;
	}

	void OnMouseDown()
	{
		isShown = !isShown;

		if (isShown)
			material.SetFloat("_ShowDecal",1);
		else
			material.SetFloat("_ShowDecal",0);
	}

	void Update()
	{

	}
}
