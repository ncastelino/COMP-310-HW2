//help from c standard library tutorial site

#include<stdio.h>

int main() {

 char c;

 printf("Type in a character:");
 c = getc(stdin);
 printf("Character: ");
 putc(c, stdout);

 return(0);

}
