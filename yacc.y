%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
%}

%token NUMBER
%token PLUS MINUS TIMES DIVIDE POWER
%token LEFT RIGHT
%token END

%left PLUS MINUS
%left TIMES DIVIDE
%left NEG
%right POWER

%start Input
%%

Input:
     { printf("Enter the expression\n"); }
     | Input Line
;

Line:
     END
     | Expression END { printf("Result = %f\n\n", $1); } { printf("Enter the expression\n"); }
;

Expression:
     NUMBER { $$=$1; }
| Expression PLUS Expression { $$=$1+$3; }
| Expression MINUS Expression { $$=$1-$3; }
| Expression TIMES Expression { $$=$1*$3; }
| Expression DIVIDE Expression { $$=$1/$3; }
| MINUS Expression %prec NEG { $$=-$2; }
| Expression POWER Expression { $$=pow($1,$3); }
| LEFT Expression RIGHT { $$=$2; }
;

%%

int yyerror(char *s) {
     printf("Entered expression is invalid!\n");
}

int main() {
     if (yyparse())
          fprintf(stderr, "Successful parsing.\n");
     else
          fprintf(stderr, "error found.\n");
}