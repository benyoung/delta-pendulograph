mm = 1;
in = 25.4*mm;

clip_height = 1/2*in;
pendulum_rad = (1 + 5/16)*in; // MADE-UP NUMBER

wall = 1.5*mm;

hole_rad = 1.5*mm;  // MADE-UP NUMBER
hole_depth = 1/2*in;
countersink_rad = 4*mm;  // MADE-UP NUMBER

hole_angle = 15;
eps=0.01;
$fn=60;
module clip(){
    linear_extrude(height=clip_height)
    difference() {
        union(){
            circle(pendulum_rad+wall);
            translate([-pendulum_rad/2,wall])
            square([pendulum_rad,pendulum_rad]);
    
        }
        union(){
            circle(pendulum_rad);       
            translate([-pendulum_rad,-3/2*pendulum_rad])
            square([2*pendulum_rad,pendulum_rad]);
         }
           
    }
}

module clip_with_holes() {
    difference() {
        clip();
        for(hole_rotate=[hole_angle, -hole_angle]) {
            rotate([0,0,hole_rotate])
            translate([0,pendulum_rad-eps, clip_height/2])
            rotate([-90,0,0])
            union(){
                cylinder(r=hole_rad,h=hole_depth);
                cylinder(r1=countersink_rad,r2=0,h=countersink_rad);
                translate([0,0,-countersink_rad+eps])
                cylinder(r=countersink_rad,h=countersink_rad);
            }
        }
    }
}

clip_with_holes();