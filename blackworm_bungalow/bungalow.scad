outside_width = 100;
wall_thickness = 1.5;
outside_height=2*25.4;
drain_height=1.5*25.4;
drain_diameter=0.5*25.4;
inside_scale = (outside_width-wall_thickness*2)/outside_width;

margin=0.1;

difference() {
    union(){
        //drain exterior
        translate([outside_width*.25, outside_width*.25])
        cylinder(drain_height, r=drain_diameter/2);

        difference() { //holding box
        rounded_rect(outside_width, outside_width, outside_height, 2);
        translate([wall_thickness, wall_thickness, wall_thickness*2]) 
            scale([inside_scale, inside_scale, inside_scale]) 
                rounded_rect(outside_width, outside_width, outside_height, 2);
        }
    }
    //drain hollow
    translate([outside_width*.25, outside_width*.25, -margin])
    resize([drain_diameter-wall_thickness*2, drain_diameter-wall_thickness*2, drain_height+margin*2])
    cylinder(drain_height, r=drain_diameter/2);
}
module rounded_rect(l, w, h, r)
{
    linear_extrude(h)
    translate([r, r, 0])
    offset(r=r, $fn = 60) 
    square([l-(2*r), w-(2*r)]);
}
