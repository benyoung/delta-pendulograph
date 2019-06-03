mm=1;
in=25.4*mm;
slop = 0.15*mm;
eps = 0.01*mm;
wall=2*mm;
center_rad=13*mm;

pen_width = 0.5*in+slop;
pen_depth = 0.620*in+slop;


holder_height=1.5*in;
beam_offset = center_rad+wall+5*mm;
$fn=16;

hole_offset = 0.42*in;

module bolt() {
    color("red")
    translate([pen_width/2-eps,0,0])
    rotate([90,0,0])
    rotate([0,90,0])
    union(){
        cylinder(r=1.75*mm,h=1*in);
        cylinder(r=3.3*mm,h=2*wall, $fn=6);
    }    
}

hole_sep = 0.35*in;
plate_width=0.375*in;
plate_sep = 1.25*in;
plate_th = 1/16*in;
tab_len = 1/2*in;


difference(){
    translate([0,0,-holder_height/2])
    linear_extrude(height=holder_height)
    difference(){
        union(){
            offset(wall)
            union(){
                polygon([
                    [-pen_width/2,-pen_depth/2],
                    [-beam_offset+5*mm, -5*mm],            
                    [-beam_offset+5*mm, 5*mm],            
                    [-pen_width/2,pen_depth/2],
                    [-pen_width/2,-pen_depth/2],
                ]);
                translate([-beam_offset,0])
    
                square([10*mm+slop, 10*mm+slop], center=true);
                square([pen_width, pen_depth],center=true);
                translate([2*wall,0,0])
                square([pen_width, pen_depth],center=true);
    
            }
        }
        union(){
            translate([-beam_offset,0])
    
            square([10*mm+slop, 10*mm+slop], center=true);
            
            square([pen_width, pen_depth],center=true);
            translate([-hole_offset,0])
            circle(r=0.8*mm);
        }
    }
    translate([0,0,hole_sep])
    bolt();
    translate([0,0,-hole_sep])
    bolt();
    color("red")
    union(){
        translate([pen_width/2+plate_th/2-eps,0,0])
        cube([plate_th, plate_width, plate_sep+plate_th], center=true);
        translate([pen_width/2+tab_len/2,-2*eps,plate_sep/2])
        cube([tab_len,plate_width,plate_th],center=true);
        translate([pen_width/2+tab_len/2,-2*eps,-plate_sep/2])
        cube([tab_len,plate_width,plate_th],center=true);
    }
}



