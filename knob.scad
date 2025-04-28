//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details

$fn = 64;

include <lib/knurled.scad>


difference()
{
   knurled_cylinder(8, 11, 2, 2, 1, 0.5, 45);
   
   translate([0, 0, 3]) cylinder(2.8, d = 6.3, $fn = 6);
   translate([0, 0, 5.7]) cylinder(0.7, d = 7.5);
   translate([0, 0, 6.3]) cylinder(3.4, d = 7);
   
   translate([0, 0, -1]) cylinder(20, d = 3.2);
}
