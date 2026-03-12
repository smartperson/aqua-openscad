module tube(od=16, id=10, length=25) {
difference(){
        cylinder(h=length, r=od);
        translate([0,0,-0.005])cylinder(h=length+0.01, r=id);
    };
}

tube();