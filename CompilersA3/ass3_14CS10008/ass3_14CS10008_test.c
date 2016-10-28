#include <stdio.h>
#include <math.h>

#define W 1000000007

static int my_int = 23;

struct calc{
	register signed int x;
	const int int_;
	float float_;
	double _double;
	long _long;
};

typedef calc CALCVAR;

float my_func(volatile short short_var){
	restrict char c = 'Z';
	return 0.00099;
}

extern double my_function(...);

/*
This
is
a
multiline 
comment
*/

// Hello world

int main(){
	char _string[6] = "hello";
	double my_double = .33 * (4.3e-2) + (1.2E2) / 2.0;
	_Imaginary im;
	_Bool b;
	_Complex cc;

	int j = 2;
	for(unsigned int i = 1;i < j*2;i++)
	{
		i+=2;
		i-=1;
		i*=0;
		i/=1;
		i%=4;
		i<<=2;
		i>>=2;
		if(i && i != 1 || i == -10 && i < -2 || i >3 || i<=1)
		{
			do{
				while(!j){
					j--;
					switch(j){
						case 0 : j = j&1; break;
						case 1 : j ^= 0;
						case 2 : j |= i;
						case 3 : j &= j;
						case 4 : j = (int)sizeof(calc);
						default : j--;
					}
					continue;
				}
			}
			while(j>=0)
			j = i==1? 1:2;
			goto A;
		}
		A :
		else if(i==1000){
			~my_double;
			i = 100;
		}
		else
		{
			i = 1000;
		}
	}

	return 0;
}

union unionise{		
	signed int y;
	auto float fff;
};