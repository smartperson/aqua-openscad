$fa=1;
$fs=0.5;

use <MCAD/2Dshapes.scad>;

rod_length=150;
rod_width=5;

screw_width = 3;
screw_length = 15;

//the amount to reduce the hole size for a self-tapping screw into plastic
screw_hole_margin = 0.3;

difference() {
     union(){
        color("white") cube([rod_width, rod_width, rod_length]);
        color("black")
        for (i = [1 : 1 : rod_length/10 -1 ]) {
            translate([0, -0.399, i*10]) {
                cube([rod_width, 0.4, 1]);
                translate([rod_width*0.9,0.4,1.1]) rotate([90, -90, 0]) linear_extrude(height=0.4) text(text=str(i), size=rod_width*0.8);
            }
        }
    };
    translate([rod_width/2, rod_width/2, -0.01])
        cylinder(h=screw_length*1.1, r=(screw_width-screw_hole_margin)/2);
}