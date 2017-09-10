mm = 1;
layer = 0.36;
slop = 0.3*mm;

stick_slop = 0.15*mm;
stick_width = 16.9*mm + stick_slop;
stick_th = 8.3*mm+stick_slop;
wall=5*layer;

sleeve_len = 60*mm;
pocket_len = 30*mm;
sticky_outy_bit_len = sleeve_len - pocket_len;

pipe_inner_rad = 15.6*mm/2;
pipe_outer_rad = 21.3*mm/2 + slop;
bearing_outer_rad = 30.0*mm/2+slop;
bearing_th = 6.4;
eps = 0.001;
$fn=120;

module shoe(is_lower_side) {
    difference(){
        union(){
            cube([sleeve_len + 4*wall,stick_width+2*wall, stick_th+2*wall]);
            translate([sleeve_len+bearing_outer_rad,stick_width/2+wall,0])
            cylinder(r=bearing_outer_rad+wall, h=bearing_th);
        }
        union(){
            translate([-wall,wall,wall])
            cube([pocket_len-wall ,stick_width, stick_th]);
    
            if(is_lower_side) {
                // bearing housing - comment this out to get the pipe housing
                translate([sleeve_len+bearing_outer_rad,stick_width/2+wall,wall])
                cylinder(r=bearing_outer_rad, h=2*bearing_th+wall);
            } else {
                // pipe housing
                translate([sleeve_len+bearing_outer_rad,stick_width/2+wall,wall])
                cylinder(r=pipe_outer_rad, h=bearing_th+wall);
            }
    
                
            // Hole through the middle
            translate([sleeve_len+bearing_outer_rad,stick_width/2+wall,-wall])
            cylinder(r=pipe_inner_rad, h=stick_th+2*wall);
            
            //cutaway
            translate([sleeve_len+bearing_outer_rad, stick_width/2+wall, bearing_th-eps])
            cylinder(r=sticky_outy_bit_len+bearing_outer_rad+wall, 
                    h=stick_th+2*wall);
    
            
        }
    }
}
    
shoe(true);
translate([0,40*mm,0])
shoe(false);

/*
difference(){
    translate([sleeve_len+bearing_outer_rad,stick_width/2+wall,0])
    cylinder(r=pipe_inner_rad, h=bearing_th);
    translate([sleeve_len+bearing_outer_rad,stick_width/2+wall,-0.001])
    cylinder(r=pipe_inner_rad-0.81, h=bearing_th+wall-0.04);
}
*/