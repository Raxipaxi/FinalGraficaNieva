// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Wall"
{
	Properties
	{
		_FallOff("FallOff", Range( 0 , 1)) = 0
		_Scale("Scale", Range( 0 , 4)) = 0
		_DepthDistance("Depth Distance", Range( 0 , 1)) = 0
		_GeneralOpacity("GeneralOpacity", Range( 0 , 1)) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_PannerDirection("Panner Direction", Vector) = (0,0.05,0.05,0)
		_Noise("Noise", Range( 0 , 3)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 3.0
		#pragma surface surf Standard alpha:fade keepalpha exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float3 _PannerDirection;
		uniform float _Noise;
		UNITY_DECLARE_DEPTH_TEXTURE( _CameraDepthTexture );
		uniform float4 _CameraDepthTexture_TexelSize;
		uniform float _DepthDistance;
		uniform float _Scale;
		uniform float _FallOff;
		uniform float _GeneralOpacity;


		float3 mod2D289( float3 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float2 mod2D289( float2 x ) { return x - floor( x * ( 1.0 / 289.0 ) ) * 289.0; }

		float3 permute( float3 x ) { return mod2D289( ( ( x * 34.0 ) + 1.0 ) * x ); }

		float snoise( float2 v )
		{
			const float4 C = float4( 0.211324865405187, 0.366025403784439, -0.577350269189626, 0.024390243902439 );
			float2 i = floor( v + dot( v, C.yy ) );
			float2 x0 = v - i + dot( i, C.xx );
			float2 i1;
			i1 = ( x0.x > x0.y ) ? float2( 1.0, 0.0 ) : float2( 0.0, 1.0 );
			float4 x12 = x0.xyxy + C.xxzz;
			x12.xy -= i1;
			i = mod2D289( i );
			float3 p = permute( permute( i.y + float3( 0.0, i1.y, 1.0 ) ) + i.x + float3( 0.0, i1.x, 1.0 ) );
			float3 m = max( 0.5 - float3( dot( x0, x0 ), dot( x12.xy, x12.xy ), dot( x12.zw, x12.zw ) ), 0.0 );
			m = m * m;
			m = m * m;
			float3 x = 2.0 * frac( p * C.www ) - 1.0;
			float3 h = abs( x ) - 0.5;
			float3 ox = floor( x + 0.5 );
			float3 a0 = x - ox;
			m *= 1.79284291400159 - 0.85373472095314 * ( a0 * a0 + h * h );
			float3 g;
			g.x = a0.x * x0.x + h.x * x0.y;
			g.yz = a0.yz * x12.xz + h.yz * x12.yw;
			return 130.0 * dot( m, g );
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 panner23 = ( 1.0 * _Time.y * _PannerDirection.xy + i.uv_texcoord);
			float simplePerlin2D29 = snoise( panner23 );
			simplePerlin2D29 = simplePerlin2D29*0.5 + 0.5;
			float4 temp_cast_1 = (( simplePerlin2D29 * _Noise )).xxxx;
			float4 color14 = IsGammaSpace() ? float4(0.4103774,1,0.9915768,0) : float4(0.1402577,1,0.9809451,0);
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_screenPosNorm = ase_screenPos / ase_screenPos.w;
			ase_screenPosNorm.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? ase_screenPosNorm.z : ase_screenPosNorm.z * 0.5 + 0.5;
			float screenDepth2 = LinearEyeDepth(SAMPLE_DEPTH_TEXTURE( _CameraDepthTexture, ase_screenPosNorm.xy ));
			float distanceDepth2 = abs( ( screenDepth2 - LinearEyeDepth( ase_screenPosNorm.z ) ) / ( _DepthDistance ) );
			float temp_output_15_0 = saturate( pow( ( ( 1.0 - saturate( distanceDepth2 ) ) * _Scale ) , _FallOff ) );
			float4 lerpResult13 = lerp( ( tex2D( _TextureSample0, panner23 ) - temp_cast_1 ) , color14 , temp_output_15_0);
			o.Emission = lerpResult13.rgb;
			o.Alpha = saturate( ( temp_output_15_0 + _GeneralOpacity ) );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
1920;0;1920;1059;3181.233;786.547;1.800878;True;False
Node;AmplifyShaderEditor.RangedFloatNode;3;-1546.557,254.3481;Inherit;False;Property;_DepthDistance;Depth Distance;2;0;Create;True;0;0;0;False;0;False;0;0.2380685;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.DepthFade;2;-1258.557,229.3482;Inherit;False;True;False;True;2;1;FLOAT3;0,0,0;False;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;4;-1010.557,263.3484;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;28;-1741.102,-219.6044;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector3Node;27;-1680.606,-48.19948;Inherit;False;Property;_PannerDirection;Panner Direction;5;0;Create;True;0;0;0;False;0;False;0,0.05,0.05;0.2,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.OneMinusNode;8;-866.558,265.3484;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-996.5575,446.3484;Inherit;False;Property;_Scale;Scale;1;0;Create;True;0;0;0;False;0;False;0;0.5288932;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-700.558,259.3484;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-831.558,612.3486;Inherit;False;Property;_FallOff;FallOff;0;0;Create;True;0;0;0;False;0;False;0;0.292;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PannerNode;23;-1343.552,-245.5313;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-806.022,113.0418;Inherit;False;Property;_Noise;Noise;6;0;Create;True;0;0;0;False;0;False;0;0.8185633;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;29;-1037.022,3.041809;Inherit;True;Simplex2D;True;False;2;0;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;11;-598.0533,390.6236;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;16;-1071.552,-244.2196;Inherit;True;Property;_TextureSample0;Texture Sample 0;4;0;Create;True;0;0;0;False;0;False;-1;None;e40fbac06c27674449413907551b5fa8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;6;-569.5867,215;Inherit;False;Property;_GeneralOpacity;GeneralOpacity;3;0;Create;True;0;0;0;False;0;False;0;0.4960415;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;15;-425.4579,360.343;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;32;-630.022,-118.9582;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;14;-419.6963,-433.3059;Inherit;False;Constant;_Color1;Color 1;4;0;Create;True;0;0;0;False;0;False;0.4103774,1,0.9915768,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;34;-329.022,-238.9582;Inherit;True;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;5;-115.4633,205.2845;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;7;164.8954,207.1558;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;13;-21.42759,-287.4213;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;433.1391,-295.9102;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Wall;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;False;0;False;Transparent;;Transparent;ForwardOnly;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;2;0;3;0
WireConnection;4;0;2;0
WireConnection;8;0;4;0
WireConnection;9;0;8;0
WireConnection;9;1;12;0
WireConnection;23;0;28;0
WireConnection;23;2;27;0
WireConnection;29;0;23;0
WireConnection;11;0;9;0
WireConnection;11;1;10;0
WireConnection;16;1;23;0
WireConnection;15;0;11;0
WireConnection;32;0;29;0
WireConnection;32;1;33;0
WireConnection;34;0;16;0
WireConnection;34;1;32;0
WireConnection;5;0;15;0
WireConnection;5;1;6;0
WireConnection;7;0;5;0
WireConnection;13;0;34;0
WireConnection;13;1;14;0
WireConnection;13;2;15;0
WireConnection;0;2;13;0
WireConnection;0;9;7;0
ASEEND*/
//CHKSM=5EB5E101BA65ACB5E5B3BF2634B0F971612222B8