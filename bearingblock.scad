

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
module block(){
    translate([0,0,block_size/2])
    difference() {
        union(){
            cube(block_size,center=true);
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
*difference(){
    cylinder(r=axle_cutout_rad,h=bearing_th);
    union(){
        translate([0,0,-bearing_th])
        cylinder(r=axle_cutout_rad-wall, h=3*bearing_th);
        cylinder(r1=0,r2=axle_cutout_rad,h=bearing_th+2*eps);
    }
}

