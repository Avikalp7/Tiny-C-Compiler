#include <stdio.h>
#include "y.tab.h"
int main(){
	// yydebug=1;
	int val=yyparse();
	printf("Returned value is %d\n",val);
	return 0;
}