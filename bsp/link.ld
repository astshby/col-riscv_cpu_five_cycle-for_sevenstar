IMEM_BASE = 0x00000000;
DMEM_BASE = 0x10000000;
ENTRY(_start)

MEMORY {
  IMEM (rx) : ORIGIN = IMEM_BASE, LENGTH = 64K
  DMEM (rw) : ORIGIN = DMEM_BASE, LENGTH = 64K
}

SECTIONS {
  .text : {
    *(.text.start)
    *(.text .text.*)
  } > IMEM

  . = ORIGIN(DMEM);
  .data  : { *(.data*) *(.rodata*) } > DMEM
  .sdata : { *(.sdata*) } > DMEM
  .bss   : { *(.bss*) *(COMMON) . = ALIGN(4); __bss_end = .; } > DMEM
}
