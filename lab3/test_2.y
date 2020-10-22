%{
/*************************
test_2.y
YACC file
Date: 2020/10/16
Made by Buchiyexiao. from NK
Zijie Zhao <1091404874@qq.com>
*************************/
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#ifndef YYSTYPE
#define YYSTYPE double
#endif
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}

%token ADD
%token SUB
%token MUL
%token DIV
%token LBRACKET
%token RBRACKET
%token DIGIT

%left ADD SUB
%left MUL DIV
%right UMINUS

%%


lines   :   lines expr '=\n' { printf("The result is :%f\n", $2); }
        |   lines '=\n'
        |
        ;

expr    :   expr ADD expr { $$ = $1 + $3; }
        |   expr SUB expr { $$ = $1 - $3; }
        |   expr MUL expr { $$ = $1 * $3; }
        |   expr DIV expr { $$ = $1 / $3; }
        |   LBRACKET expr RBRACKET { $$ = $2; }
        |   SUB expr %prec UMINUS { $$ =-$2; }
        |   DIGIT
        ;

%%


int yylex()
{
    int t;
    while(1){
        t = getchar();
        if (t == ' ' || t == '\t' || t == '\n') {
            ;
        }
        else if (t == '+'){
            return ADD;
        }
        else if (t == '-'){
            return SUB;
        }
        else if (t == '*'){
            return MUL;
        }
        else if (t == '/'){
            return DIV;
        }
        else if (t == 'q'){
            exit(0);
        }
        else if (isdigit(t)){
            yylval = 0;
            yylval = yylval * 10 + t - '0';
            int flag = 0;
            while (isdigit(t)){
                if (flag == 1){
                    flag = 0;
                }else{
                    t = getchar();
                }
                if (t == ' ' || t == '\t' || t == '\n') {
                    t = getchar();
                    flag = 1;
                    continue;
                }
                if (isdigit(t)){
                    yylval = yylval * 10 + t - '0';
                }
            }
            ungetc(t,stdin);
            return DIGIT;
        }
        else{
            return t;
        }
    }
    // place your token retrieving code here
    return getchar ();
}

int main(void)
{
    yyin = stdin ;
    do {
            yyparse();
    } while (! feof(yyin));
    return 0;
}
void yyerror(const char* s) {
    fprintf(stderr,"Parse error: %s\n",s);
    exit(1);
}