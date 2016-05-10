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

#define COLOR_WL           10
#define PIXEL_WL          (3*COLOR_WL)

#define  COORD_WL          11

#pragma hls_design top
void ImageUnit(ac_int<(COORD_WL), false>  vga_x, ac_int<(COORD_WL), false>  vga_y, ac_int<(COORD_WL), false>  p1y, ac_int<(COORD_WL), false>  p2y,
ac_int<(COORD_WL), false>  bx, ac_int<(COORD_WL), false>  by, ac_int<(8), false> p1planets, ac_int<(8), false> p2planets, ac_int<PIXEL_WL, false> * RGB, ac_int<PIXEL_WL, false> * RGB_o)
{
    
    ac_int<(COLOR_WL), false> i_red, i_green, i_blue;
    ac_int<(COLOR_WL), false> o_red, o_green, o_blue;
    
    i_red = (*RGB).slc<COLOR_WL>(20);
    i_green = (*RGB).slc<COLOR_WL>(10);
    i_blue = (*RGB).slc<COLOR_WL>(0);
    
    ac_int<(1), false> p1p1, p1p2, p1p3, p1p4, p1p5, p1p6, p1p7, p1p8;
    ac_int<(1), false> p2p1, p2p2, p2p3, p2p4, p2p5, p2p6, p2p7, p2p8;
    ac_int<(1), false> planetexists = 1;
    
    p1p1 = (p1planets).slc<1>(0);
    p1p2 = (p1planets).slc<1>(1);
    p1p3 = (p1planets).slc<1>(2);
    p1p4 = (p1planets).slc<1>(3);
    p1p5 = (p1planets).slc<1>(4);
    p1p6 = (p1planets).slc<1>(5);
    p1p7 = (p1planets).slc<1>(6);
    p1p8 = (p1planets).slc<1>(7);
    
    p2p1 = (p2planets).slc<1>(0);
    p2p2 = (p2planets).slc<1>(1);
    p2p3 = (p2planets).slc<1>(2);
    p2p4 = (p2planets).slc<1>(3);
    p2p5 = (p2planets).slc<1>(4);
    p2p6 = (p2planets).slc<1>(5);
    p2p7 = (p2planets).slc<1>(6);
    p2p8 = (p2planets).slc<1>(7);
    
    
    
    
    //ac_int<(COORD_WL), false> xmid = 640;
   // ac_int<(COORD_WL), false> ymid = 512;
    
    
    ac_int<(COORD_WL), false> square = 15; //size of meteor
    
    ac_int<(COORD_WL), false> p1x, p2x, pw, ph; //player1x, player2x, playerwidth, playerheight
    p1x = 149;
    p2x = 1089;
    pw = 20;
    ph = 50;
    
    ac_int<(COORD_WL), false> planetwidth, planetheight, player1planetx, player2planetx;
    planetwidth = 30;
    planetheight = 60;
    player1planetx = 49;
    player2planetx = 1229;
    
        //Draw player 1
        if((vga_x >= p1x - pw) && (vga_x <= p1x + pw) && (vga_y >= p1y - ph) && (vga_y <= p1y + ph)){
            
            o_red = 0;
            o_green = 1023;
            o_blue = 0;
            
            *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
        } //Draw player 2
        else if((vga_x >= p2x - pw) && (vga_x <= p2x + pw) && (vga_y >= p2y - ph) && (vga_y <= p2y + ph)){
            
            o_red = 0;
            o_green = 0;
            o_blue = 1023;
            
            *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
        } //Draw meteor
        else if((vga_x >= bx - square) && (vga_x <= bx + square) && (vga_y >= by -square) && (vga_y <= by +square)){
         
            o_red = 1023;
            o_green = 0;
            o_blue = 0;
            
        *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
        } //Draw player 1 planets
        else if((vga_x >= player1planetx - planetwidth) && (vga_x <= player1planetx + planetwidth)){
            
            if((p1p1 == planetexists) && (vga_y >= 63 - planetheight) && (vga_y <= 63 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p1p2 == planetexists) && (vga_y >= 191 - planetheight) && (vga_y <= 191 + planetheight)){
               
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p1p3 == planetexists) && (vga_y >= 319 - planetheight) && (vga_y <= 319 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p1p4 == planetexists) && (vga_y >= 447 - planetheight) && (vga_y <= 447 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p1p5 == planetexists) && (vga_y >= 575 - planetheight) && (vga_y <= 575 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p1p6 == planetexists) && (vga_y >= 703 - planetheight) && (vga_y <= 703 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p1p7 == planetexists) && (vga_y >= 831 - planetheight) && (vga_y <= 831 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p1p8 == planetexists) && (vga_y >= 959 - planetheight) && (vga_y <= 959 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
        }//EFANHDHFADJKFNADFNADFN
        else if((vga_x >= player2planetx - planetwidth) && (vga_x <= player2planetx + planetwidth)){
            
            if((p2p1 == planetexists) && (vga_y >= 63 - planetheight) && (vga_y <= 63 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p2p2 == planetexists) && (vga_y >= 191 - planetheight) && (vga_y <= 191 + planetheight)){
               
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p2p3 == planetexists) && (vga_y >= 319 - planetheight) && (vga_y <= 319 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p2p4 == planetexists) && (vga_y >= 447 - planetheight) && (vga_y <= 447 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p2p5 == planetexists) && (vga_y >= 575 - planetheight) && (vga_y <= 575 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p2p6 == planetexists) && (vga_y >= 703 - planetheight) && (vga_y <= 703 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p2p7 == planetexists) && (vga_y >= 831 - planetheight) && (vga_y <= 831 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
            else if((p2p8 == planetexists) && (vga_y >= 959 - planetheight) && (vga_y <= 959 + planetheight)){
                
                o_red = 680;
                o_green = 340;
                o_blue = 0;
            
                *RGB_o = ((((ac_int<PIXEL_WL, false>)o_red) << 20) | (((ac_int<PIXEL_WL, false>)o_green) << 10) | (ac_int<PIXEL_WL, false>)o_blue);
            }
        }
        else {
            *RGB_o = *RGB; 
        }
}

