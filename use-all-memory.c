#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  printf("BEWARE : about to consume all memory. Without limits this will crash your system!!");
  while(1==1){
    malloc( 1024*1024*1024*1024 );
  }
}

