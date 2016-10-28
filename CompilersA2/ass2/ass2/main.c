#include <stdio.h>
#include "myl.h"
#define mxx 100 

int main()
{
  char str[mxx];
  char ch;
  int i = 0;
  int n, t;
  printf("Enter your stream of characters\n");
  while((ch=getchar()) != '\n')
  {
    str[i] = ch;
    i += 1;
  }
  str[i] = '\0';

  printf("The character stream entered by you is : \n");
  int num_of_chars = prints(str);
  printf("\nNumber of characters : %d\n",num_of_chars);

  printf("\nEnter an integer \n");
  n = readi(&t);

  if(t)
     printf("Invalid Input\n");
  else{
      printf("The number entered by you is : \n");
      num_of_chars = printi(n);
      printf("\nNumber of characters : %d\n",num_of_chars);
  }

  printf("\nEnter a floating point number\n");
  float num;
  t = readf(&num);
  if(t)
     printf("Invalid Input\n");
  else{
      printf("The number you entered : \n");
      num_of_chars = printd(num);
      printf("\nThe number of characters : \n");
      printf("%d\n",num_of_chars);
  }
  return 0;
}
