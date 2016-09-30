#include "types.h"
#include "user.h"

int main(void) {  

    getprocessinfo();  
    
    //force to give up cpu before calling priority

    int a = 0;
    int b = 0;
    int c = 0;

    while(c < 50000) {
        a = a + c;
        b = b + (c - b);
        c++;
        increasepriority();
    }//end while

    a = (a - 249975000) / 4;
    b = (b + 1) + (50000 * 5);

    printf(1, "A= %d\nB= %d\n", a, b);

    increasepriority();

    getprocessinfo();

    exit();
}//end main
