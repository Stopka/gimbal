//include <BOLTS.scad>
//include <roof.scad>
include <../common/motor3.scad>
include <../common/zip.scad>

//%translate([0,0,-motor3_h+motor3_axis_h2])
//motor3_mock();
h=180;
h2=10;
joy_w=27;
joy_h=34;
sbgc_w=25;
sbgc_w2=10;
sbgc_h=40;

bw=sbgc_w;
bh=sbgc_h;
bd = 15;

module inner(minus=0){
   cylinder(r=(joy_w+sbgc_w2)/2-minus,h=h-h2,center=true);
}
  
module body(){
difference(){
  union(){
    cylinder(r=motor3_d/2,h=bolt3_tail_h2+bolt3_head_h2+motor3_axis_h2+h);
  }
  translate([0,0,bolt3_tail_h2+bolt3_head_h2+motor3_axis_h2+(h-h2+h2)/2])
    cube([motor3_d,joy_w+2*s,h-h2],center=true);
  translate([0,0,bolt3_tail_h2+bolt3_head_h2+motor3_axis_h2+h/2])
   inner();
  translate([0,0,motor3_axis_h2-e])
  cylinder(r=motor3_axis2_d2/2+s,h=motor3_axis2_h2+e);
  translate([0,0,-e])
  cylinder(r=motor3_axis_d2/2+s,h=motor3_axis_h2+e);
  translate([0,0,bolt3_tail_h2+bolt3_head_h2+motor3_axis_h2])
  rotate([180,0,0])
  rotate([0,0,45])
  bolt3_holes2(h2);
  btransition()
  bbolts();
  translate([-motor3_d/2-15,0,0])
  rotate([0,45,0])
  cube([20,joy_w+2*s,80],center=true);
}
}

module btransition(){
  translate([bd-15,0,15+30])
  children();
}

module bridge(){
  difference(){
    intersection(){
      inner(s);
      btransition()
      cube([bd,2*bw,bh],center=true);
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
    translate([i*(15/2-4),j*7,i*j*(bh/2-4)])
    rotate([-j*90,0,0]){
      cylinder(r=1.5/2,h=15);
      translate([0,0,15-e])
      cylinder(r=4/2,h=100);
    }
  }
  }
}



/*
rotate([0,90,0])
bridge();
/*/
rotate([0,90,0])
body();
/**/