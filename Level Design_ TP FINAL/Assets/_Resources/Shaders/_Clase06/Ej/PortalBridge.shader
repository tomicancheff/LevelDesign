// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PortalBridge"
{
	Properties
	{
		_Border("Border", Range( 0 , 1)) = 0.9
		_Border1("Border1", Range( 0 , 1)) = 0.9
		_Line1("Line1", Range( 0 , 1)) = 0.9
		_Line2("Line2", Range( 0 , 1)) = 0.9
		_Line3("Line3", Range( 0 , 1)) = 0.9
		_TilingLine1("TilingLine1", Float) = 25
		_TilingLine2("TilingLine2", Float) = 25
		_TilingLine3("TilingLine3", Float) = 25
		_OffsetLine1("OffsetLine1", Float) = 0
		_OffsetLine2("OffsetLine2", Float) = 0
		_OffsetLine3a("OffsetLine3a", Float) = 0
		_AmplitudeLine1("AmplitudeLine1", Float) = 2.5
		_AmplitudeLine2("AmplitudeLine2", Float) = 2.5
		_AmplitudeLine3("AmplitudeLine3", Float) = 2.5
		_MovLine("MovLine", Float) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Back
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Border1;
		uniform float _Border;
		uniform float _TilingLine1;
		uniform float _OffsetLine1;
		uniform float _MovLine;
		uniform float _AmplitudeLine1;
		uniform float _Line1;
		uniform float _TilingLine2;
		uniform float _OffsetLine2;
		uniform float _AmplitudeLine2;
		uniform float _Line2;
		uniform float _TilingLine3;
		uniform float _OffsetLine3a;
		uniform float _AmplitudeLine3;
		uniform float _Line3;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color11 = IsGammaSpace() ? float4(0.0295924,0.7305464,0.8962264,0) : float4(0.002290433,0.4927272,0.7799658,0);
			float4 color10 = IsGammaSpace() ? float4(1,1,1,0) : float4(1,1,1,0);
			float4 color101 = IsGammaSpace() ? float4(0.03137255,0.7294118,0.8980392,0) : float4(0.002428216,0.4910209,0.7835379,0);
			float4 lerpResult9 = lerp( color11 , color10 , ( ( ( ceil( ( ( 1.0 - i.uv_texcoord.y ) - _Border1 ) ) + ceil( ( i.uv_texcoord.y - _Border1 ) ) ) * color101 ) + ( ceil( ( ( 1.0 - i.uv_texcoord.y ) - _Border ) ) + ceil( ( i.uv_texcoord.y - _Border ) ) ) ));
			float2 temp_cast_0 = (_TilingLine1).xx;
			float2 temp_cast_1 = (_OffsetLine1).xx;
			float2 uv_TexCoord32 = i.uv_texcoord * temp_cast_0 + temp_cast_1;
			float LineSpeed113 = _MovLine;
			float mulTime111 = _Time.y * LineSpeed113;
			float2 temp_cast_2 = (( sin( ( uv_TexCoord32.x + mulTime111 ) ) / _AmplitudeLine1 )).xx;
			float2 uv_TexCoord22 = i.uv_texcoord + temp_cast_2;
			float2 temp_cast_3 = (_TilingLine2).xx;
			float2 temp_cast_4 = (_OffsetLine2).xx;
			float2 uv_TexCoord57 = i.uv_texcoord * temp_cast_3 + temp_cast_4;
			float mulTime107 = _Time.y * LineSpeed113;
			float2 temp_cast_5 = (( sin( ( uv_TexCoord57.x + mulTime107 ) ) / _AmplitudeLine2 )).xx;
			float2 uv_TexCoord61 = i.uv_texcoord + temp_cast_5;
			float2 temp_cast_6 = (_TilingLine3).xx;
			float2 temp_cast_7 = (_OffsetLine3a).xx;
			float2 uv_TexCoord72 = i.uv_texcoord * temp_cast_6 + temp_cast_7;
			float mulTime103 = _Time.y * LineSpeed113;
			float2 temp_cast_8 = (( sin( ( uv_TexCoord72.x + mulTime103 ) ) / _AmplitudeLine3 )).xx;
			float2 uv_TexCoord76 = i.uv_texcoord + temp_cast_8;
			float4 color99 = IsGammaSpace() ? float4(0.03137255,0.7294118,0.8980392,0) : float4(0.002428216,0.4910209,0.7835379,0);
			o.Emission = ( lerpResult9 + ( saturate( ( ( 1.0 - ( ceil( ( ( 1.0 - uv_TexCoord22.y ) - _Line1 ) ) + ceil( ( uv_TexCoord22.y - _Line1 ) ) ) ) + ( 1.0 - ( ceil( ( ( 1.0 - uv_TexCoord61.y ) - _Line2 ) ) + ceil( ( uv_TexCoord61.y - _Line2 ) ) ) ) + ( 1.0 - ( ceil( ( ( 1.0 - uv_TexCoord76.y ) - _Line3 ) ) + ceil( ( uv_TexCoord76.y - _Line3 ) ) ) ) ) ) * color99 ) ).rgb;
			o.Alpha = 0.5;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO( o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18900
0;433;1365;566;4675.382;-480.1706;2.570821;True;False
Node;AmplifyShaderEditor.RangedFloatNode;112;-3435.663,739.5502;Inherit;False;Property;_MovLine;MovLine;14;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;113;-3282.633,738.2622;Inherit;False;LineSpeed;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;70;-2940.821,1664.415;Inherit;False;Property;_OffsetLine3a;OffsetLine3a;10;0;Create;True;0;0;0;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;115;-2768.846,720.7039;Inherit;False;113;LineSpeed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;116;-2695.85,1259.13;Inherit;False;113;LineSpeed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;117;-2803.823,1768.152;Inherit;False;113;LineSpeed;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;55;-2810.643,1134.44;Inherit;False;Property;_OffsetLine2;OffsetLine2;9;0;Create;True;0;0;0;False;0;False;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-2933.978,1573.626;Inherit;False;Property;_TilingLine3;TilingLine3;7;0;Create;True;0;0;0;False;0;False;25;25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-2803.799,1043.651;Inherit;False;Property;_TilingLine2;TilingLine2;6;0;Create;True;0;0;0;False;0;False;25;25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;50;-2759.115,524.8116;Inherit;False;Property;_TilingLine1;TilingLine1;5;0;Create;True;0;0;0;False;0;False;25;25;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;54;-2765.957,615.6002;Inherit;False;Property;_OffsetLine1;OffsetLine1;8;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;72;-2747.364,1558.394;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;32;-2572.5,509.5794;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;57;-2617.186,1028.419;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;111;-2483.222,691.5601;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;103;-2563.164,1715.772;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;107;-2403.377,1208.604;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;104;-2395.936,1583.304;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;108;-2351.818,1062.325;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;109;-2279.682,545.2806;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;49;-2131.677,528.2218;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;59;-2199.757,1058.62;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;58;-2000.825,1185.296;Inherit;False;Property;_AmplitudeLine2;AmplitudeLine2;12;0;Create;True;0;0;0;False;0;False;2.5;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;53;-1932.746,654.8972;Inherit;False;Property;_AmplitudeLine1;AmplitudeLine1;11;0;Create;True;0;0;0;False;0;False;2.5;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;74;-2102.051,1591.933;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;73;-1896.33,1722.004;Inherit;False;Property;_AmplitudeLine3;AmplitudeLine3;13;0;Create;True;0;0;0;False;0;False;2.5;2.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;52;-1753.967,531.4611;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;2.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;60;-1822.047,1061.86;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;2.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;75;-1717.553,1598.568;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;2.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;76;-1472.187,1545.954;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;22;-1528.124,484.2094;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;61;-1596.203,1014.608;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;78;-1421.055,1671.491;Inherit;False;Property;_Line3;Line3;4;0;Create;True;0;0;0;False;0;False;0.9;0.5579206;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;63;-1363.071,1135.145;Inherit;False;Property;_Line2;Line2;3;0;Create;True;0;0;0;False;0;False;0.9;0.55;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;24;-1144.311,276.4954;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;62;-1212.391,806.8939;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-1294.992,604.7463;Inherit;False;Property;_Line1;Line1;2;0;Create;True;0;0;0;False;0;False;0.9;0.5579206;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;77;-1270.375,1343.24;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;87;-2240.752,-799.511;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;80;-1037.952,1606.591;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;64;-924.0505,807.8442;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;25;-911.8885,539.8466;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;1;-1516.931,-50.7207;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;88;-1856.94,-1007.225;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;26;-855.9709,277.4457;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;89;-2007.621,-678.9741;Inherit;False;Property;_Border1;Border1;1;0;Create;True;0;0;0;False;0;False;0.9;0.9;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;79;-982.0344,1344.19;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;65;-979.968,1070.245;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;27;-658.3704,541.3458;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;4;-1133.119,-258.4346;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;90;-1568.601,-1006.275;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1283.8,69.81633;Inherit;False;Property;_Border;Border;0;0;Create;True;0;0;0;False;0;False;0.9;0.95;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;91;-1624.518,-743.874;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;81;-727.2337,1341.59;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;66;-669.2498,805.2443;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;82;-784.4339,1608.09;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;67;-726.45,1071.744;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;28;-601.1702,274.8458;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;29;-332.5833,395.1945;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;92;-1333.99,-743.7983;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;93;-1315.225,-1008.875;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;68;-400.6628,925.593;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;2;-900.6968,4.91643;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;83;-458.6467,1461.939;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;5;-844.7792,-257.4843;Inherit;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;84;-238.9266,1463.994;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;6;-589.9784,-260.0842;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;69;-180.9427,927.6476;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;30;-112.8632,397.2491;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;94;-1059,-893.1746;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CeilOpNode;7;-647.1786,6.415777;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;101;-1029.081,-628.0596;Inherit;False;Constant;_Color3;Color 3;14;0;Create;True;0;0;0;False;0;False;0.03137255,0.7294118,0.8980392,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-335.1788,-144.3843;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;85;229.5031,1095.832;Inherit;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;100;-735.0812,-783.0596;Inherit;True;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;102;-190.8628,-523.1456;Inherit;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;86;454.5011,1102.224;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;99;480.2573,1245.749;Inherit;False;Constant;_Color2;Color 2;14;0;Create;True;0;0;0;False;0;False;0.03137255,0.7294118,0.8980392,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-354.2242,-1283.331;Inherit;False;Constant;_Color1;Color 1;0;0;Create;True;0;0;0;False;0;False;0.0295924,0.7305464,0.8962264,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;-400.3505,-1035.205;Inherit;False;Constant;_Color0;Color 0;0;0;Create;True;0;0;0;False;0;False;1,1,1,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;98;742.8451,1097.782;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;9;-31.25196,-1005.74;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;41;2299.795,149.9782;Inherit;False;Constant;_Float1;Float 1;2;0;Create;True;0;0;0;False;0;False;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;43;1538.187,7.272975;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;2545.116,-59.09218;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;PortalBridge;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;113;0;112;0
WireConnection;72;0;71;0
WireConnection;72;1;70;0
WireConnection;32;0;50;0
WireConnection;32;1;54;0
WireConnection;57;0;56;0
WireConnection;57;1;55;0
WireConnection;111;0;115;0
WireConnection;103;0;117;0
WireConnection;107;0;116;0
WireConnection;104;0;72;1
WireConnection;104;1;103;0
WireConnection;108;0;57;1
WireConnection;108;1;107;0
WireConnection;109;0;32;1
WireConnection;109;1;111;0
WireConnection;49;0;109;0
WireConnection;59;0;108;0
WireConnection;74;0;104;0
WireConnection;52;0;49;0
WireConnection;52;1;53;0
WireConnection;60;0;59;0
WireConnection;60;1;58;0
WireConnection;75;0;74;0
WireConnection;75;1;73;0
WireConnection;76;1;75;0
WireConnection;22;1;52;0
WireConnection;61;1;60;0
WireConnection;24;0;22;2
WireConnection;62;0;61;2
WireConnection;77;0;76;2
WireConnection;80;0;76;2
WireConnection;80;1;78;0
WireConnection;64;0;62;0
WireConnection;64;1;63;0
WireConnection;25;0;22;2
WireConnection;25;1;23;0
WireConnection;88;0;87;2
WireConnection;26;0;24;0
WireConnection;26;1;23;0
WireConnection;79;0;77;0
WireConnection;79;1;78;0
WireConnection;65;0;61;2
WireConnection;65;1;63;0
WireConnection;27;0;25;0
WireConnection;4;0;1;2
WireConnection;90;0;88;0
WireConnection;90;1;89;0
WireConnection;91;0;87;2
WireConnection;91;1;89;0
WireConnection;81;0;79;0
WireConnection;66;0;64;0
WireConnection;82;0;80;0
WireConnection;67;0;65;0
WireConnection;28;0;26;0
WireConnection;29;0;28;0
WireConnection;29;1;27;0
WireConnection;92;0;91;0
WireConnection;93;0;90;0
WireConnection;68;0;66;0
WireConnection;68;1;67;0
WireConnection;2;0;1;2
WireConnection;2;1;3;0
WireConnection;83;0;81;0
WireConnection;83;1;82;0
WireConnection;5;0;4;0
WireConnection;5;1;3;0
WireConnection;84;0;83;0
WireConnection;6;0;5;0
WireConnection;69;0;68;0
WireConnection;30;0;29;0
WireConnection;94;0;93;0
WireConnection;94;1;92;0
WireConnection;7;0;2;0
WireConnection;8;0;6;0
WireConnection;8;1;7;0
WireConnection;85;0;30;0
WireConnection;85;1;69;0
WireConnection;85;2;84;0
WireConnection;100;0;94;0
WireConnection;100;1;101;0
WireConnection;102;0;100;0
WireConnection;102;1;8;0
WireConnection;86;0;85;0
WireConnection;98;0;86;0
WireConnection;98;1;99;0
WireConnection;9;0;11;0
WireConnection;9;1;10;0
WireConnection;9;2;102;0
WireConnection;43;0;9;0
WireConnection;43;1;98;0
WireConnection;0;2;43;0
WireConnection;0;9;41;0
ASEEND*/
//CHKSM=15FB2A25451DE2C1A1C9ED39C339133CA95414F4