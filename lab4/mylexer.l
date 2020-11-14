%option noyywrap
%{
	#include<string.h>
    struct Table{
        int index;
        char* name;
    };
    using namespace std;
	int line=1;
    int yywrap();
    int wasdigit(const char* s1);
    int check(const char* y,const char* str);
    int plusplus(const char* y,const char* str);
    #define MMAX 200
    struct Table hashTable[MMAX];
    void init_hashTable(Table* hT);
    int get_index(char* text,int length);
    void get_n(char* text,int length);
%}

zhushi  "//".*
letter [a-zA-Z]
digit [0-9] 
blank  [\t\n ]
decimal ([1-9]*[0-9]+)
hex 0x([0-9a-fA-F]+)
oct 0([0-7])|([1-7][0-7]*)
exp {decimal}e{decimal}
HEADFILE #include<[a-zA-Z/+]*(\.h)?>
DEFINE #define[^\n]*
INTEGER {decimal}|{hex}|{oct}|{exp}
REAL {decimal}"."{decimal}
LB "{"
LP "("
RB "}"
RP ")"
PLUS {decimal}|{IDENTIFIER}{blank}?\+
MINUS {decimal}|{IDENTIFIER}{blank}?\-
MULT {decimal}|{IDENTIFIER}{blank}?\*
BIT {decimal}|{IDENTIFIER}{blank}?\&
BITAND {decimal}|{IDENTIFIER}{blank}?"&"
DIV "/"
MOD "%"
PLUSA "+="
MINUSA "-="
MULA "*="
DIVA "/="
MODA "%="
LS "<<"
RS ">>"
LSA "<<="
RSA ">>="
NOT "!"
BITOR "|"
XOR "^"
COMPL "~"
AND "&&"
OR "||"
LT "<"
LE "<="
GT ">"
GE ">="
EQ "=="
NE "!="
ASSIGN "="
DOT "."
MS "->"
LA "["
RA "]"
POSINC {IDENTIFIER}{blank}?"++"
POSDEC {IDENTIFIER}{blank}?"--"
PREINC "++"{blank}?{IDENTIFIER}
PREDEC "--"{blank}?{IDENTIFIER}
UNARYMINUS "-"
UNARYPLUS "+"
DEREFERECE "*"
ADDRESS "&"
COMMA ","
SC ";"
ASM "asm"
AUTO "auto"
BOOL "bool"
BREAK "break"
CASE "case"
CATCH "catch"
CHAR "char"
CLASS "class"
CONST "const"
C_CAST "c_cast"
CONTINUE "continue"
DEFAULT "default"
DELETE "delete"
DO "do"
DOUBLE "double"
D_CAST "d_cast"
ELSE "else"
ENUM "enum"
EXPLICIT "explicit"
EXTERN "extern"
FALSE "false"
FLOAT "float"
FOR "for"
FRIEND "friend"
GOTO "goto"
IF "if"
INLINE "inline"
INT "int"
LOG "log"
LONGLONG "long long"
LONGDOUBLE "long double"
LONG "long"
MUTABLE "mutable"
NAMESPACE "namespace"
NEW "new"
OPERATOR "operator"
PRIVATE "private"
PROTECTED "protected"
PUBLIC "public"
REGISTER "register"
R_CAST "r_cast"
RETURN "return"
SHORT "short"
SIGNED "signed"
SIZEOF "sizeof"
STATIC "static"
S_CAST "s_cast"
STRUCT "struct"
SWITCH "switch"
TEMPLATE "template"
THIS "this"
THROW "throw"
TRUE "true"
TRY "try"
TYPEDEF "typedef"
TYPEID "typeid"
TYPENAME "typename"
UNION "union"
UNSIGNED "unsigned"
USING "using"
VIRTUAL "virtual"
VOID "void"
VOLATILE "volatile"
WCHAR_T "wchar_t"
WHILE "while"
IDENTIFIER ({letter}|_)({letter}|{digit}|_)*
STRING \"[^"]*\"
CHARACTER \'[^']\'
zhushibegin "/*"
zhushielement .|\n
zhushiend   "*/"
%x COMMENT

%%
\n {++line;}
{zhushi} {printf("line%02d:   zhushi    %s    \n",line,yytext);}
{zhushibegin}   {printf("line%02d:   duohangzhushi    \n",line);BEGIN COMMENT;}
<COMMENT>{zhushielement} {get_n(yytext,yyleng);}
<COMMENT>{zhushiend} {BEGIN INITIAL;}
{INTEGER} {printf("line%02d:   INTEGER    %s    \n",line,yytext);}
{REAL} {printf("line%02d:   REAL    %s    \n",line,yytext);}
{HEADFILE} {printf("line%02d:   HEADFILE    %s    \n",line,yytext);}
{DEFINE} {printf("line%02d:   DEFINE    %s    \n",line,yytext);}
{LB} {printf("line%02d:   LB    %s    \n",line,yytext);}
{LP} {printf("line%02d:   LP    %s    \n",line,yytext);}
{RB} {printf("line%02d:   RB    %s    \n",line,yytext);} 
{RP} {printf("line%02d:   RP    %s    \n",line,yytext);} 
{PLUS} {check(yytext,"PLUS");}
{MINUS} {check(yytext,"MINUS");}
{MULT} {check(yytext,"MULT");}
{BITAND} {check(yytext,"BITAND");}
{DIV} {printf("line%02d:   DIV    %s    \n",line,yytext);}
{MOD} {printf("line%02d:   MOD    %s    \n",line,yytext);}
{PLUSA} {printf("line%02d:   PLUSA    %s    \n",line,yytext);}
{MINUSA} {printf("line%02d:   MINUSA    %s    \n",line,yytext);}
{MULA} {printf("line%02d:   MULA    %s    \n",line,yytext);}
{DIVA} {printf("line%02d:   DIVA    %s    \n",line,yytext);}
{MODA} {printf("line%02d:   MODA    %s    \n",line,yytext);}
{LS} {printf("line%02d:   LS    %s    \n",line,yytext);}
{RS} {printf("line%02d:   RS    %s    \n",line,yytext);}
{LSA} {printf("line%02d:   LSA    %s    \n",line,yytext);}
{RSA} {printf("line%02d:   RSA    %s    \n",line,yytext);}
{NOT} {printf("line%02d:   NOT    %s    \n",line,yytext);}
{BITOR} {printf("line%02d:   BITOR    %s    \n",line,yytext);}
{XOR} {printf("line%02d:   XOR    %s    \n",line,yytext);}
{COMPL} {printf("line%02d:   COMPL    %s    \n",line,yytext);}
{AND} {printf("line%02d:   AND    %s    \n",line,yytext);}
{OR} {printf("line%02d:   OR    %s    \n",line,yytext);}
{LT} {printf("line%02d:   LT    %s    \n",line,yytext);}
{LE} {printf("line%02d:   LE    %s    \n",line,yytext);}
{GT} {printf("line%02d:   GT    %s    \n",line,yytext);}
{GE} {printf("line%02d:   GE    %s    \n",line,yytext);}
{EQ} {printf("line%02d:   EQ    %s    \n",line,yytext);}
{NE} {printf("line%02d:   NE    %s    \n",line,yytext);}
{ASSIGN} {printf("line%02d:   ASSIGN    %s    \n",line,yytext);}
{DOT} {printf("line%02d:   DOT    %s    \n",line,yytext);}
{MS} {printf("line%02d:   MS    %s    \n",line,yytext);}
{LA} {printf("line%02d:   LA    %s    \n",line,yytext);}
{RA} {printf("line%02d:   RA    %s    \n",line,yytext);}
{UNARYPLUS} {printf("line%02d:   UNARYPLUS    %s    \n",line,yytext);}
{UNARYMINUS} {printf("line%02d:   UNARYMINUS    %s    \n",line,yytext);}
{DEREFERECE} {printf("line%02d:   DEREFERECE    %s    \n",line,yytext);}
{ADDRESS} {printf("line%02d:   ADDRESS    %s    \n",line,yytext);}
{COMMA} {printf("line%02d:   COMMA    %s    \n",line,yytext);}
{SC} {printf("line%02d:   SC    %s    \n",line,yytext);}
{ASM} {printf("line%02d:   ASM    %s    \n",line,yytext);}
{AUTO} {printf("line%02d:   AUTO    %s    \n",line,yytext);}
{BOOL} {printf("line%02d:   BOOL    %s    \n",line,yytext);}
{BREAK} {printf("line%02d:   BREAK    %s    \n",line,yytext);}
{CASE} {printf("line%02d:   CASE    %s    \n",line,yytext);}
{CATCH} {printf("line%02d:   CATCH    %s    \n",line,yytext);}
{CHAR} {printf("line%02d:   CHAR    %s    \n",line,yytext);}
{CLASS} {printf("line%02d:   CLASS    %s    \n",line,yytext);}
{CONST} {printf("line%02d:   CONST    %s    \n",line,yytext);}
{C_CAST} {printf("line%02d:   C_CAST    %s    \n",line,yytext);}
{CONTINUE} {printf("line%02d:   CONTINUE    %s    \n",line,yytext);}
{DEFAULT} {printf("line%02d:   DEFAULT    %s    \n",line,yytext);}
{DELETE} {printf("line%02d:   DELETE    %s    \n",line,yytext);}
{DOUBLE} {printf("line%02d:   DOUBLE    %s    \n",line,yytext);}
{D_CAST} {printf("line%02d:   D_CAST    %s    \n",line,yytext);}
{ELSE} {printf("line%02d:   ELSE    %s    \n",line,yytext);}
{ENUM} {printf("line%02d:   ENUM    %s    \n",line,yytext);}
{EXPLICIT} {printf("line%02d:   EXPLICIT    %s    \n",line,yytext);}
{EXTERN} {printf("line%02d:   EXTERN    %s    \n",line,yytext);}
{FALSE} {printf("line%02d:   FALSE    %s    \n",line,yytext);}
{FLOAT} {printf("line%02d:   FLOAT    %s    \n",line,yytext);}
{FOR} {printf("line%02d:   FOR    %s    \n",line,yytext);}
{FRIEND} {printf("line%02d:   FRIEND    %s    \n",line,yytext);}
{GOTO} {printf("line%02d:   GOTO    %s    \n",line,yytext);}
{IF} {printf("line%02d:   IF    %s    \n",line,yytext);}
{INLINE} {printf("line%02d:   INLINE    %s    \n",line,yytext);}
{INT} {printf("line%02d:   INT    %s    \n",line,yytext);}
{LOG} {printf("line%02d:   LOG    %s    \n",line,yytext);}
{LONG} {printf("line%02d:   LONG    %s    \n",line,yytext);}
{MUTABLE} {printf("line%02d:   MUTABLE    %s    \n",line,yytext);}
{NAMESPACE} {printf("line%02d:   NAMESPACE    %s    \n",line,yytext);}
{NEW} {printf("line%02d:   NEW    %s    \n",line,yytext);}
{OPERATOR} {printf("line%02d:   OPERATOR    %s    \n",line,yytext);}
{PRIVATE} {printf("line%02d:   PRIVATE    %s    \n",line,yytext);}
{PROTECTED} {printf("line%02d:   PROTECTED    %s    \n",line,yytext);}
{PUBLIC} {printf("line%02d:   PUBLIC    %s    \n",line,yytext);}
{REGISTER} {printf("line%02d:   REGISTER    %s    \n",line,yytext);}
{R_CAST} {printf("line%02d:   R_CAST    %s    \n",line,yytext);}
{RETURN} {printf("line%02d:   RETURN    %s    \n",line,yytext);}
{SHORT} {printf("line%02d:   SHORT    %s    \n",line,yytext);}
{SIGNED} {printf("line%02d:   SIGNED    %s    \n",line,yytext);}
{SIZEOF} {printf("line%02d:   SIZEOF    %s    \n",line,yytext);}
{STATIC} {printf("line%02d:   STATIC    %s    \n",line,yytext);}
{S_CAST} {printf("line%02d:   S_CAST    %s    \n",line,yytext);}
{STRUCT} {printf("line%02d:   STRUCT    %s    \n",line,yytext);}
{SWITCH} {printf("line%02d:   SWITCH    %s    \n",line,yytext);}
{TEMPLATE} {printf("line%02d:   TEMPLATE    %s    \n",line,yytext);}
{THIS} {printf("line%02d:   THIS    %s    \n",line,yytext);}
{THROW} {printf("line%02d:   THROW    %s    \n",line,yytext);}
{TRUE} {printf("line%02d:   TRUE    %s    \n",line,yytext);}
{TRY} {printf("line%02d:   TRY    %s    \n",line,yytext);}
{TYPEDEF} {printf("line%02d:   TYPEDEF    %s    \n",line,yytext);}
{TYPEID} {printf("line%02d:   TYPEID    %s    \n",line,yytext);}
{TYPENAME} {printf("line%02d:   TYPENAME    %s    \n",line,yytext);}
{UNION} {printf("line%02d:   UNION    %s    \n",line,yytext);}
{UNSIGNED} {printf("line%02d:   UNSIGNED    %s    \n",line,yytext);}
{USING} {printf("line%02d:   USING    %s    \n",line,yytext);}
{VIRTUAL} {printf("line%02d:   VIRTUAL    %s    \n",line,yytext);}
{VOID} {printf("line%02d:   VOID    %s    \n",line,yytext);}
{VOLATILE} {printf("line%02d:   VOLATILE    %s    \n",line,yytext);}
{WCHAR_T} {printf("line%02d:   WCHAR_T    %s    \n",line,yytext);}
{WHILE} {printf("line%02d:   WHILE    %s    \n",line,yytext);}
{LONGLONG} {printf("line%02d:   LONGLONG    %s    \n",line,yytext);}
{LONGDOUBLE} {printf("line%02d:   LONGDOUBLE    %s    \n",line,yytext);}
{IDENTIFIER} {printf("line%02d:   IDENTIFIER    %s    %d\n",line,yytext,get_index(yytext,yyleng));}
{POSINC} {plusplus(yytext,"POSINC");}
{POSDEC} {plusplus(yytext,"POSDEC");}
{PREINC} {plusplus(yytext,"PREINC");}
{PREDEC} {plusplus(yytext,"PREDEC");}
{STRING} {printf("line%02d:  STRING    %s    \n",line,yytext);}
{CHARACTER} {printf("line%02d:  CHARACTER    %s    \n",line,yytext);}
{blank} {}
%%

void init_hashTable(Table* hT){
    for(int i = 0;i<MMAX;i++){
        hT[i].name = new char[20];
        strcpy(hT[i].name,"0");
        hT[i].index = 0;
    }
};

int get_index(char* text,int length){
    int hash = 0;
    for(int i = 0;i<length;i++){
        hash += (text[i] - 'A' + 1) * (i + 1);
    }
    hash %= MMAX;
    while(1){
        if(strcmp(hashTable[hash].name,"0")==0){
            strcpy(hashTable[hash].name,text);
            return hash;
        }
        else{
            if(strcmp(hashTable[hash].name,text)==0){
                return hash;
            }
            else{
                hash=(hash+1)%200;
            }
        }
    }
};
void get_n(char* text,int length){
    if(text[0]=='\n'){
        ++line;
    }
};
int yywrap(){
	return 1;
}
int wasdigit(const char* s1) {
    int len=strlen(s1);
    int t=0;
    for(int i=0;i<len;++i) { 
        if(!isdigit(*(s1+i))&&*(s1+i)!='.')
            return 0;
        if(*(s1+i)=='.')
            ++t;
        if(*(s1+i+1)=='.') {
            ++t;
            ++i;
            if(t>1)
              return 0;
        }
    }
    return 1;
}
int check(const char* y,const char* str) {
	// 消除 + - * & 二义性
    int len=strlen(y);
    char id[len];
    for(int i=0;i<len-1;++i){
        id[i]=*(y+i);
    }
    id[len-1]='\0';
    if(!wasdigit(id))
        printf("line%02d:   IDENTIFIER    %s    %s\n",line,id,id);
    else 
        printf("line%02d:   num    %s    %s\n",line,id,id);
    printf("line%02d:   %s   %c    %c\n",line,str,y[len-1],y[len-1]);
    return 0;
}
int plusplus(const char* y,const char* str){
  //识别a++和++a
    int len=strlen(y);
    if(y[0] == '+' || y[0] == '-'){
        printf("line%02d:   %s   %c%c  \n",line,str,y[0],y[1]);
        char id[len-1];
        for(int i=2;i<len;i++){
            id[i-2] = y[i];
        }
        id[len-2] = '\0';
        printf("line%02d:   IDENTIFIER    %s    %s\n",line,id,id);
    }
    else{
        char id[len-1];
        for(int i=0;i<len-2;i++){
            id[i] = y[i];
        }
        id[len-2] = '\0';
        printf("line%02d:   IDENTIFIER    %s    %s\n",line,id,id);
        printf("line%02d:   %s   %c%c  \n",line,str,y[len-1],y[len-2]);
    }
    return 1;
}

int main(int argc,char*argv[]) {
    if(argc!=2){
        printf("File's name WRONG.Please input correct name.\n");
        return 1;
    }
    printf("单词    词素    属性\n");
	int n = 1;
	yyFlexLexer lexer;
	
	init_hashTable(hashTable);
	freopen(argv[1],"r",stdin);
		
	n = lexer.yylex();
		
	freopen("CON","r",stdin);
	
	system("pause");
	return n;
}
