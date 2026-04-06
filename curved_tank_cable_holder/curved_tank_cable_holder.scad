inner_diameter=23*25.4;
pond_thickness=1.75*25.4;
wall_thickness=2;
margin=0.002;
total_arc=22.5;

difference() {
    linear_extrude(height=3*25.4+wall_thickness, center=false)
        arc((inner_diameter/2)-wall_thickness, (inner_diameter+2*pond_thickness)/2+wall_thickness, 0, total_arc);
    translate([0,0,-margin]) pond_rim();
}

!cable_holder(10, 20, 8);

module cable_holder(base_width, base_length, opening_diameter) {
    square([base_width, base_length]);
}

module pond_rim() {
    linear_extrude(height=3*25.4, center=false) {
        arc(inner_diameter/2, (inner_diameter+2*pond_thickness)/2, 0-margin, total_arc+margin);
    }
}

module arc(r1, r2, a1, a2, $fn=128) {
  r0 = min(r1, r2);
  r  = max(r1, r2);

  a = (a1 % 360 + 360) % 360;
  b = (a2 % 360 + 360) % 360;
  d = (b - a) % 360;
  s = d < 0 ? d + 360 : d;       // sweep in [0,360)

  if (s == 0) {
      difference() {
          circle(r=r, $fn=$fn);
          if (r0 > 0) circle(r=r0, $fn=$fn);
      }
  } else {
      k = max(3, ceil($fn * s / 360));
      outer = [ for (i=[0:k]) [ r  * cos(a + s*i/k), r  * sin(a + s*i/k) ] ];
      inner = [ for (i=[0:k]) [ r0 * cos(b - s*i/k), r0 * sin(b - s*i/k) ] ];
      polygon(concat(outer, inner));
  }
}