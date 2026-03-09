D                       [0-9]
L                       [a-zA-Z_]
H                       [a-fA-F0-9]
E                       [Ee][+-]?{D}+
FS                      (f|F|l|L)
IS                      (u|U|l|L)*

%{
#include <stdio.h>
#include "structfe.tab.h"
/*changed from #include "y.tab.h" as it wouldn't compile*/

/* Ne gère pas les commentaires. A rajouter */
/* Supprimer les lignes dont vous n'avez pas besoin. */

%}

%%
"break"                 { /* A completer */ }
"case"                  { /* A completer */ }
"char"                  { /* A completer */ }
"const"                 { return CONSTANT; }
"continue"              { /* A completer */ }
"default"               { /* A completer */ }
"do"                    { /* A completer */ }
"double"                { /* A completer */ }
"else"                  { return ELSE; }
"enum"                  { /* A completer */ }
"extern"                { return EXTERN; }
"float"                 { /* A completer */ }
"for"                   { return FOR; }
"if"                    { return IF; }
"int"                   { return INT;}
"long"                  { /* A completer */ }
"register"              { /* A completer */ }
"return"                { return RETURN; }
"short"                 { /* A completer */ }
"signed"                { /* A completer */ }
"sizeof"                { return SIZEOF; }
"static"                { /* A completer */ }
"struct"                { return STRUCT; }
"typedef"               { /* A completer */ }
"union"                 { /* A completer */ }
"unsigned"              { /* A completer */ }
"void"                  { return VOID; }
"volatile"              { /* A completer */ }
"while"                 { return WHILE; }

{L}({L}|{D})*           { return IDENTIFIER; }

0[xX]{H}+{IS}?          { /* hex integer constants*/ return CONSTANT; }
0{D}+{IS}?              { /* octal integers */ return CONSTANT; }
{D}+{IS}?               { /* dec integers*/ return CONSTANT; }
L?'(\\.|[^\\'])+'       { /* A completer */ return CONSTANT;}

{D}+{E}{FS}?            { return CONSTANT;} /*not sure if we need to account for all these cases*/
{D}*"."{D}+({E})?{FS}?  {  return CONSTANT; }
{D}+"."{D}*({E})?{FS}?  { return CONSTANT;}

L?\"(\\.|[^\\"])*\"     { /* A completer */ }

"..."                   { /* A completer */ }
">>="                   { /* A completer */ }
"<<="                   { /* A completer */ }
"+="                    { /* A completer */ }
"-="                    { /* A completer */ }
"*="                    { /* A completer */ }
"/="                    { /* A completer */ }
"%="                    { /* A completer */ }
"&="                    { /* A completer */ }
"^="                    { /* A completer */ }
"|="                    { /* A completer */ }
">>"                    { /* A completer */ }
"<<"                    { /* A completer */ }
"++"                    { /* A completer */ }
"--"                    { /* A completer */ }
"->"                    { return PTR_OP; }
"&&"                    { return AND_OP; }
"||"                    { return OR_OP; }
"<="                    { return LE_OP;}
">="                    { return GE_OP; }
"=="                    { return EQ_OP;}
"!="                    { return NE_OP; }

[ \t\v\n\f]             { /*ignore whitespace*/ }
.                       { return yytext[0]; }
%%

