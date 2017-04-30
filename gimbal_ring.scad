//include <mast.scad>

mm=1;
in = 25.4*mm;
slop=0.1*mm;


insert_depth = 5*mm;
insert_rad = 3.2*mm + slop;
wall = 3.5*mm;

insert_translate = 30*mm;
eps = 0.01*mm;

pendulum_rad = (1+5/16)*in / 2;
pendulum_clearance = 1/32*in;

true_axle_rad = 7.9*mm/2; // a tad small but this should be drilled out to size anyway

bearing_axle_protrude=10*mm;
bearing_axle_rad = 6.0*mm; // leaving quite a bit of clearance here
//bearing_axle_len = 14*mm;
bearing_outer_rad = 11.0*mm + slop;
//bearing_th = 6.5*mm + slop;
// adapted for 608ZZ bearings.  should be just 7mm?? but it's dodgy at the edges
bearing_th = 8.2*mm + slop;  

bearing_inset = 2*mm;
ring_outer_tighten = 1.3*mm;
ring_th = 2*bearing_outer_rad + 2*wall;
ring_width = 2*wall + bearing_th ;
//ring_middle_rad = 37*mm+bearing_inset;

ring_middle_rad = ring_width/2 + pendulum_rad + pendulum_clearance;
ring_rad = ring_middle_rad - ring_width/2- ring_outer_tighten;

bearing_axle_len = 5*ring_width;


module bearing_slot(){
    rotate([0,90,0])
    translate([0,0,-bearing_th/2])
    union(){
        translate([0,-bearing_outer_rad,0])
        cube([bearing_outer_rad+2*wall,2*bearing_outer_rad, bearing_th]);
        cylinder(r=bearing_outer_rad, h=bearing_th);
        translate([0,0,-bearing_axle_protrude])
        cylinder(r=bearing_axle_rad, h=bearing_axle_len);
//        translate([0,-bearing_axle_rad,-bearing_axle_protrude])
//        cube([bearing_outer_rad+2*wall,2*bearing_axle_rad, bearing_axle_len]);
    }
}


$fn=60;
difference(){
    union(){
        cylinder(r = ring_rad + ring_width, h = ring_th,center=true);
        
        for(rot=[0,180]) {
            rotate([0,0,rot])
            translate([0,ring_rad+ring_width-wall,0])
            rotate([-90,0,0])
            cylinder(r1 = true_axle_rad + 2*wall, r2=0, h=true_axle_rad+2*wall);
        }
    }
    union(){
        cylinder(r = ring_rad, h = 2*ring_th,center=true);
        for(i=[0:1]) {
            rotate([0,0,180*i]) {
                translate([ring_middle_rad-bearing_inset, 0,0])
                rotate([180,0,180])
                bearing_slot();
                
//                rotate([180,0,90])
//                translate([ring_middle_rad, 0,0])
//                bearing_slot();
            for(swing=[-5,2,0,2,5]){        
                rotate([5*swing,0,0])
                cylinder(r = pendulum_rad+pendulum_clearance, h = 5*ring_th,center=true);
            }
            }
        }
        rotate([90,0,0])
        cylinder(r=true_axle_rad, h=5*ring_rad, center=true);

        
    }
}


*color("red")
cylinder(r=pendulum_rad, h=8*in, center=true);

*color("red")
rotate([0,90,0])
cylinder(r=true_axle_rad,h=2*in,center=true);

