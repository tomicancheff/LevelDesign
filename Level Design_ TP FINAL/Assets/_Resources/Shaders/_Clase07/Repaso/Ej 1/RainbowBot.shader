// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "RainbowBot"
{
	Properties
	{
		_TextureSample1("Texture Sample 1", 2D) = "white" {}
		_RedThreshold("RedThreshold", Float) = 0
		_TextureSample2("Texture Sample 2", 2D) = "white" {}
		_TextureSample3("Texture Sample 3", 2D) = "white" {}
		_WhiteThreshold("White Threshold", Range( 0 , 1)) = 0
		_Float0("Float 0", Float) = 5.35
		_TextureSample4("Texture Sample 4", 2D) = "white" {}
		_TextureSample5("Texture Sample 5", 2D) = "white" {}
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		_TextureSample6("Texture Sample 6", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
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
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample1;
		uniform float4 _TextureSample1_ST;
		uniform sampler2D _TextureSample5;
		uniform sampler2D _TextureSample0;
		uniform sampler2D _TextureSample3;
		uniform float4 _TextureSample3_ST;
		uniform float _WhiteThreshold;
		uniform float _Float0;
		uniform sampler2D _TextureSample6;
		uniform float _RedThreshold;
		uniform sampler2D _TextureSample4;
		uniform sampler2D _TextureSample2;
		uniform float4 _TextureSample2_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample1 = i.uv_texcoord * _TextureSample1_ST.xy + _TextureSample1_ST.zw;
			float2 temp_cast_0 = ((0.65 + (sin( _Time.y ) - -1.0) * (1.0 - 0.65) / (1.0 - -1.0))).xx;
			float4 RedGreen54 = tex2D( _TextureSample5, temp_cast_0 );
			float2 temp_cast_1 = ((0.25 + (sin( _Time.y ) - -1.0) * (0.6 - 0.25) / (1.0 - -1.0))).xx;
			float4 GreenBlue55 = tex2D( _TextureSample0, temp_cast_1 );
			float2 uv_TextureSample3 = i.uv_texcoord * _TextureSample3_ST.xy + _TextureSample3_ST.zw;
			float4 lerpResult15 = lerp( RedGreen54 , GreenBlue55 , saturate( ( ( tex2D( _TextureSample3, uv_TextureSample3 ).g - _WhiteThreshold ) * _Float0 ) ));
			float4 WhiteBlackLerp68 = lerpResult15;
			float2 temp_cast_2 = ((0.0 + (sin( _Time.y ) - -1.0) * (0.27 - 0.0) / (1.0 - -1.0))).xx;
			float4 PurpleRed56 = tex2D( _TextureSample6, temp_cast_2 );
			float4 tex2DNode2 = tex2D( _TextureSample1, uv_TextureSample1 );
			float4 lerpResult9 = lerp( WhiteBlackLerp68 , PurpleRed56 , ceil( saturate( ( ( tex2DNode2.r - tex2DNode2.g ) - _RedThreshold ) ) ));
			o.Albedo = ( tex2D( _TextureSample1, uv_TextureSample1 ).r * lerpResult9 ).rgb;
			float2 temp_cast_4 = (_CosTime.x).xx;
			float2 uv_TextureSample2 = i.uv_texcoord * _TextureSample2_ST.xy + _TextureSample2_ST.zw;
			o.Emission = ( tex2D( _TextureSample4, temp_cast_4 ) * tex2D( _TextureSample2, uv_TextureSample2 ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
110;495;1267;496;7142.767;1381.49;5.804837;True;False
Node;AmplifyShaderEditor.CommentaryNode;95;-3831.314,-1338.216;Inherit;False;1233.364;397.3691;Red to Green;7;89;85;86;92;93;90;54;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;104;-3844.913,-938.4066;Inherit;False;1224.77;397.3689;Green to Purple;7;97;99;100;98;101;102;55;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;97;-3794.913,-858.3956;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;89;-3781.314,-1258.205;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;58;-4307.771,-78.39799;Inherit;False;1732.65;380.9375;RedStripes;10;15;59;61;13;11;14;12;10;68;116;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SinOpNode;92;-3577.219,-1258.205;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;86;-3725.722,-1156.369;Inherit;False;Constant;_Float3;Float 3;8;0;Create;True;0;0;0;False;0;False;0.65;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;98;-3739.769,-657.0377;Inherit;False;Constant;_Float1;Float 1;8;0;Create;True;0;0;0;False;0;False;0.6;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;100;-3739.321,-756.5596;Inherit;False;Constant;_Float4;Float 4;8;0;Create;True;0;0;0;False;0;False;0.25;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;85;-3726.17,-1056.847;Inherit;False;Constant;_Float2;Float 2;8;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;99;-3590.818,-858.3956;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCRemapNode;93;-3373.248,-1258.417;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;10;-4274.771,-23.39798;Inherit;True;Property;_TextureSample3;Texture Sample 3;3;0;Create;True;0;0;0;False;0;False;-1;None;1fb1c364a3eed724bb16168fbb1cad8d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;101;-3386.847,-858.6076;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;111;-3823.36,-535.4677;Inherit;False;1215.36;397.3689;Purple to Red;7;105;106;107;108;109;110;56;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-4209.859,218.9387;Inherit;False;Property;_WhiteThreshold;White Threshold;4;0;Create;True;0;0;0;False;0;False;0;0.29;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;14;-3766.854,225.657;Inherit;False;Property;_Float0;Float 0;5;0;Create;True;0;0;0;False;0;False;5.35;9.49;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;90;-3171.445,-1288.216;Inherit;True;Property;_TextureSample5;Texture Sample 5;7;0;Create;True;0;0;0;False;0;False;-1;None;bb47b838a0905154496dfe9920ae73b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;105;-3773.36,-455.4567;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;57;-4291.51,361.3083;Inherit;False;1643.438;427.1301;White and Black;9;69;7;9;4;8;5;3;2;60;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;102;-3185.044,-888.4066;Inherit;True;Property;_TextureSample0;Texture Sample 0;8;0;Create;True;0;0;0;False;0;False;-1;None;bb47b838a0905154496dfe9920ae73b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;11;-3914.117,119.9203;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;54;-2821.95,-1288.199;Inherit;False;RedGreen;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;55;-2844.143,-887.5989;Inherit;False;GreenBlue;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SinOpNode;108;-3569.265,-455.4567;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-4241.51,431.5919;Inherit;True;Property;_TextureSample1;Texture Sample 1;0;0;Create;True;0;0;0;False;0;False;-1;None;1fb1c364a3eed724bb16168fbb1cad8d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;106;-3717.768,-353.6206;Inherit;False;Constant;_Float5;Float 5;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-3573.951,118.0511;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-3718.216,-254.0988;Inherit;False;Constant;_Float6;Float 6;8;0;Create;True;0;0;0;False;0;False;0.27;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;3;-3883.309,461.0546;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;116;-3179.444,237.5071;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-3855.966,562.4775;Inherit;False;Property;_RedThreshold;RedThreshold;1;0;Create;True;0;0;0;False;0;False;0;0.15;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;59;-3224.564,11.8967;Inherit;False;54;RedGreen;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;61;-3274.048,124.9586;Inherit;False;55;GreenBlue;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;109;-3365.293,-455.6686;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;-1;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;15;-2970.903,181.444;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;110;-3163.49,-485.4677;Inherit;True;Property;_TextureSample6;Texture Sample 6;9;0;Create;True;0;0;0;False;0;False;-1;None;bb47b838a0905154496dfe9920ae73b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;4;-3619.242,461.9545;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;68;-2787.062,169.0596;Inherit;False;WhiteBlackLerp;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;7;-3432.587,463.4665;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;56;-2835.773,-483.7731;Inherit;False;PurpleRed;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;82;-3588.38,832.7045;Inherit;False;939.1552;473.1571;Rainbow Eyes;4;71;6;73;74;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CeilOpNode;8;-3270.499,463.4666;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;60;-3112.799,483.1041;Inherit;False;56;PurpleRed;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;69;-3007.552,408.0376;Inherit;False;68;WhiteBlackLerp;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.CosTime;71;-3538.381,914.4058;Inherit;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;73;-3324.823,882.7045;Inherit;True;Property;_TextureSample4;Texture Sample 4;6;0;Create;True;0;0;0;False;0;False;-1;None;bb47b838a0905154496dfe9920ae73b0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;117;-2627.893,396.4816;Inherit;True;Property;_TextureSample8;Texture Sample 8;0;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Instance;2;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;6;-3326.068,1078.462;Inherit;True;Property;_TextureSample2;Texture Sample 2;2;0;Create;True;0;0;0;False;0;False;-1;None;8af982b97b25aa64a9c74eb48e06b75f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;9;-2823.354,642.6244;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;118;-2306.395,606.7852;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;-2884.227,953.4207;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-2041.835,623.2664;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;RainbowBot;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;92;0;89;0
WireConnection;99;0;97;0
WireConnection;93;0;92;0
WireConnection;93;3;86;0
WireConnection;93;4;85;0
WireConnection;101;0;99;0
WireConnection;101;3;100;0
WireConnection;101;4;98;0
WireConnection;90;1;93;0
WireConnection;102;1;101;0
WireConnection;11;0;10;2
WireConnection;11;1;12;0
WireConnection;54;0;90;0
WireConnection;55;0;102;0
WireConnection;108;0;105;0
WireConnection;13;0;11;0
WireConnection;13;1;14;0
WireConnection;3;0;2;1
WireConnection;3;1;2;2
WireConnection;116;0;13;0
WireConnection;109;0;108;0
WireConnection;109;3;106;0
WireConnection;109;4;107;0
WireConnection;15;0;59;0
WireConnection;15;1;61;0
WireConnection;15;2;116;0
WireConnection;110;1;109;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;68;0;15;0
WireConnection;7;0;4;0
WireConnection;56;0;110;0
WireConnection;8;0;7;0
WireConnection;73;1;71;1
WireConnection;9;0;69;0
WireConnection;9;1;60;0
WireConnection;9;2;8;0
WireConnection;118;0;117;1
WireConnection;118;1;9;0
WireConnection;74;0;73;0
WireConnection;74;1;6;0
WireConnection;0;0;118;0
WireConnection;0;2;74;0
ASEEND*/
//CHKSM=AFB464709D5208052421C900417C1C1BF7907AF9