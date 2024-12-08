%{
#include "task3.tab.h"
%}
%%
[0-9]+  { yylval = atoi(yytext); return NUMBER; }
"+"     { return PLUS; }
"-"     { return MINUS; }
"*"     { return MULT; }
"/"     { return DIV; }
"("     { return OPENPAR; }
")"     { return CLOSEPAR; }
\n      { return END; }
[ \t]   {}
.       {}
%%
int yywrap(){
    return 1;
}
