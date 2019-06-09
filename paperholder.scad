mm=1;
in=25.4*mm;
slop=0.15;
eps=0.01;

holder_length = 17*mm;
holder_th = 9*mm;
beam_width = 10*mm;
beam_slot_width=3*mm;
tab_len = 5*mm;
tab_depth=2*mm;

screw_rad=1.7*mm;

$fn=6;

shift=holder_length*0.2;

nut_width = 7*mm;
nut_th=2.5*mm;

rotate([90,0,0])
difference(){
    union(){
        cube([holder_length, holder_th, beam_width], center=true);
        translate([holder_length/2-tab_len/2,holder_th/2,0])
        cube([tab_len, tab_depth,  beam_slot_width-slop],center=true);
    }
    color("red")
    union(){
        translate([shift,-holder_th/2,0])
        cube([nut_width,holder_th+nut_width,nut_th],center=true);
        translate([shift,0,0])
        cylinder(r=screw_rad+slop,h=1*in,center=true);
        translate([-shift,0,0])
        rotate([90,0,0])
        cylinder(r=screw_rad+slop,h=1*in,center=true);
        
    }
}