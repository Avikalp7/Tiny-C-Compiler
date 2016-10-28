%option noyywrap
%{
#include <stdio.h>
#include <math.h>
#include <string.h>
#include "y.tab.h"
%}

KEYWORD             "auto"|"break"|"case"|"char"|"const"|"continue"|"default"|"do"|"double"|"else"|"enum"|"extern"|"float"|"for"|"goto"|"if"|"inline"|"int"|"long"|"register"|"restrict"|"return"|"short"|"signed"|"sizeof"|"static"|"struct"|"switch"|"typedef"|"union"|"unsigned"|"void"|"volatile"|"while"|"_Bool"|"_Complex"|"_Imaginary"
IDENTIFIER			[_a-zA-Z][_a-zA-Z0-9]*
DIGIT		 		[0-9]
INTEGER_CONST		[1-9]{DIGIT}*|0
FLOATING_CONST		(((([0-9]+)?\.[0-9]+)|([0-9]+\.))([eE][+-]?[0-9]+)?)|([0-9]+[eE][+-]?[0-9]+)
ENUMERATION_CONST	[_a-zA-Z][_a-zA-Z0-9]* 
ESCAPE_SEQUENCE		\\['"?\\abfnrtv]
C_CHAR				[^'\\\n]|{ESCAPE_SEQUENCE}
C_CHAR_SEQUENCE		{C_CHAR}+
CHARACTER_CONST		\'{C_CHAR_SEQUENCE}\'
CONSTANT            {INTEGER_CONST}|{FLOATING_CONST}|{ENUMERATION_CONST}|{CHARACTER_CONST}
S_CHAR				[^"\\\n]|{ESCAPE_SEQUENCE}
PUNCTUATOR			"["|"]"|"."|"->"|"++"|"--"|"&"|"*"|"+"|"-"|"~"|"!"|"/"|"("|")"|"{"|"}"|"%"|"^="|"|="|","|"<<"|">>"|"<"|">"|"!="|"^"|"|"|"&&"|"||"|"..."|"="|"*="|"/="|"?"|":"|";"|"%="|"+="|"-="|"<<="|">>="|"&="|"#"
S_CHAR_SEQUENCE		{S_CHAR}+
STRING_LITERAL		\"{S_CHAR_SEQUENCE}?\"
SINGLE_COMMENT  	\/\/.*
MULTILINE_COMMENT	\/\*([^*]|[\r\n]|(\*+([^*/]|[\r\n])))*\*\/
WS 					[ \t\n]

%%
{KEYWORD}			{return KEYWORD;}
{IDENTIFIER}		{return IDENTIFIER;}
{INTEGER_CONST}		{yylval.intval = atoi(yytext); return INTEGER_NO;}
{ENUMERATION_CONST}	{return ENUMERATION_CONSTANT;}	 
{FLOATING_CONST}	{return FLOAT_NO;}
{CHARACTER_CONST}	{return CHARACTER;}
{STRING_LITERAL}	{return STRING;}
{PUNCTUATOR}		{return PUNCTUATOR;}
{SINGLE_COMMENT}    {return SINGLE_COMMENT;}
{MULTILINE_COMMENT}	{return MULTILINE_COMMENT;}
{WS}				{}
%%