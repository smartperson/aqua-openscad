use <MCAD/2Dshapes.scad>;

base_height = 2;
segment_height = 1;
disk_radius = 15;
hole_radius = 2;
num_segments = 4;
color("black") ;
difference() {
    union(){
        color("white") cylinder(h=base_height, r=disk_radius);
        
        translate([0,0,base_height+0.01])
        color("black") union() {
            linear_extrude(height = segment_height)
            for (i = [0 : 2 : num_segments])
                pieSlice(size=[disk_radius, disk_radius], start_angle=360/num_segments*i, end_angle=360/num_segments*(i+1));
        }
    }
    translate([0,0,-0.01]) cylinder(h=base_height*10, r=hole_radius);
};
