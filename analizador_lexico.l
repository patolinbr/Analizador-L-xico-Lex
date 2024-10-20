%{
#include <stdio.h>
%}

%option noyywrap

%%
"//".*              {printf("COMMENT\n");}
f                   {printf("FLOATDCL\n");}
i                   {printf("INTDCL\n");}
p                   {printf("PRINT\n");}
[a-egh-oq-z]        {printf("ID\n");}
=                   {printf("ASSIGN\n");}
[0-9]+\.[0-9]{1,5}  {printf("FNUM\n");}
[0-9]+              {printf("INUM\n");}
\+                  {printf("PLUS\n");}
\-                  {printf("MINUS\n");}
\*                  {printf("TIMES\n");}
\/                  {printf("DIVIDED BY\n");}
[ \t\n]+            {/* Ignore whitespace */}
.                   {printf("ERROR: %s\n", yytext);}
%%

int main(int argc, char **argv) {
    FILE *fd;

    if (argc == 2) {
        if (!(fd = fopen(argv[1], "r"))) {
            perror("Error: ");
            return -1;
        }
        yyset_in(fd);
        yylex();
        fclose(fd);
    } else {
        printf("Usage: a.out filename\n");
    }
    return 0;
}
