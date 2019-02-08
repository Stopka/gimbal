//include <BOLTS.scad>
//include <roof.scad>
e=0.01;
s=0.1;
$fn=100;
motor3_d = 50;
motor3_h=23;
bolt3_head_h = 2.5;
bolt3_head_d = 4.2;
bolt3_tail_d = 2.5;
bolt3_tail_h = 9;
bolt3_center_dist = (15-bolt3_tail_d)/2;
motor3_axis_d = 19;
motor3_axis_h = 2;

bolt3_head_h2 = 2;
bolt3_head_d2 = 5;
bolt3_tail_d2 = 2.5;
bolt3_tail_h2 = 5;
bolt3_center_dist2 = (21-bolt3_tail_d)/2;
motor3_axis_d2 = 26;
motor3_axis_h2 = 3;
motor3_axis2_d2 = 8;
motor3_axis2_h2 = 2;

module motor3_mock(){
  //color("blue")
  difference(){
    union(){
      translate([0,0,motor3_axis_h])
      cylinder(r=motor3_d/2,h=motor3_h-motor3_axis_h-motor3_axis_h2);
      cylinder(r=motor3_axis_d/2,h=motor3_axis_h+e);
      translate([0,0,motor3_h-motor3_axis_h2-e])
      cylinder(r=motor3_axis_d2/2,h=motor3_axis_h2+e);
    }
    bolt3_holes(-bolt3_head_h,motor3_h/3);
    translate([0,0,2*motor3_h/3])
    bolt3_holes2(-bolt3_head_h2,motor3_h/3);
  }
}

//motor3_mock();

module bolt3_holes(add_hh=0,add_th=0){
  bolt_count = 4;
  for(i=[0:bolt_count-1]){
    rotate([0,0,i*360/bolt_count])
    translate([0,bolt3_center_dist,-e/2]){
      cylinder(r=bolt3_tail_d/2+s, h=bolt3_head_h+bolt3_tail_h+add_th+2*e);
      translate([0,0,-add_hh])
      cylinder(r=bolt3_head_d/2+s, h=bolt3_head_h+s+1*e+add_hh);
    }
  }
}

module bolt3_holes2(add_hh=0,add_th=0){
  bolt_count = 4;
  for(i=[0:bolt_count-1]){
    rotate([0,0,i*360/bolt_count])
    translate([0,bolt3_center_dist2,-e/2]){
      cylinder(r=bolt3_tail_d2/2+s, h=bolt3_head_h2+bolt3_tail_h2+add_th+2*e);
      translate([0,0,-add_hh])
      cylinder(r=bolt3_head_d2/2+s, h=bolt3_head_h2+s+1*e+add_hh);
    }
  }
}