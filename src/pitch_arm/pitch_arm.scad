//include <BOLTS.scad>
//include <roof.scad>
include <../common/motor.scad>
include <../common/zip.scad>
h=bolt_head_h+bolt_tail_h;
l = 47.5;
w = 53.0;
w2= 0.01;
s=0.11;

module base(l=l, w2=0){
  %motor_mock();
  difference(){
    hull(){
      translate([0,0,-h])
      cylinder(r=motor_d/2,h=h);
      translate([-l/2,0,-motor_d/8])
      cube([l,h,motor_d/4],center= true);
      translate([-l+0.5,0,-h/2])
      cube([1, motor_d, h],center=true);
      
      if(w2>0)
      translate([motor_d/2+w2/2,0,-motor_d/8])
      cube([w2, motor_d, motor_d/4],center=true);
    }
    translate([0,0,-h])
    rotate([0,0,45])
    bolt_holes(motor_d/4);
    translate([0,0,-motor_axis_h])
    cylinder(r=motor_axis_d/2, h=motor_axis_h+e);
    zip();
    translate([0,0,-2.5*h])
    cylinder(r=motor_holow_d/2+e, h=2.5*h+e);
  }
}

module weightNut(w=8){
  hull(){
    for(i = [0,2]){
      rotate([i*360/3,0,0])
      cube([3+2*s,w+2*s,4],center=true);
    }
  }
}

module weightBolt(shift=0){
  wbolt_d=5;
  translate([3*motor_d/8,shift,-wbolt_d/2-(motor_d/4-wbolt_d)/2]){
    rotate([0,90,0])
    cylinder(r=wbolt_d/2,h=50);
    translate([0,0,0])
    hull(){
      weightNut(w=8);
      translate([0,0,-motor_d/4])
      weightNut(w=8);
    }
  }
}

module partA(){
  translate([0,0,motor_h+5.6])
  rotate([-90,90,0])
  %import("../mount_gopro3back/mount_gopro3.stl");
  difference(){
    base();
    translate([-l+2*h+motor_holow_d/2,0,-2.3*h])
    cylinder(r=motor_holow_d/2+e, h=2.5*h+e);
  }
}

module partB(){
  difference(){
    base(w,w2);
    weightBolt(-1*motor_d/3);
    weightBolt();
    weightBolt(1*motor_d/3);
    zip();
    translate([-l,0,0])
    zip();
  }
}

rotate([90,0,0]){
  partA();
  translate([-l,0,w-e])
  rotate([0,-90,0])
  partB();
}