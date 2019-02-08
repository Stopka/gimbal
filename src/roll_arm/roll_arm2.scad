//include <BOLTS.scad>
//include <roof.scad>
include <../common/motor.scad>
include <../common/zip.scad>

h=bolt_tail_h+bolt_head_h;
l=85;
w=50;
module pitch_mock(){
  translate([48+motor_h,53,0])
  %import("../pitch_arm/pitch_arm.stl");
  rotate([90,0,90])
  %motor_mock();
}

module partA(){
  pitch_mock();
  difference(){
    hull(){
      rotate([0,-90,0])
      cylinder(r=motor_d/2,h=h);
      translate([-motor_d/8,l/2,0])
      cube([motor_d/4,l,h],center= true);
      translate([-(bolt_head_h+bolt_tail_h)/2,l,0])
      cube([bolt_head_h+bolt_tail_h,e,motor_d],center= true);
    }
    translate([-bolt_head_h-bolt_tail_h,0,0])
    rotate([0,90,0])
    rotate([0,0,45])
    bolt_holes(motor_d);
    translate([-motor_axis_h+e,0,0])
    rotate([0,90,0])
    cylinder(r=motor_axis_d/2,h=motor_axis_h);
    translate([0,-motor_d/2,motor_d/2])
    rotate([0,90,0])
    zip();
    translate([0,l-motor_d/2-2*h,motor_d/2])
    rotate([0,90,0])
    zip();
    translate([2,0,0])
    rotate([0,-90,0])
    cylinder(r=motor_holow_d/2+e, h=2.5*h+e);
    translate([+e,l-motor_holow_d/2-motor_d/4,0])
    rotate([0,-90,0])
    cylinder(r=motor_holow_d/2+e, h=2.5*h+e);
  }
}

module partB(){
  translate([w,l+s,0])
  rotate([-90,0,0])
  rotate([0,0,45])
  %motor_mock();
  difference(){
    hull(){
      h=bolt_head_h+bolt_tail_h;
      translate([w,l,0])
      rotate([90,0,0])
      cylinder(r=motor_d/2,h=h);
      translate([w/2,l-motor_d/4,0])
      cube([w,s,h],center= true);
      translate([0,l-h/2,0])
      cube([s, h, motor_d],center=true);
    }
    translate([w,l-bolt_tail_h-bolt_head_h+e,0])
    rotate([-90,0,0])
    rotate([0,0,45])
    bolt_holes(100);
    translate([w,l+e,0])
    rotate([90,0,0])
    cylinder(r=motor_axis_d/2,h=motor_axis_h+e);
    translate([w,l,motor_d])
    rotate([-90,0,0])
    zip();
    translate([w,l-bolt_tail_h-bolt_head_h+e-50,0])
    rotate([-90,0,0])
    cylinder(r=motor_holow_d/2+e, h=100);
  }
}

partA();
partB();