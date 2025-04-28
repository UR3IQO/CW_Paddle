//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details


$fn = 64;

include <lib/polyround.scad>

offset = -15; //Keyer mechanism offset (cмещение механизма ключа (центр осей) относительно центра основания)
width = 100;  //Keyer width (ширина ключа)
depth = 80;   //Keyer depth (глубина ключа)
h = 5;        //Base top part height (высота основания)
h_top = 17.2; //Distance from the top cover to the base (расстояние до верхней крышки)
d_m = 4.7;    //Heat threaded insert hole diameter (диаметр резьбовых втулок под термовставку)
bearing_mount_d = 11.2; //Bearing mount pocket diameter (диаметр кармана для монтажа подшипника)
stand_d = 8.15;  //Stand mount pocket diameter (диаметр кармана для монтажа стойки)

/* Contacts and magnets stands coordinates (координаты стоек для контактов и магнитов) */
stands = [ [-31, 15],
           [ 31, 15],
           [-25, 34.8],
           [ 25, 34.8] ];


module rounded_square(size, r)
{
   pts = [[ size.x/2,  size.y/2, r],
          [-size.x/2,  size.y/2, r],
          [-size.x/2, -size.y/2, r],
          [ size.x/2, -size.y/2, r]];
   polygon(polyRound(pts));
}

difference()
{
   union()
   {
      /* Base (основание) */
      translate([0, -offset, -h]) extrudeWithRadius(h, 0, 2, 10) rounded_square([width, depth], 2);

      /* Basements for the stands (основания стоек для контактов и магнитов) */
      for(c = stands)
         translate(c) cylinder(h = 2, d = 11);

      /* Back cover mount (задняя стойка крышки) */
      extrudeWithRadius(h_top, -2, 0, 10) translate([0, 17.25]) rounded_square([12.8, 19.5], 2.5);

      /* Front cover mount (передняя стойка крышки) */
      extrudeWithRadius(h_top, -2, 0, 10) translate([0, -10]) rounded_square([10, 10], 2);
   }
   
   /* Pockets for bearings (посадочные места под подшипники) */
   translate([-10, 0, -3.5]) cylinder(h, d = bearing_mount_d);
   translate([-10, 0, -h-1]) cylinder(h, d = 9);
   translate([ 10, 0, -3.5]) cylinder(h, d = bearing_mount_d);
   translate([ 10, 0, -h-1]) cylinder(h, d = 9);

   /* Pockets for stands (посадочные места стоек для контактов и магнитов) */
   for(c = stands) 
      translate(c) rotate([0, 0, 30]) cylinder(10, d = stand_d, $fn = 6); 

   translate([0, 0, -h -0.01])
   {   
      /* Stands mounting holes (отверстия крепления стоек для контактов и магнитов) */
      for(c = stands) 
         translate(c) 
         {
            translate([0, 0, 2.2]) cylinder(h = 30, d = 5.3); 
            cylinder(h = 2, d = 10);   //packet for screw head (выборка под головку винтов)
         }

      /* Holes for the cover mounting screws (отверстия под винты крепления крышки) */
      t = 4; //Thikness of the wall on top of the cober mount
      translate([0, 17.25, 0])
      {
         translate([0, 0, h + h_top - t + 0.2]) cylinder(30, d = 4.3);
         cylinder(h + h_top - t, d = 7.5);
      }
      translate([0, -10, 0])
      { 
         translate([0, 0, h + h_top - t + 0.2]) cylinder(30, d = 4.3);
         cylinder(h + h_top - t, d = 7.5);
      }

      /* Hole for the paddles wires (отверстие под провода от контактов коромысел) */
      translate([ 0, 0, 0]) cylinder(20, d = 3);

      /* Grooves for wiring (канавки под провода) */
      translate(stands[2]) rotate([0, 0, -120]) translate([-1, 4, 0]) rotate([-30, 0, 0]) cube([2, 7, 2]);
      translate(stands[3]) rotate([0, 0, 120]) translate([-1, 4, 0]) rotate([-30, 0, 0]) cube([2, 7, 2]);
      translate([-1, 0, 0]) cube([2, 17.25, 2]);
      
      /* Elements related to the base (элементы привязанные к основанию (а не к механизму)) */
      translate([0, -offset, 0])
      {
         /* Groove for the bottom base attachement (канавка для стыковки с нижней частью основания) */
         linear_extrude(2) 
            difference() 
            {
               rounded_square([width - 2 + 0.2, depth - 2 + 0.2], 2);
               rounded_square([width - 4 - 0.2, depth - 4 - 0.2], 2);
            }      
   
         /* Heat threaded inserts for bottom base mounting (термовставки для крепления нижней части основания) */
         x = width/2 - 8;
         y = depth/2 - 8;
         translate([ x, -y, 0]) cylinder(3.5, d = d_m);
         translate([-x, -y, 0]) cylinder(3.5, d = d_m);
         translate([ x,  y, 0]) cylinder(3.5, d = d_m);
         translate([-x,  y, 0]) cylinder(3.5, d = d_m);

         /* Heat threaded inserts for cable holder (термовставки для крепления кабеля) */   
         translate([-7, depth/2 - 10, 0]) cylinder(3.5, d = d_m);
         translate([ 7, depth/2 - 10, 0]) cylinder(3.5, d = d_m);         
      }      
   }
}



