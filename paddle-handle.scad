//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details


$fn = 64;

include <lib/polyround.scad>


/* Uncomment the following line to make right paddle (раскомментировать строку ниже для правого коромысла) */
//mirror([0,1,0])  
difference()
{
   union()
   {
      /* Paddle handle (ручка манипулятора) */
      pts_handle = [
             [ 19, 0, 5],
             [ 20, 1, 5],
             [ 38, 1, 12],
             [ 49, 10, 5.5],  
               
             [ 60, -13, 24],
             [ 42, -35, 7.5],
             [ 25.5, -12, 0],
             [  20, -12, 5],  
             [  19, -10, 5],
             ];

      pts_mount = [
             [ 15, 0, 5],
             [ 16, 1, 5],
             [ 27,   1, 0],
             [ 27, -12, 0],
             [  16, -12, 5],  
             [  15, -10, 5],
             ];

      extrudeWithRadius(6.5, 0.5, 1.5, 8) polygon(polyRound(pts_mount, 16));     
     
      difference()
      {
         extrudeWithRadius(3.5, 0.5, 1.5, 8) polygon(polyRound(pts_handle, 16));
         extrudeWithRadius(3.6, 0, -1.9, 8)
         {  
               translate([35.5, -13.5]) circle(3);
               translate([42, -22]) circle(3);
         }
         translate([0, 0, -0.1]) linear_extrude(10)
         {
            translate([35.5, -13.5]) circle(3);
            translate([42, -22]) circle(3);
         }
      }
      
      
      
   }

   translate([14.4, -10.1, 5.02]) cube([10.2, 10.2, 1.5]);

   /* Handles mounting */
   translate([20, -5, -3]) cylinder(10, d = 4.5);
     
}