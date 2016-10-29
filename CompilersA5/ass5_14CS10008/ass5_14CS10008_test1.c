/*
First program for testing
*/
double dddd = 2.3;
int iiiii, wwww[10];
int aaaaaa = 4, *pppp, bbbbb;
int product(int arr[5][10], int n);
void main();
int product(int arr[10][5], int n) {
       int prod = 0, i, j = 9;
       for(i = 0; i < n; i++) {
               while(j >= 0) {
                       if(arr[i][j] > 0)
                               prod = prod + arr[i][j];
                       --j;
               }
       }
       return prod;
}

void main() {
       int a[15][5][10];
       int my_prod = 0;
       int i = 0;
       do {
            a[0][0][i] = i;
            i++;
       } while(i < 10);

       my_prod = product(a[0], 5);

       return;
}
