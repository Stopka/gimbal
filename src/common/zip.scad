//include <BOLTS.scad>
//include <roof.scad>
module zip(h){
  zip_d=4;
  zip_w=8;
  zip_h=3.5;
  translate([0,motor_d/2,-zip_h/2-(h-zip_h)/2])
  rotate([0,0,90])
  difference(){
    cylinder(r=zip_w/2,h=zip_h,center=true);
    cylinder(r=zip_w/2-zip_d/2,h=zip_h+2*e,center=true);
  }
}