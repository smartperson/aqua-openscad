use <MCAD/2Dshapes.scad>;

rod_length_cm=15;
rod_width_mm=5;

screw_width_mm = 3;
screw_length_mm = 15;

//Print numbers for cm
show_text = true;

rod_length = rod_length_cm*10;

//the amount to reduce the hole size for a self-tapping screw into plastic
screw_hole_margin = 0.1*screw_width_mm;

/* [Hidden] */
$fa=1;
$fs=0.5;
font_size = min(5.25, 0.8*rod_width_mm);

difference() {
     union(){
        color("white") cube([rod_width_mm, rod_width_mm, rod_length]);
        color("black")
        for (i = [1 : 1 : rod_length/10 -1 ]) {
            translate([0, -0.399, i*10]) {
                cube([rod_width_mm, 0.4, 1]);
                if(show_text) translate([rod_width_mm*0.9,0.4,1.1]) rotate([90, -90, 0]) linear_extrude(height=0.4) text(text=str(i), size=font_size);
            }
        }
    };
    translate([rod_width_mm/2, rod_width_mm/2, -0.01])
        cylinder(h=screw_length_mm*1.1, r=(screw_width_mm-screw_hole_margin)/2);
}