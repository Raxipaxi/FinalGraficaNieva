using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrownPos : MonoBehaviour
{
    public Material mat;
    private Transform _transform;

    private Vector3 _tempPos;
    
  // [SerializeField] private float degreesPerSecond = 15.0f;
    [SerializeField] private float amplitude = 0.5f;
    [SerializeField] private float frequency = 1f;

    // Start is called before the first frame update
    void Start()
    {
        _transform = transform;
        _tempPos = _transform.position;
    }

    // Update is called once per frame
    void Update()
    {
        mat.SetVector("_Point", transform.position);

        _tempPos.y += Mathf.Lerp(_tempPos.y, (Mathf.Sin(Time.fixedTime * Mathf.PI * frequency) * amplitude), 10f / 2f);
     
        _transform.position = _tempPos;
    }
}
