MEMORY
{
    RAM   (rwx)  : ORIGIN = 0x20000000, LENGTH = 128k
}

_estack = ORIGIN(RAM) + LENGTH(RAM);

ENTRY(ResetHandler)

SECTIONS
{  
  .text_out :            /* Code goes into RAM */
  {
    KEEP(*(.isr_vector)) /* Startup code */
    *(.text*)            /* .text* sections (code) */

    _sctors = .;
    KEEP (*(SORT(.ctors.*)))
    KEEP (*(.ctors))
    . = ALIGN(4);
    _ectors = .;

    KEEP (*(.init))
    KEEP (*(.fini))    
    
    _etext = .;          /* define a global symbols at end of code */
  } >RAM

  .rodata_out :          /* Constant data goes into RAM */
  {
    . = ALIGN(4);
    *(.rodata*)          /* .rodata* sections (constants, strings, etc.) */
    . = ALIGN(4);
  } >RAM

  .ARM : {
    __exidx_start = .;
    *(.ARM.exidx*)
    __exidx_end = .;
  } >RAM

  .preinit_array :
  {
    __preinit_array_start = .;
    KEEP (*(.preinit_array*))
    __preinit_array_end = .;
  } >RAM
  .init_array :
  {
    __init_array_start = .;
    KEEP (*(SORT(.init_array.*)))
    KEEP (*(.init_array*))
    __init_array_end = .;
  } >RAM
  .fini_array :
  {
    __fini_array_start = .;
    KEEP (*(SORT(.fini_array.*)))
    KEEP (*(.fini_array*))
    __fini_array_end = .;
  } >RAM
  
  _sidata = LOADADDR(.data_out);
  .data_out :            /* Initialized data sections goes into RAM */
  {
    _sdata = .;          /* Initialized data starts here */
    *(.data*)            /* .data* sections */
    . = ALIGN(4);
    _edata = .;          /* Initialized data ends here */
  } >RAM AT> RAM         /* Loaded in RAM */
  
  .bss_out :             /* Uninitialized data section follows in RAM */
  {
    . = ALIGN(4);
    _sbss = .;           /* Uninitialized (zero initialized) data starts here */
    *(.bss*)
    *(COMMON)
    . = ALIGN(4);
    _ebss = .;           /* Uninitialized (zero initialized) data ends here */
    _end = .;
    end = .;
  } >RAM
  
    /* Remove information from the standard libraries */
  /DISCARD/ :
  {
    libc.a ( * )
    libm.a ( * )
    libgcc.a ( * )
    libstdc++.a ( * )
    libstdc++_nano.a ( * )
  }
}

RAM_USED = SIZEOF(.text_out) + SIZEOF(.rodata_out) + SIZEOF(.data_out) + SIZEOF(.data_out) + SIZEOF(.bss_out);
RAM_SIZE = LENGTH(RAM);
RAM_USAGE = (100 * RAM_USED) / RAM_SIZE;


