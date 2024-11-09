%{
#include <stdio.h>
int yylex();
void yyerror(char* str);
int main(int argc, char** argv);
%}
%token NUMBER
%token PLUS MINUS MULT DIV
%token OPENPAR CLOSEPAR
%token END
%%
expression: %empty
    | expression exp END { printf("\n"); }
    ;
exp: term
    | exp PLUS term    { printf("+ "); }
    | exp MINUS term    { printf("- "); }
    ;
term: factor
    | term MULT factor { printf("* "); }
    | term DIV factor  { printf("/ "); }
factor: NUMBER  { printf("%d ", $1); }
    | OPENPAR exp CLOSEPAR {}
    ;
%%
void yyerror(char* str) {
    fprintf(stderr, "[ERROR]: %s\n", str);
}
int main(int argc, char** argv) {
    yyparse();
    return 0;
}
