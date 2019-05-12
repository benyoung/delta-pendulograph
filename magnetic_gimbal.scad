mm=1;
in=25.4;

slop = 0.1*mm;
$fn = 60;
eps=0.01*mm;
wall = 1*mm;


ball_bearing_rad=0.25*in;
module ball_bearing(){
    color([0.9,0.9,0.9])
    sphere(r=ball_bearing_rad+slop);
}

magnet_th=2.58*mm;
magnet_rad=5*mm;
module magnet() {
    color([0.9,0.9,0.9])
    cylinder(r=magnet_rad+slop, h=magnet_th,center=true); 
}
    
total_assembly_h = 15.76*mm;
magnet_offset = total_assembly_h/2 - magnet_th/2;
module magnet_assembly(){
    
    ball_bearing();
    translate([0,0,magnet_offset+slop])
    magnet();
    //translate([0,0,-magnet_offset])
    //magnet();
}

linear_bearing_rad = 15*mm/2;
linear_bearing_h = 24*mm;
module linear_bearing() {
    cylinder(r=linear_bearing_rad+slop,h=linear_bearing_h, center=true);
}
//magnet_assembly();



inner_unit();

gimbal_ring_h = 2*ball_bearing_rad + 4*wall;
gimbal_ring_rad = 16.5*mm; // made-up number

module four_magnet_assembly() {
    union(){
        for(side=[0,180])
        rotate([0,0,side])
        translate([gimbal_ring_rad,0,0])
        rotate([0,90,180])
        magnet_assembly();
        for(side=[90,270])
        rotate([0,0,side])
        translate([gimbal_ring_rad,0,0])
        rotate([0,90,0])
        magnet_assembly();            
    }   
}

module inner_unit() {
    difference() {
        union(){
            for(side=[0,180])
            rotate([0,0,side])
            translate([linear_bearing_rad,0,0])
            rotate([0,90,0])
            cylinder(r=magnet_rad+wall,h=magnet_th+wall);
            
            cylinder(r=2*wall+linear_bearing_rad, h=linear_bearing_h-2*eps,center=true);
        }
        union(){
            linear_bearing();
            four_magnet_assembly();
        }
    }
}

module gimbal_ring() {
    //union(){
    difference(){
        intersection() {
            cube([4*in, 4*in, gimbal_ring_h],center=true);
            difference(){
                sphere(gimbal_ring_rad+2.5*wall);
                sphere(gimbal_ring_rad-1.5*wall);
            }
        }
        four_magnet_assembly();
        
    }
}

post_size = 10*mm;
outer_ring_rad = 25*mm;
outer_ring_h = post_size+2*wall;

screw_head_rad=4*mm;
screw_offset=2.9*mm;
module outer_ring(){
    //union(){
    difference(){
        union(){
            intersection() {
                cube([4*in, 4*in, outer_ring_h],center=true);
                difference(){
                    sphere(outer_ring_rad+2*wall);
                    sphere(outer_ring_rad-2*wall);
                }
            }
            for(rot=[0,120,240])
            rotate([0,0,rot])
            translate([outer_ring_rad+post_size/2,0,0])
            cube([post_size,post_size+2*wall,outer_ring_h],center=true);
       
        }
        union(){
            four_magnet_assembly();
            for(rot=[0,120,240])
            rotate([0,0,rot])
            union(){
                translate([outer_ring_rad+post_size/2,0,0])
                cube([post_size+eps,post_size,post_size],center=true);
                
                translate([outer_ring_rad-screw_offset,0,0])
                rotate([0,90,0])
                cylinder(r1=screw_head_rad,r2=0,h=screw_head_rad);
            }
            
        }
    }  

}



gimbal_ring();
outer_ring();




