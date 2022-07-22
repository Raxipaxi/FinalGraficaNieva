using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Dizzy : MonoBehaviour
{
    public Shader shader;
    Material mat;
    [Range(0, 1)] public float speed;
    [Range(0, 1)] public float intensity;
    

    // Start is called before the first frame update
    void Start()
    {
        mat = new Material(shader);
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetFloat("_Intensity", intensity);
        mat.SetFloat("_Speed", speed);
        
    }
    
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        Graphics.Blit(source, destination, mat);
    }
}
