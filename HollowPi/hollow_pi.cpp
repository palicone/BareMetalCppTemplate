#include <stdio.h>
#include "pico/stdlib.h"
#include "pico/time.h" // For sleep_ms() and sleep_us()

int main()
{
  stdio_init_all();
  while ( true )
  {
    sleep_ms(1000);
    printf("Hollow, world!\r\n");
  }
  return 0;
}
