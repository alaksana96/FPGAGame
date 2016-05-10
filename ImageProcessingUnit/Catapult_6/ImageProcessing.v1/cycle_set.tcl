
# Loop constraints
directive set /ImageProcessing/core/core:rlp CSTEPS_FROM {{. == 0}}
directive set /ImageProcessing/core/core:rlp/main CSTEPS_FROM {{. == 2} {.. == 0}}

# IO operation constraints
directive set /ImageProcessing/core/core:rlp/main/io_read(video_in:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/io_read(vga_xy:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/io_read(VGA_VS:rsc.d) CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/if#1:if:io_write(player1y:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/else#1:if:if:io_write(player2y:rsc.d)#1 CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/io_write(video_out:rsc.d) CSTEPS_FROM {{.. == 1}}

# Real operation constraints
directive set /ImageProcessing/core/core:rlp/main/acc CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/if#1:acc CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/aif:acc CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/aif#1:acc CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/if#1:mux#3 CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/else#1:acc CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/else#1:aif:acc CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/else#1:if:acc CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/else#1:if:mux#3 CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/mux#3 CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/mux#4 CSTEPS_FROM {{.. == 1}}
directive set /ImageProcessing/core/core:rlp/main/mux#7 CSTEPS_FROM {{.. == 1}}
