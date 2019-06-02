mm=1;
in=25.4*mm;
slop = 0.15*mm;
eps = 0.01*mm;
wall=2*mm;
center_rad=13*mm;

pen_width = 0.5*in+slop;
pen_depth = 0.620*in+slop;


holder_height=1*in;
beam_offset = center_rad+wall+5*mm;
$fn=16;

hole_offset = 0.42*in;

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
                translate([wall,0,0])
                square([pen_width, pen_depth],center=true);
    
            }
        }
        union(){
            translate([-beam_offset,0])
    
            square([10*mm+slop, 10*mm+slop], center=true);
            
            square([pen_width, pen_depth],center=true);
            translate([-hole_offset,0])
            circle(r=0.6*mm);
        }
    }
    color("red")
    translate([pen_width/2-eps,0,0])
    rotate([90,0,0])
    rotate([0,90,0])
    union(){
        cylinder(r=1.75*mm,h=1*in);
        cylinder(r=3.5*mm,h=wall, $fn=6);
    }
}
