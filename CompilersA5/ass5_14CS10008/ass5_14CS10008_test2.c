/*
Second program for testing
*/
void func(int i, double d);
int main();
void func(int i, double d){
	int a = i<<4;			
	int b = i&1;			
	int z = i*3;			
	i = i+ 3;
}
int main(){
	double m = 3.7;
	int i = 4;
	func(i,m);
	return 0;
}
