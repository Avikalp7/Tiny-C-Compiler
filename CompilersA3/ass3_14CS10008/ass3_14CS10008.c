#include <stdio.h>
#include "y.tab.h"
extern char* yytext;
main(){
	int token;
	while(token=yylex()){
		if(token==KEYWORD)printf("<KEYWORD, %d, %s >\n",token,yytext);
		else if(token==SINGLE_COMMENT)printf("<SINGLELINE COMMENT, %d >\n",token);
		else if(token==MULTILINE_COMMENT)printf("<MULTILINE COMMENT, %d >\n",token);
		else if(token==IDENTIFIER)printf("<IDENTIFIER, %d, %s >\n",token,yytext);
		else if(token==INTEGER_NO)printf("<INTEGER, %d, %d >\n",token,yylval.intval);
		else if(token==FLOAT_NO)printf("<FLOAT, %d, %s >\n",token,yytext);
		else if(token==CHARACTER)printf("<CHAR, %d, %s >\n",token,yytext);
		else if(token==STRING)printf("<STRING, %d, %s >\n",token,yytext);
		else if(token==PUNCTUATOR)printf("<PUNCTUATOR, %d, '%s' >\n",token,yytext);
	}
}
