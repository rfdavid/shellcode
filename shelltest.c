/* Coded by finger <finger@antisocial.com> */

#include <stdio.h>
#include <linux/types.h> // ahaha

#define ERR -1

int main (argc, argv, envp)
   int argc;
   char *argv[];
   char *envp;
{
	FILE	*fd;
	char	*shell;
	char	(*ret)();
	int	len;
	__u8	c;
	__u32	lbreak = 0;

	if (argc != 2) {
		fprintf(stderr,"Shellcode Gen & test\x0a");
		fprintf(stderr,"./shelltest <arquivo_bin>\x0a");
		exit (ERR);
	}

	if ( (fd = fopen (argv[1], "rb") ) == NULL) {
		perror ("fopen");
		exit (ERR);
	}

	fseek (fd, 0L, SEEK_END);
	len = ftell(fd);
	fseek (fd, 0L, SEEK_SET);

	if ( !(shell = (char *) malloc(len))) {
		perror ("malloc");
		exit (ERR);
	}

	if ( fread(shell, 1, len, fd) != len) {
		perror("fread");
		exit (ERR);
	}

	fprintf(stderr,"Bytes: %d\n",len);

	printf("\nchar shellcode[] = \n\"");

	ret = (char (*)())shell;

	while(c = *shell++) {
		len--;
		printf("\\x%02x", c);

		if(lbreak++ == 13) {
			printf("\"\n\"");
			lbreak-=lbreak;
		}
	}

	printf("\";\n\n");

	if (len > 0) {
		printf("\n\nNull byte detectado\n");
		exit (ERR);
	}

	printf("int main() {\n");
	printf("void (*ret)() = (void *)shellcode;\n");
	printf("  ret();\n");
	printf("}\n");

	fprintf(stderr,"\n\nTestar shellcode? (s/n) ");
	if (getchar() == 's')
		(*ret)();
	else

	fclose(fd);
	exit(1);
}