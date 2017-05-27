mm=1;
in=25.4*mm;


pendulum_rad = (1+5/16)*in/2;

nut_rad = 6*mm; // MADE-UP NUMBER
nut_th  = 4*mm; // MADE-UP NUMBER

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

width_cheat = -5*mm;
front_plate_width = 2*hole_y_offset + 2*bolt_head_radius + 2*width_cheat;
front_plate_height = 2*hole_z_offset;
front_plate_depth = 1/sqrt(2)*wood_piece_width; // kinda artificial since we
// are going to be subtracting off a wood piece - just has to be deep enough to
// reach into the inside of the wood piece basically

front_plate_standoff = 0.3*in; // tweak this until it looks beefy

back_plate_standoff=front_plate_standoff;
back_plate_th = 2*back_plate_standoff;
pendulum_offset = 15*mm;


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

module nut_assembly() {
    color("green")
    for(side=[-1,1]) {
        translate([back_plate_standoff+eps,0,hole_z_offset])
        rotate([0,-90,0])
        translate([0,side*hole_y_offset,0])
        cylinder(r=nut_rad,h=nut_th,$fn=6);
    }    
}

module front_plate() {
    translate([-front_plate_standoff,0,0])
    difference() {
        union(){
            translate([-front_plate_depth+front_plate_standoff,
                       -front_plate_width/2,0])
            cube([front_plate_depth, front_plate_width, front_plate_height/2]);
            for(side=[-1,1]) {
                translate([-front_plate_depth+front_plate_standoff,0,front_plate_height/2])
                rotate([0,90,0])
                translate([0,side*hole_y_offset,0])
                cylinder(r=front_plate_height/2,h=front_plate_depth);
            }
        }
        union(){
            bolt_assembly();

            translate([0,0,-eps])
            wood_piece();
            
        }
    }
}

module back_plate() {
    //translate([-back_plate_standoff,0,0])
    difference() {

        union(){
            translate([-back_plate_th+back_plate_standoff,-hole_y_offset,0])
            cube([back_plate_th, 2*hole_y_offset, 2*hole_z_offset]);
            for(side=[-1,1]) {
                translate([-back_plate_th+back_plate_standoff,side*hole_y_offset,
                        hole_z_offset])
                rotate([0,90,0])
                cylinder(r=hole_z_offset,h=back_plate_th);
            }

        }
        union(){
            bolt_assembly();
            nut_assembly();
            color("red") //pendulum
            translate([-pendulum_offset,0,0])
            cylinder(r=pendulum_rad, h=6*in, center=true);
            
        }
    }
}

rotate([0,90,0])
back_plate();

translate([3*hole_z_offset,0,0])
rotate([0,90,0])
front_plate();


