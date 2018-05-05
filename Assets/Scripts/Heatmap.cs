using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class Heatmap : MonoBehaviour {

	public Vector3[] points;
	public Vector2[] properties;

	public Material material;

	// Use this for initialization
	void Start ()
	{
		material.SetInt("_Points_Length", points.Length);

		for (int i=0; i<points.Length; i++)
		{
			material.SetVector("_Points" + i.ToString(), points[i]);
			material.SetVector("_Properties" + i.ToString(), properties[i]);
		}
	}
}
