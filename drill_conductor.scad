//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details

/* Stands drilling conductor (кондуктор для сверления стоек) */

$fn = 16;

//Height correction, may require correction for different printer/material
//Коррекция высоты отверстия, может потребоваться изменение в зависимости от принтера/метериала
correction = 0.6;    
d = 7.3;  //Stand sizeб edge to edge (размер втулки от ребра до ребра)
h = 9.6;  //высота отверстия

d_m = d / cos(30); //Stand outer diameter (диаметр втулки)
difference()
{
   translate([-(d_m + 4)/2, -d/2, -2]) 
      linear_extrude(h + 2 + 3) 
         square([d_m + 4, d_m + 2.7]);
   
   translate([0, -0.01, 0])
      linear_extrude(h + 3 + 1) 
         circle(d = d_m, $fn = 6);
      
   translate([0, 10, h]) rotate([90, 0, 0]) cylinder(20, d = 2);
}