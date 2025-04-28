//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details


$fn = 64;

cd = 4; //Cable diameter (диаметр кабеля)
h = 5; //Cable mount height (высота крепления)
dh = 6.2; //Screw head diameter (диаметр головки винтов крепления)
hh = 3;   //Screw head height (высока головки винта)

module screw()
{
   translate([0, 0, hh + 0.1]) cylinder(10, d = 3.5);
   translate([0, 0, -0.05]) cylinder(hh, d = dh);      
}

difference()
{
   //Body (тело детали)
   linear_extrude(h) square([22,10], center = true);

   //Cable cutout (вырез под кабель)
   translate([0, 10, h - cd/2 + 0.6]) rotate([90, 0, 0])
   {
     cylinder(40, d = cd);
     translate([-cd/2, 0, 0]) cube([cd, cd + 3, 40]);
   }
 
   //Mounting screw holes (отверстия под крепежные винты)
   translate([-7, 0, 0]) screw();
   translate([ 7, 0, 0]) screw();
}