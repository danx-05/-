#include <stdio.h>
int main(){
    float a,b,c,x;
    printf("Input a: ");
    scanf("%f", &a);
    printf("Input b: ");
    scanf("%f", &b);
    printf("Input c: ");
    scanf("%f", &c);
    
    if (a == 0){
        if (b == c) {printf("equation has infinitely many solutions\n");}
        else{ printf("equation has not solution");}
    } else{
        x = (c - b) / a;
        printf("x=%.1f\n",x);
    }
    return 0;
}
