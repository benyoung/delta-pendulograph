mm=1;
eps=0.01;

in = 25.4*mm;

$fn=60;


module shaft(th, height) {
    cylinder(r=3.9*mm+th, h=height, center=true);
}

translate([0,0,5*mm])
rotate([0,90,0])
difference(){
    cube([10*mm, 10*mm, 1*in],center=true);
    translate([0,0,-1*mm])
    shaft(0.1*mm,1*in);
}


wall = 1.5*mm;
flange = 3*mm;
hole_depth = 1/8*in;
slop = 0.05*mm;
bearing_rad = 1/4 *in + slop;
cut_thickness = 0.7*mm;

plug_rad = bearing_rad + wall;
epsilon = 0.01;

echo("plug radius", plug_rad, "mm");
num_cuts = 15;

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