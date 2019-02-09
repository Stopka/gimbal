//include <BOLTS.scad>
//include <roof.scad>
include <./common/motor.scad>
include <./pitch/gopro3back/pitch.scad>
include <./roll/roll.scad>
include <./yaw/yaw.scad>
include <./handle/handle.scad>
translate([roll_w-motor_h-roll_h,yaw_w-roll_l-motor_h,yaw_l])
rotate([0,0,0]){
  %translate([-37,-10.5,0])
  rotate([90,0,0])
  import("./pitch/gopro3back/gopro3back.stl");
  import("./pitch/gopro3back/pitch.stl");
}
translate([roll_w,yaw_w-roll_l-motor_h,yaw_l])
rotate([0,0,-90]){
  roll();
}
translate([0,yaw_w,yaw_l])
rotate([-90,0,-90]){
  yaw();
}
translate([0,0,-motor_h])
rotate([0,180,0]){
  handle_body();
  handle_bridge();
}