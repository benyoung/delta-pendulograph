mm = 1;
in = 25.4*mm;

$fn=60;

wall = 1.2*mm;
flange = 3*mm;
hole_depth = 3/16*in;
slop = 0.05*mm;
bearing_rad = 1/4 *in + slop;
cut_thickness = 0.4*mm;

plug_rad = bearing_rad + wall;
epsilon = 0.01;

num_cuts = 10;

rotate([180,0,0])

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