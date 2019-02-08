//include <BOLTS.scad>
//include <roof.scad>
path = "../../vendor/GOPRO_HERO_3_MODEL/files/gopro3.stl";
translate([0,0,5])
import( path);
translate([0.001,0.001,-5])
import( path);