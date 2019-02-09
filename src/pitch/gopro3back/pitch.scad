//include <BOLTS.scad>
//include <roof.scad>
include <../../common/motor.scad>

backpack_size=10;
mount_wall = 2;
pitch_h= bolt_head_h + bolt_tail_h;

module gopro3_mock(){
  import("./gopro3back.stl", convexity=3);
}

module motor_mount(){
  difference(){
    cylinder(r=motor_d/2,h=pitch_h);
    translate([0,0,pitch_h-motor_axis_h+s])
    cylinder(r=motor_axis_d/2+s,h=motor_axis_h+s+e);
    bolt_holes();
  }
}




module case(){
  path = "./../../../vendor/Brushless_Gimbal_model/files/GimbalGP3Case.fixed.stl";
  difference(){
    translate([backpack_size/2+0.1,0.001,0.001])
    import(path, convexity=3);
    translate([-10.5,280,20])
    cube([20,100,100],center=true);
  }
  difference(){
    translate([-backpack_size/2-0.1,0,0])
    import(path, convexity=3);
    translate([10.5,280,20])
    cube([20,100,100],center=true);
  }
}

module camera_mount(){
  difference(){
    translate([-267,0,-21])
    rotate([0,0,-90])
    case();
    translate([33.5,-150,-150])
    cube([300,300,300]);
    translate([31,-25,-22])
    cube([4,60,56]);
  }
  /*%translate([30,0,20])
  cube([5,20,5]);*/
}

module left_position(){
  rotate([0,90,0])
  rotate([0,0,0])
  children();
}

module left(){
  left_position(){
    translate([0,0,pitch_h])
    %motor_mock();
    motor_mount();
  }
}

module right(){
  translate([-37,0,-1.5]){
    camera_mount();
    
    %translate([0,-10.5,0])
    rotate([90,0,0])
    gopro3_mock();
    
  }
}

module usb_hole(){
  translate([-3.6,-9,0])
  cube([8,10,60],center=true);
}

module axis_hole(){
  translate([-50,0,0])
  rotate([0,90,0])
  cylinder(r=motor_holow_d/2+e, h=100);
  hull(){
    translate([0,0,0])
    rotate([0,-90,0])
    cylinder(r=motor_holow_d/2+e, h=10);
    
    translate([-8,-e-10,-motor_holow_d*3/2])
    cube([8,e,motor_holow_d*3]);
  }
}

module imu_translate(){
  translate([-0.75,7.6,16.2])
  children();
}

module imu_hole(left=true){
  i=left?-1:1;
  translate([1,i*14.2/2,-1.5])
  cylinder(r=2/2+s, h=10,center=true);
}

module imu_mount(){
  imu_translate()
   cube([12.5,23,13],center=true);
}

module display(){
  translate([-37,20,-0.8,])
  cube([45,20, 33],center=true);
}

module pitch(){
  difference(){
    union(){
      left();
      imu_mount();
        
      hull(){
        intersection(){
          right();
          translate([-1.5,0,00])
          cube([10,100,100],center=true);
        }
        intersection(){
          left();
          translate([-4.5,0,00])
          cube([10,100,100],center=true);
        }
      }
       
      right();
    }
    left_position()
    bolt_holes(10);
    usb_hole();
    axis_hole();
    translate([0,-6,0])
    display();
    translate([0,0,3.1])
    imu_translate(){
      imu_hole(true);
      imu_hole(false);
    }
  }
}