#include<stdio.h>
#define OK 0
#define ERR 1
#define mx 20

int prints(char *s)
{
    int char_count;
    for(char_count = 0; s[char_count] != '\0'; char_count++)
    {
        // Empty loop
    }

    __asm__ __volatile__ (
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t" 
        "syscall \n\t"
        :
        :"S"(s), "d"(char_count)
    );
    return char_count;
}


int printi(int n)
{
    char buffer[mx];
    char zero = '0';
    int i = 0, j = 0;
    int char_count, k;
    if(n <= -1)
    {
        buffer[i] = '-';
        n *= -1;
        i += 1;
    }
    if(n == 0)
    {
        buffer[i] = zero;
        i += 1;
    }
    while(n != 0)
    {
        buffer[i] = (char)(n%10 + zero);
        i += 1;
        n /= 10;
    }

    if(buffer[0] == '-')
        j = 1<<0;

    k = --i;
    i++;
    char_count = i;

    while(j < k)
    {
        char temp;
        temp = buffer[j];
        buffer[j++] = buffer[k];
        buffer[k--] = temp;
    }
    __asm__ __volatile__ (
        "movl $1, %%eax \n\t"
        "movq $1, %%rdi \n\t"           
        "syscall \n\t"
        :
        :"S"(buffer), "d"(char_count)
    );

	return char_count;
}

int printd(float f)
{
    int fint;
    fint = (int)f;
    int n = printi(f);
    char zero[2] = "0";
    n += prints(".");
    f = f - fint;   
    while((f-(int)f) != 0)
    {
      f*=10;

      if(!(int)f)
      {
          prints(zero);
          n++;
      }

    }

    if(f < 0)
    {
      f *= -1;
    }

    n = n + printi(f);

    return n;
}

int readi (int* eP) 
{
    int i = 0;
    char c;
    int sign = 1;
    int val = 0;
    *eP = OK;
    while(1)
    {
        __asm__ __volatile__ (
            "syscall"::"a"(0), "D"(0), "S"(&c), "d"(1)
            );
        if(c == '\n' || c == '\t'|| c == ' ')
            break;
        if(i == 0 && c == '-')
            sign = -1;
        else
        {
            if(c < '0' || c > '9')
                *eP = ERR;
            else
            {
                val *= 10;
                val += (int)(c - '0');
            }
        }

        i += 1;
    }

    return val*sign;
}

int readf(float *fP)
{
    int i = 0, IsFraction = 0, status=OK;
    char c;
    int sign = 1, val = 0;
    float fraction = 0.0;
    int Dot = 0;
    float fplier = 0.1;
    while(1)
    {
        __asm__ __volatile__ ("syscall"::"a"(0), "D"(0), "S"(&c), "d"(1));
        if(c ==' ' || c == '\t' || c =='\n')
          break;
        else if(c =='.')
        {
            IsFraction=1;
            Dot++;
        }
        else if(i==0 && c =='-') 
          sign=-1;
        else
        {
            if(c >'9' || c <'0' )
                return ERR;
            else
            {
                if(!IsFraction)
                {
                    val *= 10;
                    val += (int)(c - '0');
                }
                else if(IsFraction && Dot==1)
                {
                    fraction = fraction + fplier*((int)(c - '0'));
                    fplier *= 0.1;
                }
                else 
                {
                    return ERR;
                }
            }
        }

        i += 1;
    }

    *fP = (((float)val + fraction) * sign);
    return OK;
}


int main()
{
  char str[100];
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
