outside_width = 100;
wall_thickness = 1;
outside_height=2*25.4;
drain_height=1.1*25.4;
drain_diameter=1.5*25.4;
inside_scale = (outside_width-wall_thickness*4)/outside_width;

margin=0.1;

difference() {
    union(){
        //drain exterior
        translate([outside_width*.33, outside_width*.33])
        cylinder(drain_height, r=drain_diameter/2);
        
        //base
        union() {
            difference() {
                //outer base
                translate([0,0,-3+margin]) rounded_rect(outside_width, outside_width, 3, 2);
                //channel for fitting lower piece underneath
                translate([wall_thickness,wall_thickness,-3]) rounded_rect(outside_width-wall_thickness*2, outside_width-wall_thickness*2, 3, 2);
            }
            //inner base
            translate([wall_thickness*3.5,wall_thickness*3.5,-3+margin]) rounded_rect(outside_width-wall_thickness*7, outside_width-wall_thickness*7, 3, 2);
        }
        

        difference() { //holding box
        rounded_rect(outside_width, outside_width, outside_height, 2);
        translate([wall_thickness*2, wall_thickness*2, wall_thickness*4]) 
            scale([inside_scale, inside_scale, inside_scale]) 
                rounded_rect(outside_width, outside_width, outside_height, 2);
        }
        
        //top rim
        difference() {
            translate([wall_thickness,wall_thickness,outside_height-margin])
                rounded_rect(outside_width-wall_thickness*2, outside_width-wall_thickness*2, 3, 2);
            //rim for fitting upper piece above
            translate([wall_thickness*2,wall_thickness*2,outside_height-margin*1.1])
                rounded_rect(outside_width-wall_thickness*4, outside_width-wall_thickness*4, 3+margin*2, 2);
        }
    }
    //drain hollow
    translate([outside_width*.33, outside_width*.33, -3-margin])
    resize([drain_diameter-wall_thickness*2, drain_diameter-wall_thickness*2, drain_height+3+margin*2])
    cylinder(drain_height+3, r=drain_diameter/2);
    
    //overflow cutouts
    union() {
        translate([0-0.5*margin, 0.75*outside_width/2, outside_height*0.9+margin])
            cube([1*outside_width+margin, 0.25*outside_width+margin, outside_height*.1+3]);
        translate([0.75*outside_width/2, 0-0.5*margin, outside_height*0.9+margin])
            cube([0.25*outside_width+margin, 1*outside_width+margin, outside_height*.1+3]);
    }
}
module rounded_rect(l, w, h, r)
{
    linear_extrude(h)
    translate([r, r, 0])
    offset(r=r, $fn = 60) 
    square([l-(2*r), w-(2*r)]);
}
