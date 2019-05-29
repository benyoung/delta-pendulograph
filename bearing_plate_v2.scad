mm=1;
cm = 10*mm;
in=25.4*mm;
$fn=30;

slop = 0.1*mm;
magnet_depth_extend=0.9*mm;

makerbeam_length=100*mm;
makerbeam_width = 10*mm+slop;
bearing_rad = 5*mm;
magnet_rad = 6*mm;
magnet_th=3.7*mm;
bearing_offset = 20*mm;

sphere_plus_magnet_diameter = 11.6*mm;
magnet_center_th = sphere_plus_magnet_diameter - 2*bearing_rad;

module magnet() {
    union() {
        cylinder(r=magnet_rad+slop, h=magnet_th);
        translate([0,0,magnet_th-eps])
        cylinder(r1=magnet_rad+slop,r2=magnet_rad+slop/2,h=magnet_depth_extend);
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
    difference(){
        cube([makerbeam_length, makerbeam_width, makerbeam_width], center=true);
        *for(rot=[90,270])
        rotate([rot,0,0])
        translate([0*mm,0*mm,5*mm])
        cube([makerbeam_length+1*mm, 2.8*mm,2.8*mm], center=true);
    }
}


wall = 2*mm;
holder_th = magnet_th+wall+magnet_depth_extend;
holder_width = 2*magnet_rad+2*wall;

module holder() {

    translate([3*mm,0,-0.*mm])
    cube([10*mm,9.99*mm,10*mm],center=true);
    translate([0,0,-holder_th/2+magnet_depth_extend/2])
    cube([holder_width, 2*bearing_offset, holder_th],center=true);
    for(side = [-1,1])
    translate([0,side*bearing_offset,-holder_th+magnet_depth_extend/2])
    cylinder(r=holder_width/2, h=holder_th);
}

module plate(){
    difference(){
        holder();
        translate([0,0,bearing_rad+magnet_center_th-magnet_th])
        rotate([0,-45,0])
        stuff_to_hold();
    }
}

screw_cutdepth = 6.7*mm;
screw_hole_rad = 3.5*mm/2;
screw_head_rad = 6*mm/2;
module screw(){
    cylinder(r=screw_head_rad, h=1*in);
    translate([0,0,-1*in+eps])
    cylinder(r=screw_hole_rad,h=1*in);
}

rotate([0,135,0])
translate([0,0,-screw_cutdepth])
difference(){
    translate([0,0,screw_cutdepth])
    rotate([0,-135,0])
    translate([-holder_width/2,0,holder_th])
    plate();
    
    translate([0,0,3*mm])
    color("green")
    screw();
}
