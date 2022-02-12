lip_height=10;
iks=43;
lip_offset=2;
plate_thickness=3;
 module base(height){
    translate([0,0,-height/2])linear_extrude(height = height)import(file = "iris-PE-switch-plate.svg", center=true);
 }
 
  module mid(height){
    translate([0,0,-height/2])linear_extrude(height = height)import(file = "mid.svg", center=true);
 }
 
 module keeb(){
     union(){
        mid(lip_height);
        base(lip_height+plate_thickness*2);
     }
 }
 module ofsetter(offsetval, height){
     translate([0,0,-height/2])linear_extrude(height = height)offset(delta=offsetval)import(file = "mid.svg", center=true);
     }

     
module center(height=iks){     
     difference(){
       ofsetter(2,height);
         base(height+2);
    }
  }
  
  module shell(){
    ofsetter(2,iks+lip_height-0.1);
  }  
  
  module case(){
      difference(){
        shell();
        color("purple")union(){
            translate([0,0,iks/2])mid(lip_height);
            base(iks-plate_thickness);
            translate([0,0,-iks/2])mid(lip_height);
        }
      }
}        
module hook(){
    difference(){
        hull(){
        rotate([8,0,0])translate([0,9,6])cube([12,19,4],center=true);
        translate([0,7.8,2])cube([15,20,5],center=true);
        }
        union(){
            hull(){
            rotate([0,90,0])cylinder(h=16,r=2.5,center=true, $fn=30);
            translate([0,2,2.5])rotate([0,90,0])cylinder(h=16,r=1.5,center=true, $fn=30);
            }
            hull(){
                translate([0,2,2.5])rotate([0,90,0])cylinder(h=16,r=1.5,center=true, $fn=30);

                translate([0,5,3])rotate([0,90,0])cylinder(h=16,r=1,center=true, $fn=30);
            }
        }
        translate([0,20,0])cube(23,center=true);
    }
}

union(){

case();

//I KNOW THIS IS TERRIBLE. I JUST NEED IT TO WORK FOR NOW
    translate([73,29,iks/2-5])rotate([0,0,180])hook();
    translate([73,29,-iks/2+5])rotate([0,180,180])hook();

    rotate([0,0,180])translate([-73,49,iks/2-5])rotate([0,0,180])hook();
    rotate([0,0,180])translate([-73,49,-iks/2+5])rotate([0,180,180])hook();

    translate([-05,-62,-iks/2+5])rotate([0,180,30])hook();
    translate([-05,-62,iks/2-5])rotate([0,0,30])hook();

    translate([-70.5,34.5,0])rotate([0,0,180]){
        translate([-0,0,-iks/2+5])rotate([0,180,41.8])hook();
        translate([-0,-0,iks/2-5])rotate([0,0,41.8])hook();
    }
}