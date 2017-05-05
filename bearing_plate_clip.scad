mm = 1;
in = 25.4*mm;

clip_height = 1/2*in;
pendulum_rad = 1.325*in/2; // MADE-UP NUMBER

wall = 2*mm;

hole_rad = 1.7*mm;  
hole_depth = 1.25*in;
countersink_rad = 3.8*mm;  
hole_angle = 35;
eps=0.01;
$fn=60;
module clip(){
    linear_extrude(height=clip_height)
    difference() {
        union(){
            circle(pendulum_rad+wall);
            translate([-pendulum_rad-wall,wall])
            square([2*pendulum_rad+2*wall,pendulum_rad]);
    
        }
        union(){
            circle(pendulum_rad);       
            translate([-pendulum_rad,-3/2*pendulum_rad])
            square([2*pendulum_rad,pendulum_rad]);
         }
           
    }
}

module screw() {
    union(){
        cylinder(r=hole_rad,h=hole_depth);
        cylinder(r1=countersink_rad,r2=0,h=countersink_rad);
        translate([0,0,-countersink_rad+eps])
        cylinder(r=countersink_rad,h=countersink_rad);
    }
}

module anglebracket() {
    translate([0,pendulum_rad+wall,0])
    color("red")
    translate([2*in,0,0])
    rotate([0,-90,0])
    linear_extrude(h=4*in)
    polygon([[0,0],[0.75*in,0],[0.95*in,0.2*in],
            [0.2*in,0.95*in],[0,0.75*in], [0,0]]);
    
}


module clip_with_holes() {
    difference() {
        union(){
            clip();
            //anglebracket(); // debug

        }
        for(hole_rotate=[hole_angle, -hole_angle]) {
            rotate([0,0,hole_rotate])
            translate([0,pendulum_rad-eps, clip_height/2])
            rotate([-90,0,0])
            screw();
            translate([0,0,clip_height])
            rotate([90,0,0])
            cylinder(r=0.3*mm, h=2*in, center=true);
        }
    }
}





clip_with_holes();





