//include <BOLTS.scad>
//include <roof.scad>
include <../common/motor.scad>
include <../common/zip.scad>

handle_body_h=150;
handle_body_h2=10;
joy_w=27;
joy_h=34;
sbgc_w=25;
sbgc_w2=10;
sbgc_h=40;

handle_bridge_w=sbgc_w;
handle_bridge_h=sbgc_h;
handle_bridge_d = 15;

module inner(minus=0){
   cylinder(r=(joy_w+sbgc_w2)/2-minus,h=handle_body_h-handle_body_h2,center=true);
}
  
module handle_body(){
translate([0,0,-motor_h-s])
rotate([0,0,45])
%motor_mock();
difference(){
  union(){
    cylinder(r=motor_d/2,h=bolt_tail_h+bolt_head_h+motor_axis_h+handle_body_h);
    
    translate([0,0,handle_body_h+handle_body_h2+4])
    rotate([0,-90,0])
    rotate([90,0,0])
    gopro_mount();
  }
  translate([0,0,bolt_tail_h+bolt_head_h+motor_axis_h+(handle_body_h-handle_body_h2+handle_body_h2)/2])
    cube([motor_d,joy_w+2*s,handle_body_h-handle_body_h2],center=true);
  translate([0,0,bolt_tail_h+bolt_head_h+motor_axis_h+handle_body_h/2])
   inner();
  translate([0,0,motor_axis_h-e])
  cylinder(r=motor_axis_d/2+s,h=motor_axis_h+e);
  translate([0,0,-e])
  cylinder(r=motor_axis_d/2+s,h=motor_axis_h+e);
  translate([0,0,bolt_tail_h+bolt_head_h-e])
  rotate([180,0,0])
  rotate([0,0,45])
  bolt_holes(handle_body_h2);
  btransition()
  bbolts();
  translate([-motor_d/2-15,0,0])
  rotate([0,45,0])
  cube([20,joy_w+2*s,80],center=true);
}
}

module btransition(){
  translate([handle_bridge_d-15,0,15+16+6])
  children();
}

module handle_bridge(){
  difference(){
    intersection(){
      inner(s);
      btransition()
      cube([handle_bridge_d,2*handle_bridge_w,handle_bridge_h],center=true);
    }
    btransition()
    for(i=[-1,1]){
      translate([8,-i*(joy_w/2-3),i*(joy_h/2-3)])
      rotate([0,-90,0])
      cylinder(r=2/2,h=10);
      
      translate([-8,i*(sbgc_w/2-3),i*(sbgc_h/2-8)])
      rotate([0,90,0])
      cylinder(r=2/2+s,h=10);
    }
    btransition()
    bbolts();
  }
}

module bbolts(){
  for(j=[1,-1]){
  for(i=[-1,1]){
    translate([i*(15/2-4),j*5,i*j*(handle_bridge_h/2-4)])
    rotate([-j*90,0,0]){
      cylinder(r=1.5/2,h=15);
      translate([0,0,15-e])
      cylinder(r=4/2,h=100);
    }
  }
  }
}

module gopro_mount(){
  d=15;
  h=3;
  for(u=[-1,1]){
    translate([0,0,u*h])
    difference(){
      union(){
        hull(){
          translate([-d/2-e,0,0])
          cube([e,2*motor_d/3,h],center=true);
          cube([e,d,h],center=true);
        }
        translate([-d/2/2,0,0])
        cube([d/2,d,h],center=true);
        cylinder(r=d/2,h=h,center=true);
      }
      cylinder(r=d/3/2,h=h+2*e,,center=true);
    }
  }
}

