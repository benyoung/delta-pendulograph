mm=1;
in = 25.4*mm;

bearing_separation = 3*in;

plate_width = 3/4*in * sqrt(2);
hole_size = 8*mm;

difference() {
    union(){
        square([bearing_separation + plate_width, plate_width],center=true);
    }
    for(trans = [-1/2, 1/2]){
        translate(trans*[bearing_separation, 0])
        circle(hole_size);
    }
}