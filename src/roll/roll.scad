//include <BOLTS.scad>
//include <roof.scad>
include <../common/motor.scad>
include <../common/zip.scad>
roll_h=bolt_head_h+bolt_tail_h;
roll_l = 47.5;
roll_w = 53.0;
roll_w2= 0.01;

module roll_base(l=roll_l, w2=0){
  %motor_mock();
  difference(){
    hull(){
      translate([0,0,-roll_h])
      cylinder(r=motor_d/2,h=roll_h);
      translate([-l/2,0,-motor_d/8])
      cube([l,roll_h,motor_d/4],center= true);
      translate([-l+0.5,0,-roll_h/2])
      cube([1, motor_d, roll_h],center=true);
      
      if(w2>0)
      translate([motor_d/2+w2/2,0,-motor_d/8])
      cube([w2, motor_d, motor_d/4],center=true);
    }
    translate([0,0,-roll_h])
    rotate([0,0,45])
    bolt_holes(motor_d/4);
    translate([0,0,-motor_axis_h])
    cylinder(r=motor_axis_d/2, h=motor_axis_h+e);
    zip(roll_h);
    translate([0,0,-2.5*roll_h])
    cylinder(r=motor_holow_d/2+e, h=2.5*roll_h+e);
  }
}

module roll_weightNut(w=8){
  hull(){
    for(i = [0,2]){
      rotate([i*360/3,0,0])
      cube([3+2*s,w+2*s,4],center=true);
    }
  }
}

module roll_weightBolt(shift=0){
  wbolt_d=5;
  translate([3*motor_d/8,shift,-wbolt_d/2-(motor_d/4-wbolt_d)/2]){
    rotate([0,90,0])
    cylinder(r=wbolt_d/2,h=50);
    translate([0,0,0])
    hull(){
      roll_weightNut(w=8);
      translate([0,0,-motor_d/4])
      roll_weightNut(w=8);
    }
  }
}

module roll_partA(){
  translate([0,0,motor_h+5.6])
  rotate([-90,90,0])
  %import("../mount_gopro3back/mount_gopro3.stl");
  difference(){
    roll_base();
    translate([-roll_l+2*roll_h+motor_holow_d/2,0,-2.3*roll_h])
    cylinder(r=motor_holow_d/2+e, h=2.5*roll_h+e);
  }
}

module roll_partB(){
  difference(){
    roll_base(roll_w,roll_w2);
    roll_weightBolt(-1*motor_d/3);
    roll_weightBolt();
    roll_weightBolt(1*motor_d/3);
    zip(roll_h);
    translate([-roll_l,0,0])
    zip(roll_h);
  }
}

module roll(){
  rotate([90,0,0]){
    roll_partA();
    translate([-roll_l,0,roll_w-e])
    rotate([0,-90,0])
    roll_partB();
  }
}
