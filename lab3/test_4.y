%{
/*************************
test_4.y
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
double a = 0;
double b = 10;
double c = 100;
int flag = 0;
void yyerror(const char* s);
%}


%token ADD
%token SUB
%token MUL
%token DIV
%token LBRACKET
%token RBRACKET
%token DIGIT
%token ID

%left ADD SUB
%left MUL DIV
%right UMINUS

%%


lines   :   expr '=' expr '\n' {
            if($1 == 0){
                a = $3;
            }else if($1 == 1){
                b = $3;
            }else if($1 == 2){
                c = $3;
            };
            printf("a = %f , b = %f , c = %f\n",a,b,c);}
        |   lines '\n'
        |
        ;

expr    :   expr ADD expr { $$ = $1 + $3; } 
        |   expr SUB expr { $$ = $1 - $3; }
        |   expr MUL expr { $$ = $1 * $3; }
        |   expr DIV expr { $$ = $1 / $3; }
        |   LBRACKET expr RBRACKET { $$ = $2; }
        |   SUB expr %prec UMINUS { $$ =-$2; }
        |   DIGIT
        |   ID
        ;

%%


int yylex()
{ 
    int t;
    while(1){
        t = getchar();
        if (t == ' ' || t == '\t') {
            ;
        }
        if(t == 'a' || t == 'b' || t == 'c'){
            if (flag == 0){
                flag = 1;
                yylval = t - 'a';
            }else{
                if (t == 'a'){
                    yylval = a;
                }else if ( t == 'b'){
                    yylval = b;
                }else if ( t == 'c'){
                    yylval = c;
                }
            }
            return ID;
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
                if (t == ' ' || t == '\t') { 
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