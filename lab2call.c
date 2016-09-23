#include "types.h"
#include "user.h"

int main(void) {
    //Prints out number of sys calls made
    //why does the print statement need an int first according to user.h?
    printf(0, "Number of System Calls = %d\n", getcount());
    exit();
}//end main
