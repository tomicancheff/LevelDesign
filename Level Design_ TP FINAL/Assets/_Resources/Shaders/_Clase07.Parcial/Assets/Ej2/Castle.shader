// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Castle"
{
	Properties
	{
		_Color0("Color 0", Color) = (0,0,0,0)
		_Color1("Color 1", Color) = (0,0,0,0)
		_Falloff("Falloff", Float) = 1
		_FallScale("FallScale", Float) = 0.5
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
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
		uniform float4 _Color1;
		uniform float _FallScale;
		uniform float _Falloff;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float3 ase_worldPos = i.worldPos;
			float mulTime19 = _Time.y * _FallScale;
			float lerpResult40 = lerp( 0.0 , 4.0 , (0.0 + (sin( mulTime19 ) - -1.0) * (1.0 - 0.0) / (1.0 - -1.0)));
			float SphereMask30 = pow( ( distance( float3(-4.17,-0.39,-3.47) , ase_worldPos ) / lerpResult40 ) , _Falloff );
			float4 lerpResult11 = lerp( _Color0 , _Color1 , saturate( SphereMask30 ));
			o.Albedo = lerpResult11.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17200
0;537;1465;462;2849.984;35.67136;1.6;True;False
Node;AmplifyShaderEditor.RangedFloatNode;21;-2302.524,208.0951;Inherit;False;Property;_FallScale;FallScale;3;0;Create;True;0;0;False;0;0.5;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;19;-2113.525,213.0951;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;17;-2211.882,-145.8449;Inherit;False;1357.883;353.7596;Mask;7;37;34;33;31;30;2;39;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;36;-1890.877,211.04;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;32;-1744.001,252.1649;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;2;-2188.963,-97.56927;Inherit;False;Constant;_Point;Point;1;0;Create;True;0;0;False;0;-4.17,-0.39,-3.47;-4.17,-0.39,-3.47;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;37;-1966.035,-6.013837;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;34;-1673.035,-90.61382;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;40;-1531.29,240.5784;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;4;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;39;-1422.191,68.92525;Inherit;False;Property;_Falloff;Falloff;2;0;Create;True;0;0;False;0;1;0.3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;33;-1451.73,-91.59624;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;31;-1262.784,-86.05975;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;30;-1094.672,-90.99291;Inherit;False;SphereMask;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;27;-598.3196,270.9607;Inherit;False;30;SphereMask;1;0;OBJECT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;23;-373.1187,270.275;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-416.4763,44.45868;Inherit;False;Property;_Color1;Color 1;1;0;Create;True;0;0;False;0;0,0,0,0;0.2892132,0.03604485,0.509434,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;-403.9028,-126.149;Inherit;False;Property;_Color0;Color 0;0;0;Create;True;0;0;False;0;0,0,0,0;0.8039216,0.8039216,0.7803922,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;11;-155.5244,72.86877;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;69.20627,-15.97068;Float;False;True;2;ASEMaterialInspector;0;0;Standard;Castle;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;19;0;21;0
WireConnection;36;0;19;0
WireConnection;32;0;36;0
WireConnection;34;0;2;0
WireConnection;34;1;37;0
WireConnection;40;2;32;0
WireConnection;33;0;34;0
WireConnection;33;1;40;0
WireConnection;31;0;33;0
WireConnection;31;1;39;0
WireConnection;30;0;31;0
WireConnection;23;0;27;0
WireConnection;11;0;1;0
WireConnection;11;1;12;0
WireConnection;11;2;23;0
WireConnection;0;0;11;0
ASEEND*/
//CHKSM=F5564B1B1900617516F33DD760BD65573DE84B0F