//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details

$fn = 32;

include <lib/polyround.scad>

h = 14;        //Bottom part height (высота нижней части основания)
width = 100;   //Keyer width (ширина ключа)
depth = 80;    //Keyer depth (глубина ключа)
cd = 4;        //Cable diameter (диаметр кабеля)

module cover_mount_hole(pos)
{
   translate(pos) cylinder(h+1, d = 3.5);
   translate([pos.x, pos.y, -1]) cylinder(5, d = 6.5);
}

module rounded_square(size, r)
{
   pts = [[ size.x/2,  size.y/2, r],
          [-size.x/2,  size.y/2, r],
          [-size.x/2, -size.y/2, r],
          [ size.x/2, -size.y/2, r]];
   polygon(polyRound(pts));
}

module rounded_square_with_mounts(size, r, size_m, r_m)
{
   pts = [[ size.x/2 - size_m.x,  size.y/2           , r],
          [ size.x/2 - size_m.x,  size.y/2 - size_m.y, r_m],
          [ size.x/2           ,  size.y/2 - size_m.y, r],

          [ size.x/2           , -size.y/2 + size_m.y, r],   
          [ size.x/2 - size_m.x, -size.y/2 + size_m.y, r_m],
          [ size.x/2 - size_m.x, -size.y/2           , r],


          [-size.x/2 + size_m.x, -size.y/2           , r],
          [-size.x/2 + size_m.x, -size.y/2 + size_m.y, r_m],
          [-size.x/2           , -size.y/2 + size_m.y, r],

          [-size.x/2           , size.y/2 - size_m.y, r],
          [-size.x/2 + size_m.x, size.y/2 - size_m.y, r_m],
          [-size.x/2 + size_m.x, size.y/2           , r],
   ];
   polygon(polyRound(pts));
}

difference()
{
   union()
   {
      /* Keyer base (основание) */
      difference()
      {
         linear_extrude(h) rounded_square([width, depth], 2);

         /* Inner part (внутренности) */
         translate([0, 0, 3 + 0.01]) linear_extrude(h - 3) rounded_square_with_mounts([width - 8, depth - 8], 2, [10,10], 5);
         translate([0, 0, h - 0.99]) linear_extrude(1) rounded_square([width - 8, depth - 8], 2);
      }

      /* Top part interfacing (выступ для стыковки с верхней частью основания) */
      translate([0, 0, h]) linear_extrude(2) 
         difference() 
         {
            rounded_square([width - 2, depth - 2], 2);
            rounded_square([width - 4, depth - 4], 2);
         }
   }

   x = width/2 - 8;
   y = depth/2 - 8;
   cover_mount_hole([ x, -y, 0]);
   cover_mount_hole([-x, -y, 0]);
   cover_mount_hole([ x,  y, 0]);
   cover_mount_hole([-x,  y, 0]);         

   /* Cable cutout (вырез под кабель) */
   translate([0, depth/2 + 0.01, h - cd/2]) rotate([90, 0, 0])
   {
      cylinder(10, d = cd);
      translate([-cd/2, 0, 0]) cube([cd, cd + 3, 10]);
   }

}



