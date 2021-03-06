#include <stdio.h>

main(argc, argv)
int argc;
char *argv[];

{
	FILE *fpi, *fpo, *fopen();
	char srcfs[256] ;
	char buf[256];
	int i,j;

	if (argc == 1)
		return 0;
	else
		while (--argc > 0)
			if ((fpi = fopen(*++argv, "r")) == NULL) 
			{
				printf("cat: can't open %s\n", *argv);
				break;
			} 
			else 
			{
				strcpy(srcfs,*argv);  
				strcpy(buf, srcfs);
				strcat(buf, ".tmp");   
				if ((fpo = fopen(buf, "w")) == NULL) 
				{
					printf("cat: can't open %s\n", buf);
					break;
				}
				else
				{ 
					d2u(fpi,fpo);
					fclose(fpo);
					fclose(fpi);
					if ((fpi = fopen(buf, "r")) == NULL) 
					{
						printf("cat: can't open %s for copy back\n", buf);
						break;
					} 
					else
					if ((fpo = fopen(srcfs, "w")) == NULL) 
					{
						printf("cat: can't open %s for copy back\n", srcfs);
						break;
					} 
					else
					{
					filecopy(fpi,fpo);
					fclose(fpo);
					fclose(fpi);
					strcpy(srcfs,"rm ");
					strcat(srcfs, buf);
					system(srcfs);
					}
				}
			}
}

d2u(fpi,fpo)
FILE *fpi,*fpo;
{
	int c,c2;
	
	while ((c = getc(fpi)) != EOF)
	if (c != '\r') 
		putc(c, fpo);
	else
	{
		c2 = getc(fpi);
		if (c2 == EOF) 
		{
			putc('\n',fpo);
			break;
		}
		else if (c2 == '\n')
			putc('\n',fpo);
		else
		{
			putc(c, fpo);
			putc(c2, fpo);
		}
	}
}

filecopy(fpi,fpo)
FILE *fpi, *fpo;
{
	int c;
	
	while ((c = getc(fpi)) != EOF)
		putc(c, fpo);
}

