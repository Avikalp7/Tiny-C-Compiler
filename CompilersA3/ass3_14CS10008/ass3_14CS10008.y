%{
#include <stdio.h>
extern int yylex();
void yyerror(const char* s);
%}


%union {
  int intval;
  float floatval;
  char *charval;
}

%token KEYWORD
%token SINGLE_COMMENT
%token MULTILINE_COMMENT
%token IDENTIFIER
%token <intval> INTEGER_NO
%token <floatval> FLOAT_NO
%token <charval> CHARACTER
%token <charval> STRING
%token <intval> ENUMERATION_CONSTANT
%token PUNCTUATOR
%token WS

%%
st:KEYWORD;
%%

void yyerror(const char *s) {
    printf("ERROR : %s\n",s);
}
