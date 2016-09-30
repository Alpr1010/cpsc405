#include "types.h"
#include "user.h"

int main(void) {
    //Test out running process info

    int child = fork();

    if(child < 0) {
        exit();
    }//end if
    else if (child == 0) { //child1
        int child2 = fork();

        if(child2 < 0) {
            exit();
        }//end if
        else if(child2 == 0) { //child2
            int child3 = fork();

            if(child3 < 0) {
                exit();
            }//end if
            else if(child3 == 0) { //child3
                int child4 = fork();

                if(child4 < 0) {
                    exit();
                }//end if
                else if(child4 == 0) { //child4
                    printf(1, "Child4 printing\n");
                    getprocessinfo();
                }//end else if (child4)
                else {
                    wait();
                    printf(1, "Child3 printing\n");
                    getprocessinfo();
                }//end else (child3)
            }//end else if (child3)
            else {
                wait();
                printf(1, "Child2 printing\n");
                getprocessinfo();
            }//end else (child2)
        }//end else if (child2)
        else {
            wait();
            printf(1, "Child1 printing\n");
            getprocessinfo();
        }//end else (child1)
    }//end else if (child1)
    else {
        wait();
        printf(1, "Parent printing\n");
        getprocessinfo();
    }//end else if

    exit();
}//end main
