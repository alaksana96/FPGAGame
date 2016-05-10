////////////////////////////////////////////////////////////////////////////////
//  _____                           _       _    _____      _ _
// |_   _|                         (_)     | |  / ____|    | | |
//   | |  _ __ ___  _ __   ___ _ __ _  __ _| | | |     ___ | | | ___  __ _  ___
//   | | | '_ ` _ \| '_ \ / _ \ '__| |/ _` | | | |    / _ \| | |/ _ \/ _` |/ _ \
//  _| |_| | | | | | |_) |  __/ |  | | (_| | | | |___| (_) | | |  __/ (_| |  __/
// |_____|_| |_| |_| .__/ \___|_|  |_|\__,_|_|  \_____\___/|_|_|\___|\__, |\___|
//                 | |                                                __/ |
//                 |_|                                               |___/
//  _                     _
// | |                   | |
// | |     ___  _ __   __| | ___  _ __
// | |    / _ \| '_ \ / _` |/ _ \| '_ \
// | |___| (_) | | | | (_| | (_) | | | |
// |______\___/|_| |_|\__,_|\___/|_| |_|
//
////////////////////////////////////////////////////////////////////////////////
//  File:           vga_mouse_square.cpp
//  Description:    video to vga with mouse pointer - real-time processing
//  By:             rad09
////////////////////////////////////////////////////////////////////////////////
// this hardware block receives the VGA scanning coordinates, 
// the mouse coordinates and then replaces the mouse pointer 
// with a different value for the pixel
////////////////////////////////////////////////////////////////////////////////
// Catapult Project options
// Constraint Editor:
//  Frequency: 27 MHz
//  Top design: vga_mouse_square
//  clk>reset sync: disable; reset async: enable; enable: enable
// Architecture Constraint:
//  core>main: enable pipeline + loop can be merged
////////////////////////////////////////////////////////////////////////////////



#include "stdio.h"
#include "ac_int.h"

#define COLOR_WL          10
#define PIXEL_WL          (3*COLOR_WL)

#define  COORD_WL          10
#define  COORD_WL_GAME      11

#pragma hls_design top


static ac_int<(COORD_WL), false> redobjy;
static ac_int<(1), false> findpixelred;

void redobject(ac_int<(1), false> VGA_VS, ac_int<(COORD_WL+COORD_WL), false> * vga_xy, ac_int<PIXEL_WL, false> * video_in, ac_int<(COORD_WL), false> * player1y)
{
    ac_int<10, false> i_red, i_green, i_blue; // current pixel
    ac_int<10, false> o_red, o_green, o_blue; // output pixel
    ac_int<10, false>  vga_x, vga_y; // mouse and screen coordinates

    
    i_red = (*video_in).slc<COLOR_WL>(20);
    i_green = (*video_in).slc<COLOR_WL>(10);
    i_blue = (*video_in).slc<COLOR_WL>(0);

    
    // extract VGA pixel X-Y coordinates
    vga_x = (*vga_xy).slc<COORD_WL>(0);
    vga_y = (*vga_xy).slc<COORD_WL>(10);
    
    vga_y = vga_y - 35; //take into account offset
   
    
   if(VGA_VS == 1){
        findpixelred = 1;
        //findpixelblue = 1;       
    }
    

    
    if((i_red >= 880) && (i_green <= 520) && (i_blue <= 440)){
        o_red = 1023;
        o_green = 0;
        o_blue = 0;
        
        if(findpixelred == 1){
            redobjy = vga_y;
            *player1y = vga_y;
            findpixelred = 0;
        } else {
            *player1y = redobjy;
        } 
    }
    /*if((i_red <= 400) && (i_green <= 400) && (i_blue >= 500)){
        o_red = 0; 
        o_green = 0;
        o_blue = 1023; 
        
        if(findpixelblue == 1){
            blueobjy = vga_y;
            *player2y = vga_y;
            findpixelblue = 0;
        } else {
            *player2y = blueobjy;
        }
        
    }*/ 
    else {
        o_red = 0;
        o_green = 0;
        o_blue = 0;
    }
    
    
    
    
    // combine the 3 color components into 1 signal only
    //*video_out = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
}

