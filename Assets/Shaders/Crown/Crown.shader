// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Crown"
{
	Properties
	{
		_TextureSample0("Texture Sample 0", 2D) = "bump" {}
		_Color1("Color 1", Color) = (0,0,0,0)
		_Metallica("Metallica", Range( 0 , 2)) = 2
		_Color2("Color 2", Color) = (0,0,0,0)
		_Point("Point", Vector) = (-4.6,1,1,0)
		_FlashWidth("FlashWidth", Range( 0 , 1)) = 0
		_Inclinacion("Inclinacion", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldPos;
		};

		uniform sampler2D _TextureSample0;
		uniform float4 _Color1;
		uniform float4 _Color2;
		uniform float3 _Point;
		uniform float _Inclinacion;
		uniform float _FlashWidth;
		uniform float _Metallica;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TexCoord7 = i.uv_texcoord * float2( 5,5 );
			float3 NormalCorona27 = UnpackScaleNormal( tex2D( _TextureSample0, uv_TexCoord7 ), 2.0 );
			o.Normal = NormalCorona27;
			float3 ase_worldPos = i.worldPos;
			float mulTime30 = _Time.y * 3.0;
			float4 lerpResult32 = lerp( _Color1 , _Color2 , ceil( sin( ( distance( _Point , ase_worldPos ) + mulTime30 ) ) ));
			float4 Colorcitos42 = lerpResult32;
			float4 color1 = IsGammaSpace() ? float4(0.9607843,0.88533,0,0) : float4(0.9130987,0.7586944,0,0);
			o.Albedo = ( Colorcitos42 + color1 ).rgb;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float mulTime12 = _Time.y * -2.2;
			float Reflejito24 = step( ( 1.0 - sin( ( ( ase_vertex3Pos.x * _Inclinacion ) + mulTime12 + ase_vertex3Pos.y ) ) ) , ( _FlashWidth / 100.0 ) );
			o.Emission = ( color1 * Reflejito24 ).rgb;
			o.Metallic = _Metallica;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
1920;0;1920;1059;756.3599;138.1563;1;True;False
Node;AmplifyShaderEditor.CommentaryNode;23;-1903.566,671.9361;Inherit;False;1328.836;594.2036;Reflejo;12;11;10;12;13;14;15;16;18;19;20;17;21;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;21;-1853.566,815.2876;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;10;-1783.56,1130.935;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;0;False;0;False;-2.2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1680.56,721.936;Inherit;False;Property;_Inclinacion;Inclinacion;6;0;Create;True;0;0;0;False;0;False;0;2.56;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldPosInputsNode;34;96.9057,962.0435;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;46;270.4642,1167.897;Inherit;False;Constant;_Float2;Float 2;7;0;Create;True;0;0;0;False;0;False;3;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;33;47.32558,797.7566;Inherit;False;Property;_Point;Point;4;0;Create;True;0;0;0;False;0;False;-4.6,1,1;-4.6,3.792084,-0.15;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1608.56,816.9359;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;12;-1654.264,983.2237;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;30;501.6101,1141.936;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;35;354.9057,923.6404;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;14;-1394.56,782.9359;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;606.9058,946.6404;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-1514.521,1060.024;Inherit;False;Property;_FlashWidth;FlashWidth;5;0;Create;True;0;0;0;False;0;False;0;0.9022876;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1265.73,1150.139;Inherit;False;Constant;_Divisorpor10;Divisorpor10;6;0;Create;True;0;0;0;False;0;False;100;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;17;-1231.56,798.9359;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;37;769.2819,934.0916;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;18;-1017.73,1011.14;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;26;-1723.209,169.2468;Inherit;False;888.2091;321.2532;Normal;4;8;7;3;2;;1,1,1,1;0;0
Node;AmplifyShaderEditor.OneMinusNode;19;-1065.561,906.9359;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;20;-809.7302,795.1394;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;31;949.2112,919.4686;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector2Node;8;-1673.209,219.2468;Inherit;False;Constant;_Vector0;Vector 0;1;0;Create;True;0;0;0;False;0;False;5,5;0,0;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.ColorNode;39;579.1438,572.0983;Inherit;False;Property;_Color1;Color 1;1;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.6981132,0.5760015,0.04939479,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;38;426.5703,712.7059;Inherit;False;Property;_Color2;Color 2;3;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.7169812,0.3261562,0,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;24;-416.577,786.8252;Inherit;False;Reflejito;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;32;1086.522,779.116;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;7;-1431.209,219.2468;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;-1378,374.5;Inherit;False;Constant;_Float0;Float 0;1;0;Create;True;0;0;0;False;0;False;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-413.1511,48.03052;Inherit;False;Constant;_Color0;Color 0;0;1;[HDR];Create;True;0;0;0;False;0;False;0.9607843,0.88533,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;42;1374.759,823.2737;Inherit;False;Colorcitos;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-1155,244.5;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;None;dfbf8c4f708c02e428ba1a3facec3420;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;25;-292.9706,278.6787;Inherit;False;24;Reflejito;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;27;-773.8911,282.1977;Inherit;False;NormalCorona;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.WireNode;48;-221.6646,-26.46416;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;43;-119.365,-178.7767;Inherit;False;42;Colorcitos;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;30.19256,128.1362;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;44;203.9351,-110.9779;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;45;455.7301,-261.1761;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;9;13.77201,405.5006;Inherit;False;Property;_Metallica;Metallica;2;0;Create;True;0;0;0;False;0;False;2;1.188235;0;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.WireNode;47;427.3354,71.53584;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;28;220.1089,120.1977;Inherit;False;27;NormalCorona;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;660.1161,-113.1428;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Crown;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;13;0;21;1
WireConnection;13;1;11;0
WireConnection;12;0;10;0
WireConnection;30;0;46;0
WireConnection;35;0;33;0
WireConnection;35;1;34;0
WireConnection;14;0;13;0
WireConnection;14;1;12;0
WireConnection;14;2;21;2
WireConnection;36;0;35;0
WireConnection;36;1;30;0
WireConnection;17;0;14;0
WireConnection;37;0;36;0
WireConnection;18;0;16;0
WireConnection;18;1;15;0
WireConnection;19;0;17;0
WireConnection;20;0;19;0
WireConnection;20;1;18;0
WireConnection;31;0;37;0
WireConnection;24;0;20;0
WireConnection;32;0;39;0
WireConnection;32;1;38;0
WireConnection;32;2;31;0
WireConnection;7;0;8;0
WireConnection;42;0;32;0
WireConnection;2;1;7;0
WireConnection;2;5;3;0
WireConnection;27;0;2;0
WireConnection;48;0;1;0
WireConnection;22;0;1;0
WireConnection;22;1;25;0
WireConnection;44;0;43;0
WireConnection;44;1;48;0
WireConnection;47;0;22;0
WireConnection;0;0;44;0
WireConnection;0;1;28;0
WireConnection;0;2;47;0
WireConnection;0;3;9;0
ASEEND*/
//CHKSM=24E3ACAE7702F47DF1C001A7072BCDB8814BDA8E