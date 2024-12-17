%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
void yyerror(const char* s) {
	fprintf(stderr, "Ошибка: %s\n", s);
};
%}

%union {
	int number;
}

%token VARIABLE NEQ IF WHILE FOR PRINT 
%token <number> NUM
%type <number> expr

%%
stmts:	%empty
	| stmts stmt {  printf("X .FILL #1\n\n");
			printf(".ORIG x3000\n");
			printf("LD R1, X\n;"); }
	;

stmt:	equal
	| if
	| while
	| for
	| print
	;

equal: VARIABLE '=' expr { printf("LD R1, #%d\n", $3); }
	;

expr:	NUM 
	| VARIABLE { $$ = 0; }
	| expr '-' NUM { $$ = $1 + $3; printf("ADD R1, R1, #-%d\n", $3); }
	| expr '+' NUM { $$ = $1 + $3; printf("ADD R1, R1, #%d\n", $3); }
	;

if: IF '(' cond ')' '{' stmt '}'
	{ printf("END\n");
	  printf("HALT\n");}
	;

while: WHILE '(' cond ')' '{' stmt '}'
	{ printf("BRnzp LOOP\n"); 
	  printf("  END\n"); 
	  printf("HALT\n");}
	| WHILE '(' cond ')'
	{ printf("BRnzp LOOP\n");
          printf("  END\n");
          printf("HALT\n");}
	;

for: FOR '(' equal ';' cond ';' expr ')''{' stmts '}'
	{ printf("BRnzp LOOP\n");
	 printf("  END\n"); 
	 printf("HALT\n");}
	| FOR '(' equal ';' cond ';' expr ')' '{' '}'
        { printf("BRnzp LOOP\n"); 
          printf("END\n"); 
          printf("HALT\n");}
	;

print: PRINT '(' VARIABLE ')' { printf("LD R0, R1, #0\nOUT\n"); }

cond:	VARIABLE '>' NUM
	{ printf("LD R2, #%d\n  LOOP\nADD R3, R1, R2\nBRnz END\n", -$3); }
	| VARIABLE '=' NUM
	{ printf("LD R2, #%d\nNOT R2, R2\nADD R2, R2, #1\n  LOOP\nADD R3, R1, R2\nBRnp END\n", $3); }
	| VARIABLE '<' NUM
	{ printf("LD R2, #%d\n  LOOP\nADD R3, R1, R2\nBRzp END\n", -$3); }
	| VARIABLE NEQ NUM
	{ printf("LD R2, #%d\nNOT R2, R2\nADD R2, R2, #1\n  LOOP\nADD R3, R1, R2\nBRz END\n", $3); }
	;

%%
int main() {
    printf(".ORIG x3000\n");
    printf("LD R1, X\n;");
    yyparse();
    return 0;
}
