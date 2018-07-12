#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  printf("BEWARE : about to consume all memory");
  int count = 0;
  while(1==1){
    printf("Consume ram "+ count ++);
    malloc( 1024*1024*1024*1024 );
  }
}
