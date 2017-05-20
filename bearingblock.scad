

mm=1;
in = 25.4*mm;

slop=0.1*mm;
bearing_rad = 22*mm/2 + slop;
bearing_th = 7*mm;
axle_cutout_rad=19.10*mm / 2;  // lifted from the 608zz bearing spec
                               // to stay out of the way of the shield

block_size = 1*in;
wall = 0.8*mm;
eps=0.01;

screw_plate_th = 0.25*in;
screw_plate_width = 0.4*in;
screw_plate_shift = 0.25*in;

screw_dia = 2*mm;
screw_head_dia = 4*mm;
screw_len = 3/4*in;
eps=0.01*mm;

module screw() {
    rotate([90,0,0])
    union(){
        cylinder(r=screw_dia, h=screw_len, $fn=30);
        cylinder(r1=screw_head_dia,r2=0, h=screw_head_dia, $fn=30);
        translate([0,0,-screw_head_dia+eps])
        cylinder(r=screw_head_dia,h=screw_head_dia, $fn=30);
    }
}



module screw_plate() {
    difference() {
        union(){
            
            cube([screw_plate_width, screw_plate_th, block_size], center=true);
        }
        for(shift=(block_size-screw_plate_width)/2* [-1,1]){
            translate([0,screw_plate_th/2,shift])
            screw();
            
        }
    }     
}



module block(){
    translate([0,0,block_size/2])
    difference() {
        union(){
            cube(block_size,center=true);
            for(trans=[-1/2,1/2]) {
                translate([0,-screw_plate_shift,0])
                translate(trans * [block_size+screw_plate_width,0,0])
                screw_plate();
            }
        }
        union(){
            for(side=[-1,1]) {
                translate([0,0,side*block_size/2])
                cylinder(r=bearing_rad,h=2*bearing_th,center=true);
            }


            cylinder(r=axle_cutout_rad, h=2*block_size, center=true);
        }
    }
}

block();
difference(){
    cylinder(r=axle_cutout_rad,h=bearing_th);
    union(){
        translate([0,0,-bearing_th])
        cylinder(r=axle_cutout_rad-2*wall, h=3*bearing_th);
        cylinder(r1=0,r2=axle_cutout_rad,h=bearing_th+2*eps);
    }
}

