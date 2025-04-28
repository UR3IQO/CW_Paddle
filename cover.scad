//Created by Oleg Skidan RC6OF (ex UR3IQO)
//
//Visit https://github.com/UR3IQO/CW_Paddle for more information
//
//This project is distributed under Creative Commons Attribution 4.0 International
//See the LICENSE file for the details

$fn = 64;

include <lib/polyround.scad>

h = 6;         //Cover height (высота крышки)
depth = 3.5;   //Bearing mount pockets depth (глубина карманов для крепления подшипников)
bearing_mount_d = 11.2; //Bearing mount pocket diameter (диаметр кармана для монтажа подшипника)

difference()
{
   //Cover forms (конфигурация крышки)
   pts = [ [  18, -1, 15],
           [ 6.4, 27, 5],
           [-6.4, 27, 5],
           [-18,  -1, 15],
           [-18, -15, 5], 
           [ 18, -15, 5]];
   extrudeWithRadius(h, 0, 2, 10) polygon(polyRound(pts, 16));
   
   translate([0, 0, -0.01])
   {
      //Bearing mount pockets (подшипники)
      translate([-10, 0, 0]) cylinder(depth, d = bearing_mount_d);
      translate([-10, 0, depth - 0.01]) cylinder(1.5, d = 9);
      translate([ 10, 0, 0]) cylinder(depth, d = bearing_mount_d);
      translate([ 10, 0, depth - 0.01]) cylinder(1.5, d = 9);

      //Back mounting screw (задний винт)
      translate([0, 17.25, 0]) cylinder(4.5, d = 5.6);
      translate([0, 17.25, 0]) cylinder(0.5, d = 6.2);
      
      //Front mounting screw (передний винт)
      translate([0, -10, 0]) cylinder(4.5, d = 5.6);
      translate([0, -10, 0]) cylinder(0.5, d = 6.2);   }
}

