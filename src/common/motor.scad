//include <BOLTS.scad>
//include <roof.scad>
e=0.01;
s=0.1;
$fn=100;
motor_d = 45;
motor_h=25;
bolt_head_h = 3;
bolt_head_d = 6;
bolt_tail_d = 3;
bolt_tail_h = 5/2;
bolt_center_dist = (25-bolt_tail_d)/2;
bolt_center_dist2 = (25-bolt_tail_d)/2;
motor_axis_d = 9;
motor_axis_h = 1;
motor_holow_d = 7;

module motor_mock(){
  //color("blue")
  difference(){
    union(){
      cylinder(r=motor_d/2,h=motor_h);
      translate([0,0,-motor_axis_h])
      cylinder(r=motor_axis_d/2,h=motor_h+2*motor_axis_h);
    }
    bolt_holes(-bolt_head_h,motor_h);
    shaft_hole(0,2*e);
  }
}

module shaft_hole(add_hh=0,add_th=0){
  translate([0,0,-motor_axis_h-add_th/2])
  cylinder(r=motor_holow_d/2+add_hh,h=motor_h+2*motor_axis_h+add_th);
}

module bolt_holes(add_hh=0,add_th=0){
  bolt_count = 4;
  for(i=[0:bolt_count-1]){
    rotate([0,0,i*360/bolt_count])
    translate([0,i%2==0?bolt_center_dist2:bolt_center_dist,-e/2]){
      cylinder(r=bolt_tail_d/2+s, h=bolt_head_h+bolt_tail_h+add_th+2*e);
      translate([0,0,-add_hh])
      cylinder(r=bolt_head_d/2+s, h=bolt_head_h+s+1*e+add_hh);
    }
  }
}
