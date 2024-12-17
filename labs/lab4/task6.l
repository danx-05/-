%{
#include "task6.tab.h"
%}

%%

"print"      { return PRINT; }
"for"        { return FOR; }
"if"         { return IF; }
"while"      { return WHILE; }
";"          { return yytext[0]; }
">"          { return yytext[0]; }
"<"          { return yytext[0]; }
"+"          { return yytext[0]; }
"-"          { return yytext[0]; }
"="          { return yytext[0]; }
"!="         { return NEQ; }
"x"          { return VARIABLE; }
"{"          { return yytext[0]; }
"}"          { return yytext[0]; }
"("          { return yytext[0]; }
")"          { return yytext[0]; }
[0-9]+       { yylval.number = atoi(yytext); return NUM; }
[ \t\n]+     { /* игнорировать пробелы, табуляции и новые строки */ }
.            { fprintf(stderr, "Нераспознанный символ: %s\n", yytext); }

%%

int yywrap() {
    return 1;
}
