// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Coin"
{
	Properties
	{
		_Smoothness("Smoothness", Float) = 0
		_Color0("Color 0", Color) = (0.8196079,0.627451,0.3098039,0)
		_Metallic("Metallic", Float) = 0
		_FlashWidth("FlashWidth", Range( 0 , 1)) = 0.8588235
		_Color2("Color 2", Color) = (0,0,0,0)
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float3 worldPos;
		};

		uniform float4 _Color0;
		uniform float4 _Color2;
		uniform float _FlashWidth;
		uniform float _Metallic;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Color0.rgb;
			float mulTime24 = _Time.y * 5.0;
			float lerpResult54 = lerp( 0.0 , 1.0 , (0.0 + (sin( mulTime24 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			o.Emission = ( _Color2 * (0.0 + (sin( ( mulTime24 + ( lerpResult54 * ( ( ase_vertex3Pos.x / _FlashWidth ) + ( ase_vertex3Pos.y / _FlashWidth ) ) ) ) ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)) ).rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
0;537;1465;462;1789.491;-94.35612;1.3;True;False
Node;AmplifyShaderEditor.CommentaryNode;59;-1291.803,-214.5317;Inherit;False;784.8236;406.681;Diagonal Speed;4;54;56;55;24;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-1427.387,-40.05879;Inherit;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;24;-1254.286,-34.60182;Inherit;False;1;0;FLOAT;11;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;58;-1274.953,207.4137;Inherit;False;568.5603;484.2428;Diagonal Mask;4;12;5;51;30;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;55;-1044.589,-80.97693;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-1239.873,556.1564;Inherit;False;Property;_FlashWidth;FlashWidth;3;0;Create;True;0;0;False;0;0.8588235;0.1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;5;-1252.254,371.8777;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleDivideOpNode;30;-860.6741,442.8324;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;51;-858.3917,329.4895;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;56;-885.7125,-84.31058;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;61;-677.2252,328.9386;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;54;-666.1534,-148.207;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-490.4268,134.3426;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;23;-346.4541,235.3637;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;22;-192.9513,240.5202;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;18;-22.2402,-79.66238;Inherit;False;Property;_Color2;Color 2;4;0;Create;True;0;0;False;0;0,0,0,0;0.6313726,0.4922109,0.1921569,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;38;-21.23208,247.5784;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;352.76,-17.7623;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;1;-24.64707,-510.046;Inherit;False;Property;_Color0;Color 0;1;0;Create;True;0;0;False;0;0.8196079,0.627451,0.3098039,0;0.9150943,0.6334964,0.2374066,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;3;39.47902,-296.8034;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;False;0;0;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;2;28.47902,-199.8034;Inherit;False;Property;_Smoothness;Smoothness;0;0;Create;True;0;0;False;0;0;0.85;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;604.5361,-165.831;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Coin;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;24;0;64;0
WireConnection;55;0;24;0
WireConnection;30;0;5;2
WireConnection;30;1;12;0
WireConnection;51;0;5;1
WireConnection;51;1;12;0
WireConnection;56;0;55;0
WireConnection;61;0;51;0
WireConnection;61;1;30;0
WireConnection;54;2;56;0
WireConnection;70;0;54;0
WireConnection;70;1;61;0
WireConnection;23;0;24;0
WireConnection;23;1;70;0
WireConnection;22;0;23;0
WireConnection;38;0;22;0
WireConnection;16;0;18;0
WireConnection;16;1;38;0
WireConnection;0;0;1;0
WireConnection;0;2;16;0
WireConnection;0;3;3;0
WireConnection;0;4;2;0
ASEEND*/
//CHKSM=CA1D43647572B8ADC9BB429DD764C3E91FAA9EFB