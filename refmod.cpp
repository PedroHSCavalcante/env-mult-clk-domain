#include <stdio.h>
#include <math.h>

extern "C" int my_sqrt(int x){
  return floor(sqrt((x)));
}
