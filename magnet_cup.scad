mm=1;
eps=0.01;
$fn=60;

module magnet(th) {
    cylinder(r = 5*mm+th, h = 3*mm+th);
    translate([0,0,3*mm+th-eps])
    cylinder(r1=5*mm+th,r2=0,h=5*mm+th);
}

module shaft(th, height) {
    cylinder(r=3.5*mm+th, height);
}

module part(th, height) {
    magnet(th);
    translate([0,0,2*mm])
    shaft(th,height);
}

module shell(){
    cylinder(r=6.2*mm,h=3*mm);
    translate([0,0,3*mm-eps])
    cylinder(r1=6.2*mm, r2=2*mm, h=10*mm);  
}

difference(){
    shell();
    translate([0,0,-eps])
    part(0.2*mm,100*mm);
    
}