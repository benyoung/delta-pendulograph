mm=1;
eps=0.01;

in = 25.4*mm;

$fn=60;


module shaft(th, height) {
    cylinder(r=3.9*mm+th, h=height, center=true);
}

module arrow_holder() {
    translate([0,0,5*mm])
    rotate([0,90,0])
    difference(){
        cube([10*mm, 10*mm, 1*in],center=true);
        translate([0,0,-1*mm])
        shaft(0.15*mm,1*in);
    }
}

wall = 1.5*mm;
flange = 3*mm;
hole_depth = 1/8*in;
slop = 0.1*mm;
bearing_rad = 1/4 *in + slop;;

plug_rad = bearing_rad + wall;
epsilon = 0.01;
cut_thickness = 0.7*mm;

echo("plug radius", plug_rad, "mm");
num_cuts = 15;

module cup() {
    translate([0,0,wall])
    rotate([180,0,0])
    translate([0.77*in,0,0])
    difference() {
        union(){
            cylinder(r=bearing_rad + flange, h=wall);
            
            translate([0,0,-hole_depth])
            cylinder(r=plug_rad, h=hole_depth+wall);
            
        }
        union(){
            color("red")
            sphere(bearing_rad);
            
            color("green")
            for(rot=[0:num_cuts-1]) {
        
                rotate([0,0,360/num_cuts*rot])
                translate([-cut_thickness/2,-2*plug_rad,-2*hole_depth-epsilon])
                cube([cut_thickness, 2*plug_rad, 2*hole_depth]);
            }
            
        }
    }
}


module ball_endrod() {
    cup();
    
    translate([0,1*in,0])
    cup();
    
    translate([0.7*in,0.3*in,0])
    cube([0.12*in,0.4*in,0.12*in]);
    
    translate([-0.13*in,-0.1*mm,0])
    difference(){
        translate([0,0.2*in,0])
        rotate([0,0,-45])
        cube([0.12*in,0.9*in,0.12*in]);
        
        cube([10*mm,10*mm,1*in],center=true);
    }
    
    arrow_holder();
}

//ball_endrod();

module magnet_holder(){
    translate([0,0,3.5*mm])
    difference(){
        cube([10*mm, 7*mm, 7*mm],center=true);
        rotate([0,90,0])
        cylinder(r=2.51*mm,h=12*mm,center=true);
    }
}


module magnet_endrod() {
    magnet_holder();
    
    translate([0,1*in,0])
    magnet_holder();
    
    translate([0.07*in,0.13*in,0])
    cube([0.12*in,0.76*in,0.12*in]);
    
    translate([-0.85*in,-0.1*mm,0])
    difference(){
        translate([0,0.2*in,0])
        rotate([0,0,-45])
        cube([0.12*in,1.1*in,0.12*in]);
        
        union(){
            cube([10*mm,10*mm,1*in],center=true);
            translate([0.85*in,1*in,0])
            cube([10*mm,6.8*mm,6.8*mm],center=true);
        }
    
    }
    
    translate([-0.695*in,0,0])
    arrow_holder();
}


magnet_endrod();