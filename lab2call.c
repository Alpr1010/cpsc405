#include "types.h"
#include "user.h"

int main(void) {
    //Prints out number of sys calls made
    printf(1, "Number of System Calls = %d\n", getcount());
    printf(1, " ", getprocessinfo());
    exit();
}//end main
