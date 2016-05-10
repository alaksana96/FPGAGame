
# Loop constraints
directive set /blueobject/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /blueobject/core/core:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}

# IO operation constraints
directive set /blueobject/core/core:rlp/main/io_read(video_in:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /blueobject/core/core:rlp/main/io_read(vga_xy:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /blueobject/core/core:rlp/main/io_read(VGA_VS:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /blueobject/core/core:rlp/main/if#1:if:io_write(player2y:rsc.d)#1 CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /blueobject/core/core:rlp/main/acc CSTEPS_FROM {{.. == 1}}
directive set /blueobject/core/core:rlp/main/acc#1 CSTEPS_FROM {{.. == 1}}
directive set /blueobject/core/core:rlp/main/aif:acc CSTEPS_FROM {{.. == 1}}
directive set /blueobject/core/core:rlp/main/if#1:acc CSTEPS_FROM {{.. == 1}}
directive set /blueobject/core/core:rlp/main/if#1:mux#3 CSTEPS_FROM {{.. == 1}}
directive set /blueobject/core/core:rlp/main/mux#2 CSTEPS_FROM {{.. == 1}}
