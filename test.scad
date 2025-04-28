//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details


//This part is used to check (and correct if needed) the size of the pockets for bearings and stands
//Данная деталь используется для проверки (и коррекции при необходимости) размеров 
//карманов для монтажа подшипников и стоек

$fn = 64;

include <lib/polyround.scad>

bearing_mount_d = 11.2; //Bearing mount pocket diameter (диаметр кармана для монтажа подшипника)
stand_d = 8.1;  //Stand mount pocket diameter (диаметр кармана для монтажа стойки)

module rounded_square(size, r)
{
   pts = [[ size.x/2,  size.y/2, r],
          [-size.x/2,  size.y/2, r],
          [-size.x/2, -size.y/2, r],
          [ size.x/2, -size.y/2, r]];
   polygon(polyRound(pts));
}

h = 4;

difference()
{
   union()
   {
      translate([0, 0, -h]) extrudeWithRadius(h, 0, 2, 10) rounded_square([30, 15], 2);

      translate([8, 0, 0]) cylinder(h = 2, d = 10);
   }

   translate([-8, 0, -3.5]) cylinder(h, d = 11.2);
   translate([-8, 0, -h-1]) cylinder(h, d = 9);

   translate([8, 0, 0])
   {
      rotate([0, 0, 30]) cylinder(10, d = 8, $fn = 6); 
      cylinder(20, d = 3);
   }
}

