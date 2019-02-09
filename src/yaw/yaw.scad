//include <BOLTS.scad>
//include <roof.scad>
include <../common/motor.scad>
include <../common/zip.scad>

yaw_h=bolt_tail_h+bolt_head_h;
yaw_l=85;
yaw_w=50;
module roll_mock(){
  translate([48+motor_h,53,0])
  %import("../roll/roll.stl");
  rotate([90,0,90])
  %motor_mock();
}

module yaw_partA(){
  difference(){
    hull(){
      rotate([0,-90,0])
      cylinder(r=motor_d/2,h=yaw_h);
      translate([-motor_d/8,yaw_l/2,0])
      cube([motor_d/4,yaw_l,yaw_h],center= true);
      translate([-(bolt_head_h+bolt_tail_h)/2,yaw_l,0])
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
    zip(yaw_h);
    translate([0,yaw_l-motor_d/2-2*yaw_h,motor_d/2])
    rotate([0,90,0])
    zip(yaw_h);
    translate([2,0,0])
    rotate([0,-90,0])
    cylinder(r=motor_holow_d/2+e, h=2.5*yaw_h+e);
    translate([+e,yaw_l-motor_holow_d/2-motor_d/4,0])
    rotate([0,-90,0])
    cylinder(r=motor_holow_d/2+e, h=2.5*yaw_h+e);
  }
}

module yaw_partB(){
  translate([yaw_w,yaw_l+s,0])
  rotate([-90,0,0])
  rotate([0,0,45])
  %motor_mock();
  difference(){
    hull(){
      h=bolt_head_h+bolt_tail_h;
      translate([yaw_w,yaw_l,0])
      rotate([90,0,0])
      cylinder(r=motor_d/2,h=yaw_h);
      translate([yaw_w/2,yaw_l-motor_d/4,0])
      cube([yaw_w,s,yaw_h],center= true);
      translate([0,yaw_l-yaw_h/2,0])
      cube([s, yaw_h, motor_d],center=true);
    }
    translate([yaw_w,yaw_l-bolt_tail_h-bolt_head_h+e,0])
    rotate([-90,0,0])
    rotate([0,0,45])
    bolt_holes(100);
    translate([yaw_w,yaw_l+e,0])
    rotate([90,0,0])
    cylinder(r=motor_axis_d/2,h=motor_axis_h+e);
    translate([yaw_w,yaw_l,motor_d])
    rotate([-90,0,0])
    zip(yaw_h);
    translate([yaw_w,yaw_l-bolt_tail_h-bolt_head_h+e-50,0])
    rotate([-90,0,0])
    cylinder(r=motor_holow_d/2+e, h=100);
  }
}

module yaw(){
  yaw_partA();
  yaw_partB();
}