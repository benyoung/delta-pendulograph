mm=1;
in = 25.4*mm;

bearing_separation = 3*in;

plate_width = 3/4*in * sqrt(2);
hole_size = 8*mm;
plate_length=bearing_separation+plate_width;

pen_radius = 6*mm;

module double_bearing_plate(){
    difference() {
        union(){
            square([plate_length, plate_width],center=true);
        }
        for(trans = [-1/2, 1/2]){
            translate(trans*[bearing_separation, 0])
            circle(hole_size);
        }
    }
}

module carriage() {
    hexagon = [for(i = [0:6]) plate_length*[cos(60*i),sin(60*i)]];
    polygon(points=hexagon);
}
    


module pen_carriage() {
    difference() {
        carriage();
        circle(pen_radius);
    }
}



*double_bearing_plate();
carriage();
*pen_carriage();


