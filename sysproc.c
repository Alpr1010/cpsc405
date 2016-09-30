#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

// System call to view all process information (excluding UNUSED) [Lab3]
int
sys_getprocessinfo(void) {
  processinfo();
  return 0;
}//end sys_getprocessinfo

// System call to increase priority of process [Lab3]
int
sys_increasepriority(void) {

  // If priority is 0, raise it to 1
  if(proc->priority == 0) {
    cprintf("Priority has increased from 0 to 1 for process %s\n", proc->name);
    proc->priority = 1;
  }//end if
  else {
      cprintf("Priority for process %s is already set to the highest (%d).\n", proc->name, proc->priority);
  }//end else

  // Returns priority for process
  return proc->priority;
}//end sys_increasepriority

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return proc->pid;
}

// Counts number of sys calls made
int sys_getcount(void) {
    if(count < 0)
        return -1;
    // Returns count
    return count;
}//end count

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = proc->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(proc->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}
