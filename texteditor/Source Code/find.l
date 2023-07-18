%{
#include<stdio.h>
#include<string.h>
char *find;
int find_first= 0, firstflag = 0 , foundflag = -1, count = 0;
%}
%%
[a-zA-Z]+ { if ( strcmp ( yytext, find ) == 0 && ((find_first == 1 && firstflag == 0) || find_first == 0))
				{
				fprintf(yyout, "%s",yytext);
				firstflag = 1;
				foundflag = 1;
				count++;
				}
			else 
				{
				fprintf(yyout,"%s",yytext);
				}
		   }
. {fprintf(yyout, "%s",yytext);}

%%

main(int argc, char* argv[])
{
/** ARGUMENTS TO MAIN:
 ** argv[0] - ./a.out
 ** argv[1] - 1 for find first , 0 for find all
 ** argv[2] - word to be found
 ** argv[3] - source filename
*/
	if(argc < 4)
	{
		//printf("Insufficient arguments\n");
		return;
	}
	
	FILE *fp1, *fp2;
	fp1 = fopen(argv[3],"r");
	fp2 = fopen("fnr.txt","w");
	
	yyin = fp1;
	yyout = fp2;
	find_first = atoi(argv[1]);
	find = argv[2];
	yylex();
	if(find_first == 1 && foundflag == 1)
		fprintf(yyout, "\n FIRST OCCURENCE FOUND!! \n");
	else if (find_first == 0 && foundflag == 1 )
	fprintf(yyout, "No of occurences found is %d \n", count);
	else if(foundflag == -1)
	fprintf(yyout,"\n WORD NOT FOUND!! \n");
}

