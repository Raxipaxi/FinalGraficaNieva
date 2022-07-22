using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Solarice : MonoBehaviour
{
    public Shader shader;
    Material mat;

    public Color colorA;

    public Color colorB;

    [Range(0, 1)] public float speed;
    // Start is called before the first frame update
    void Start()
    {
        mat = new Material(shader);
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetColor("_colorA", colorA);   
        mat.SetColor("_colorB", colorB);   
        mat.SetFloat("_speed", speed);
    }
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, mat);
    }
}
