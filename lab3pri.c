#include "types.h"
#include "user.h"

int main(void) {  

    // Check Process Info
    getprocessinfo();  
    
    // Variables used
    int a = 1;
    int b = 1;
    int loop = 50000;

    // Loop to a number
    for(int i = 0; i < loop; i++) {
        // Do random computations to take up time on cpu
        a = (a + (a + 2 + (i / 2))) / 4;
        b = (b + i) / 2;

        // Increases priority if its now 0
        increasepriority();
    }//end while

    // Print out numbers (otherwise it appeared to not use up time)
    printf(1, "A= %d\nB= %d\n", a, b);

    // Increase priority
    increasepriority();

    // Check process info again
    getprocessinfo();

    exit();
}//end main
