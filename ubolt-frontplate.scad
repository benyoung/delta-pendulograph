mm=1;
in=25.4*mm;


pendulum_rad = (1+5/16)*in/2;


wood_piece_th = 6.90*mm;
wood_piece_width= 25.69*mm;
wood_piece_len = 102.62*mm;

bolt_radius = 0.190*in / 2; // this is for #10 - 24 bolts
bolt_clearance = 0.7*mm;      // wanna let it slop around quite a bit
bolt_head_radius = 5.5*mm; // MADE-UP NUMBER
bolt_len = 4*in; // pretty sure this is how long my bolts are

eps=0.01*mm;

hole_y_offset = pendulum_rad + bolt_radius + bolt_clearance;
hole_z_offset = 9.5*mm;

echo("the distance between the holes is", 2*hole_y_offset, "mm");

width_cheat = 3*mm;
front_plate_width = 2*hole_y_offset + 2*bolt_head_radius + 2*width_cheat;
front_plate_height = 2*hole_z_offset;
front_plate_depth = 1/sqrt(2)*wood_piece_width; // kinda artificial since we
// are going to be subtracting off a wood piece - just has to be deep enough to
// reach into the inside of the wood piece basically

front_plate_standoff = 0.3*in; // tweak this until it looks beefy

module wood_piece() {
    color("red")
    rotate([0,45,0])
    translate([-wood_piece_width,wood_piece_len/2,0])
    rotate([90,0,0])
    linear_extrude(height=wood_piece_len)
    polygon([[0,0], [0,wood_piece_th], [wood_piece_width,wood_piece_th],
            [wood_piece_width,0], [wood_piece_width/2,-wood_piece_width/2],
            [0,0]]);
    
}
*wood_piece();

// not actually a bolt - i'm including the clearance.  subtract this from a
// thing to get a hole that a bolt fits into
module bolt() {
    union() {
        translate([0,0,-eps])
        cylinder(r=bolt_radius+bolt_clearance, h=bolt_len+eps,$fn=16);
        difference(){
            sphere(bolt_head_radius);
            cylinder(r=2*bolt_head_radius,h=2*bolt_head_radius);
        }
    }
}
*bolt();

module bolt_assembly() {
    color("green")
    for(side=[-1,1]) {
        translate([eps+front_plate_standoff,0,hole_z_offset])
        rotate([0,-90,0])
        translate([0,side*hole_y_offset,0])
        bolt();
    }
}

module front_plate() {
    difference() {
        union(){
            translate([-front_plate_depth+front_plate_standoff,
                       -front_plate_width/2,0])
            cube([front_plate_depth, front_plate_width, front_plate_height]);
        }
        union(){
            bolt_assembly();

            translate([0,0,-eps])
            wood_piece();
            
        }
    }
}
rotate([0,90,0])

front_plate();


