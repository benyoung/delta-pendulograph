mm=1;
in=25.4*mm;
slop = 0.17*mm;
eps=0.01*mm;


module beam(){
    cube([10*mm + slop, 100*mm, 10*mm+slop], center=true);
}

center_rad = 13*mm;
wall=2*mm;

holder_len=20*mm;
module beam_holder() {
    
    difference(){
        cube([10*mm+2*wall, holder_len,10*mm+2*wall], center=true); 
        beam();
        
        color("pink")
        translate([0,holder_len/2-sqrt(2)*5*mm+1*mm,0])
        rotate([0,0,45])
        translate([0,0,-5*mm])
        cube([15*mm,15*mm,10*mm]);
    }
}



cyl_height = 10*mm+2*wall;
top_holder_len=14*mm;
union(){

    
    difference(){   
        union(){
            for(rot=[0,120,240])
            rotate([0,0,rot])
            translate([0,center_rad+holder_len/2,(10*mm+2*wall)/2])
            beam_holder();
    
            
            translate([0,0,cyl_height/2])
            cylinder(r=center_rad+wall, h=cyl_height,center=true);
            color("green")
            cylinder(r=holder_len+center_rad,h=wall);
            translate([0,center_rad+wall+5*mm,top_holder_len/2 + wall + 10*mm])
            rotate([90,0,0])
            union(){
                cube([10*mm+2*wall, top_holder_len*mm,10*mm+2*wall], center=true);
             }
 
                               
        }
        union(){
            translate([0,0,cyl_height/2])
            cylinder(r=center_rad,h=cyl_height+eps, center=true);
            
            translate([0,center_rad+wall+5*mm,top_holder_len/2 + wall + 10*mm])
            rotate([90,0,0])
            color("red") 
            union(){
                translate([0,35*mm,0*mm])
                beam();
                rotate([90,0,0])
                cylinder(r=3*mm,h=2*in,center=true,$fn=16);
            } 
                
                
            for(rot=[0,120,240]) {
            rotate([0,0,rot])
        
            translate([0,center_rad+wall+1.5*mm,wall+5*mm])
            color("blue")
                rotate([90,0,0])
            union(){
                translate([0,0,0.2*mm])
                cylinder(r1=0, r2=3.5*mm,h=3.5*mm);
                translate([0,0,3.5*mm-eps])
                cylinder(r=3.5*mm,h=2*mm);
                translate([0,0,2*mm])
                cylinder(r=2*mm,h=40*mm,$fn=6);
            }
        }
        }
    }
}







