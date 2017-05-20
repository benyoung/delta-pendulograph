mm=1;
in=25.4*mm;

gimbal_th = 31.5*mm;
gimbal_rad=31.0625*mm;
cube_side=1*in;
gimbal_dia_with_cones = 69.8*mm;

cube_offset = gimbal_dia_with_cones/2 + cube_side/2;

projection()
union(){
    rotate([atan2(gimbal_th,2*gimbal_rad),0,0])
    cylinder(r=gimbal_rad, h=gimbal_th,center=true);
    
    for(flip=[-1,1]){
        
        translate(flip*[cube_offset,0,0])
        cube(cube_side, center=true);
    }
}