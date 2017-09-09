mm=1;
layer = 0.35*mm;

slop = 0.1*mm;

pen_rad = 4*mm+slop;
shoe_hole_rad = 15.6*mm/2 - 4*slop;
inset_height = 8*mm;
flange_thickness = 3*layer;
flange_rad = 15*mm;
eps=0.001*mm;

$fn=120;

num_cuts = 15;
cut_width = 1*mm;
difference(){
    union(){
        cylinder(r = shoe_hole_rad, h=inset_height);
        cylinder(r=flange_rad, h=flange_thickness);
    }
    union(){
        translate([0,0,-eps])
        cylinder(r=pen_rad, h=2*inset_height);
        for(i=[1:num_cuts]) {
            rotate([0,0,360/num_cuts*i])
            translate([-cut_width,0,-eps])
            cube([cut_width, pen_rad+cut_width, 2*inset_height]);
        }
    }
}