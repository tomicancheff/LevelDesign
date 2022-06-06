// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Ej1"
{
	Properties
	{
		_TextureSample6("Texture Sample 6", 2D) = "white" {}
		_TextureSample14("Texture Sample 6", 2D) = "white" {}
		_TextureSample7("Texture Sample 7", 2D) = "white" {}
		_TextureSample15("Texture Sample 7", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _TextureSample7;
		uniform float4 _TextureSample7_ST;
		uniform sampler2D _TextureSample6;
		uniform float4 _TextureSample6_ST;
		uniform sampler2D _TextureSample14;
		uniform float4 _TextureSample14_ST;
		uniform sampler2D _TextureSample15;
		uniform float4 _TextureSample15_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample7 = i.uv_texcoord * _TextureSample7_ST.xy + _TextureSample7_ST.zw;
			float2 uv_TextureSample6 = i.uv_texcoord * _TextureSample6_ST.xy + _TextureSample6_ST.zw;
			float4 color81 = IsGammaSpace() ? float4(1,0,1,0) : float4(1,0,1,0);
			float2 uv_TextureSample14 = i.uv_texcoord * _TextureSample14_ST.xy + _TextureSample14_ST.zw;
			float2 uv_TextureSample15 = i.uv_texcoord * _TextureSample15_ST.xy + _TextureSample15_ST.zw;
			float4 color87 = IsGammaSpace() ? float4(1,1,0,0) : float4(1,1,0,0);
			o.Albedo = saturate( ( saturate( ( ( tex2D( _TextureSample7, uv_TextureSample7 ) - tex2D( _TextureSample6, uv_TextureSample6 ) ) - color81 ) ) + saturate( ( ( tex2D( _TextureSample14, uv_TextureSample14 ) - tex2D( _TextureSample15, uv_TextureSample15 ) ) - color87 ) ) ) ).rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
11;363;1448;635;1059.185;270.7563;2.386397;False;True
Node;AmplifyShaderEditor.CommentaryNode;48;-1205.835,288.8137;Inherit;False;664.0035;490.0852;2;3;44;45;46;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;44;-1155.835,338.8137;Inherit;True;Property;_TextureSample6;Texture Sample 6;4;0;Create;True;0;0;0;False;0;False;-1;537dadbf18273ce499a2b34dbedac194;537dadbf18273ce499a2b34dbedac194;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;84;-623.631,1087.266;Inherit;True;Property;_TextureSample15;Texture Sample 7;12;0;Create;True;0;0;0;False;0;False;-1;9536cdd776c02ac41b67af38b028ccdb;9536cdd776c02ac41b67af38b028ccdb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;83;-628.236,877.1814;Inherit;True;Property;_TextureSample14;Texture Sample 6;5;0;Create;True;0;0;0;False;0;False;-1;537dadbf18273ce499a2b34dbedac194;537dadbf18273ce499a2b34dbedac194;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;46;-1151.23,548.8985;Inherit;True;Property;_TextureSample7;Texture Sample 7;11;0;Create;True;0;0;0;False;0;False;-1;9536cdd776c02ac41b67af38b028ccdb;9536cdd776c02ac41b67af38b028ccdb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;45;-776.8309,432.0992;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;85;-249.2314,970.4669;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;81;-770.5862,654.9371;Inherit;False;Constant;_Color2;Color 2;12;0;Create;True;0;0;0;False;0;False;1,0,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;87;-242.9867,1193.305;Inherit;False;Constant;_Color4;Color 2;12;0;Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;80;-465.0974,503.2043;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;86;62.50202,1041.572;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;88;315.3906,1045.618;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;82;-212.2089,507.2504;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;89;173.4675,439.1528;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;39;-1320.864,-212.4629;Inherit;False;1064.383;490.9156;1;9;37;74;77;75;79;73;78;34;33;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;31;-1880.569,-216.6483;Inherit;False;526.9;453.6;3;3;28;2;1;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;66;-1811.108,795.7681;Inherit;False;1098.814;880.878;4;9;53;54;52;51;50;49;63;65;64;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;43;-1872.865,288.337;Inherit;False;651.9999;488.8;2;3;42;41;35;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode;91;520.3772,506.4467;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;90;-117.4148,-59.5448;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;52;-1752.308,1446.646;Inherit;True;Property;_TextureSample10;Texture Sample 10;6;0;Create;True;0;0;0;False;0;False;-1;537dadbf18273ce499a2b34dbedac194;537dadbf18273ce499a2b34dbedac194;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-1556.867,-117.8484;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;41;-1816.863,545.9368;Inherit;True;Property;_TextureSample5;Texture Sample 5;9;0;Create;True;0;0;0;False;0;False;-1;9536cdd776c02ac41b67af38b028ccdb;9536cdd776c02ac41b67af38b028ccdb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;54;-1754.203,1255.03;Inherit;True;Property;_TextureSample11;Texture Sample 11;13;0;Create;True;0;0;0;False;0;False;-1;9536cdd776c02ac41b67af38b028ccdb;9536cdd776c02ac41b67af38b028ccdb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;34;-1287.369,54.15182;Inherit;True;Property;_TextureSample3;Texture Sample 3;8;0;Create;True;0;0;0;False;0;False;-1;9536cdd776c02ac41b67af38b028ccdb;9536cdd776c02ac41b67af38b028ccdb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;65;-1160.494,1300.121;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;42;-1442.464,429.1372;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;50;-1382.105,939.0536;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;33;-1285.769,-153.5483;Inherit;True;Property;_TextureSample2;Texture Sample 2;1;0;Create;True;0;0;0;False;0;False;-1;537dadbf18273ce499a2b34dbedac194;537dadbf18273ce499a2b34dbedac194;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1857.372,-176.1703;Inherit;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;0;False;0;False;-1;537dadbf18273ce499a2b34dbedac194;537dadbf18273ce499a2b34dbedac194;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;51;-1756.504,1055.854;Inherit;True;Property;_TextureSample9;Texture Sample 9;10;0;Create;True;0;0;0;False;0;False;-1;9536cdd776c02ac41b67af38b028ccdb;9536cdd776c02ac41b67af38b028ccdb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;35;-1821.467,335.8517;Inherit;True;Property;_TextureSample4;Texture Sample 4;2;0;Create;True;0;0;0;False;0;False;-1;537dadbf18273ce499a2b34dbedac194;537dadbf18273ce499a2b34dbedac194;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;53;-1384.804,1301.03;Inherit;True;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;73;-1006.774,-91.46167;Inherit;False;Constant;_Color0;Color 0;12;0;Create;True;0;0;0;False;0;False;0,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;75;-998.3517,107.2084;Inherit;False;Constant;_Color1;Color 1;12;0;Create;True;0;0;0;False;0;False;1,1,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;63;-1151.394,940.0214;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;78;-795.1293,-171.5685;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;79;-790.5064,22.69249;Inherit;False;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;74;-639.0707,-171.4908;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;77;-641.5836,20.23079;Inherit;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;37;-463.1943,-138.6591;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;49;-1761.108,845.7681;Inherit;True;Property;_TextureSample8;Texture Sample 8;3;0;Create;True;0;0;0;False;0;False;-1;537dadbf18273ce499a2b34dbedac194;537dadbf18273ce499a2b34dbedac194;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-921.3209,1032.828;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-1855.772,27.12946;Inherit;True;Property;_TextureSample1;Texture Sample 1;7;0;Create;True;0;0;0;False;0;False;-1;9536cdd776c02ac41b67af38b028ccdb;9536cdd776c02ac41b67af38b028ccdb;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;872.4461,49.61634;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Ej1;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;45;0;46;0
WireConnection;45;1;44;0
WireConnection;85;0;83;0
WireConnection;85;1;84;0
WireConnection;80;0;45;0
WireConnection;80;1;81;0
WireConnection;86;0;85;0
WireConnection;86;1;87;0
WireConnection;88;0;86;0
WireConnection;82;0;80;0
WireConnection;89;0;82;0
WireConnection;89;1;88;0
WireConnection;91;0;89;0
WireConnection;90;0;37;0
WireConnection;28;0;1;0
WireConnection;28;1;2;0
WireConnection;65;0;53;0
WireConnection;42;0;35;0
WireConnection;42;1;41;0
WireConnection;50;0;49;0
WireConnection;50;1;51;0
WireConnection;53;0;54;0
WireConnection;53;1;52;0
WireConnection;63;0;50;0
WireConnection;78;0;33;0
WireConnection;78;1;73;0
WireConnection;79;0;34;0
WireConnection;79;1;75;0
WireConnection;74;0;78;0
WireConnection;77;0;79;0
WireConnection;37;0;74;0
WireConnection;37;1;77;0
WireConnection;64;0;63;0
WireConnection;64;1;65;0
WireConnection;0;0;91;0
ASEEND*/
//CHKSM=D03DBDD73B8AA36C46C94D44D5FD5B623B45E22A