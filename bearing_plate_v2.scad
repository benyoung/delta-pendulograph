mm=1;
cm = 10*mm;
$fn=30;

makerbeam_length=100*mm;
makerbeam_width = 10*mm;
bearing_rad = 5*mm;
magnet_rad = 6*mm;
magnet_th=3.7*mm;
bearing_offset = 20*mm;

sphere_plus_magnet_diameter = 11.6*mm;
magnet_center_th = sphere_plus_magnet_diameter - 2*bearing_rad;

module magnet() {
    difference() {
        cylinder(r=magnet_rad, h=magnet_th);
        //translate([0,0,bearing_rad+magnet_center_th])
        //sphere(bearing_rad);
    }
}

eps=0.01*mm;
module stuff_to_hold() {
    color("red")
    for(side=[-1,1])
    translate([0,side*bearing_offset,0])
    union(){
        //sphere(bearing_rad);
        rotate([0,45,0])
        translate([0,0,-bearing_rad-magnet_center_th+eps])
        magnet();
    }
    cube([makerbeam_length, makerbeam_width, makerbeam_width], center=true);
}


wall = 2*mm;
holder_th = magnet_th+wall;
holder_width = 2*magnet_rad+2*wall;

module holder() {

    translate([0,0,-holder_th/2])
    cube([holder_width, 2*bearing_offset, holder_th],center=true);
    for(side = [-1,1])
    translate([0,side*bearing_offset,-holder_th])
    cylinder(r=holder_width/2, h=holder_th);
}


union(){
    holder();
    translate([0,0,bearing_rad+magnet_center_th-magnet_th])
    rotate([0,-45,0])
    stuff_to_hold();
}
