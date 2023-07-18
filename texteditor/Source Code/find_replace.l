%{
#include<stdio.h>
#include<string.h>
char *find, *replace;
int find_first= 0, firstflag = 0 , foundflag = -1;
%}
%%
[a-zA-Z]+ { if ( strcmp ( yytext, find ) == 0 && ((find_first == 1 && firstflag == 0) || find_first == 0))
				{
				fprintf(yyout, "%s",replace); 
				firstflag = 1;
				foundflag = 1;
				}
			else 
				fprintf(yyout,"%s",yytext);
		   }
. {fprintf(yyout, "%s",yytext);}

%%

main(int argc, char* argv[])
{
/** ARGUMENTS TO MAIN:
 ** argv[0] - ./a.out
 ** argv[1] - 1 for find first , 0 for find all
 ** argv[2] - word to be found
 ** argv[3] - word to be replaced
 ** argv[4] - source filename
*/
	if(argc < 5)
	{
		//printf("Insufficient arguments\n");
		return;
	}
	
	FILE *fp1, *fp2;
	fp1 = fopen(argv[4],"r");
	fp2 = fopen("fnr.txt","w");
	
	yyin = fp1;
	yyout = fp2;
	find_first = atoi(argv[1]);
	find = argv[2];
	replace = argv[3];
	//intf("Enter 1 to find first, 0 to find all\n");
//scanf("%d",&find_first);
//	printf("Enter word to be found\n");
//	scanf("%s",find);
//	printf("Enter word to be replaced\n");
//	scanf("%s",replace);
	yylex();
	if(foundflag == -1)
		fprintf(yyout, "\n WORD WAS NOT FOUND!!\n");
	else
		fprintf(yyout, "\n WORD WAS FOUND AND REPLACED!! \n");
	
}

