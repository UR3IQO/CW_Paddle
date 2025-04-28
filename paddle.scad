//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details

$fn = 64;

include <lib/polyround.scad>

shaft_d = 6.9; //Bearing shaft diameter (диаметр оси под подшипник)

  
module pipe(list, d)
{
   extrudeWithRadius(d, d/2, d/2, 10)
      polygon(
         polyRound(
            concat(
               [for(p = list) p - [0, d/2, 0]], 
               [for(i = [len(list)-1:-1:0]) list[i] + [0, d/2, 0]]
                  )
         )
      );
}  

module m3_flush_head(h)
{
   translate([0, 0, 1.5]) cylinder(10, d = 6.5);
   cylinder(1.51, d1 = 3.5, d2 = 6.5);
   translate([0, 0, -h+0.01]) cylinder(h, d = 3.5);
}
  
/* Uncomment the following line to make right paddle (раскомментировать строку ниже для правого коромысла) */
//mirror([0,1,0])  
difference()
{
   union()
   {
      /* Paddle lever (рычаг манипулятора) */
      pts1 = [[ -40, 0, 0], 
              [ 29.5, 0, 0], 
              [ 29.5, 4.5, 0], 
              [ 13, 5.5, 70], 
              [ 0.5, 7.5, 10], 
              [ -40, 7.5, 0]];

      rotate([90, 0, 0]) extrudeWithRadius(10, 1.5, 1.5, 8) polygon(polyRound(pts1));

      /* Handles mounting plate (площадка крепления весла) */
      translate([19.5, -10, 0]) cube([10, 10, 1.5]);

      /* Bearing shafts (оси под подшипники) */
      translate([0, 8, shaft_d/2]) rotate([90, 0, 0]) cylinder(26, d = shaft_d);
      translate([0, 4, shaft_d/2]) rotate([90, 0, 0]) intersection()
      {
         cylinder(18, 4, 4);      
         translate([0, -0.05, 0]) linear_extrude(18){ square([8,shaft_d - 0.1], center = true); }
      }
   }

   /* Handles mounting (крепление весла) */
   translate([25, -5, 2]) m3_flush_head(5);
   //translate([15, -5, 1.5]) m3_flush_head(5);
      
   /* Magnet mount (магнит) */      
   translate([-15, -5, 7.5 - 2]) cylinder(3, d = 8.2);
   translate([-15, -5, -1]) cylinder(15, d = 3.4);
   translate([-15, -5, -1]) cylinder(2.5 + 1, d = 6.6, $fn = 6);
     
   /* Contact bolt mount (контактный болт)*/
   translate([-35, -5, -1]) cylinder(15, d = 3.4);
   translate([-35, -5, -1]) cylinder(3 + 1, d = 6.6, $fn = 6);
   
   /* Paddle wire pipe (полость для провода) */
   wire = [[-41, 0, 0],
           [-25, 0, 15],
           [-15, -3.5, 15],
           [ -5, 0, 15],
           [ 0, 0, 0]];
   translate([0, -5, 3.0]) rotate([0, 0, 0]) pipe(wire, 1.5);
   translate([-1, -5 + 1, 0]) rotate([90, 0, 0]) linear_extrude(2) polygon([[0, -1],[0, 4.5],[6, -1]]);
}