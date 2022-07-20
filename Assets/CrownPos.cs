using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrownPos : MonoBehaviour
{
    public Material mat;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetVector("_Point", transform.position);
    }
}
