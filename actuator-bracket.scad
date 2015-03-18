inch = 25.4;

// solenoid dimensions
sol_width = 12.0;
sol_height = 11.0;
sol_length = 20.0;

// base plate

// dimensions
screw_hole = 0.1285 * inch;
hole_sup = 2.0*2 + screw_hole;
wall = 2.0;

tab_len = 1.0;
plung_ex = 7.6;

plate_length = sol_length + plung_ex + 2 + 4.5 + 2;

plate_width = sol_width + 2*tab_len + 2*hole_sup + 2*wall;

opening_length = sol_length - 2*1.0;
opening_width = sol_width - 2*1.0;

base_plate_size = [plate_length, plate_width, 2.0];
hole_support_1_trans = [plung_ex+2+hole_sup/2, 2+hole_sup/2, 1.5];
hole_support_2_trans = [plung_ex+2+sol_length-hole_sup/2, 2+hole_sup/2, 1.5];

copy_other_side_trans = [0, sol_width + hole_sup + 2*tab_len, 0];

screw_hole_1_trans = hole_support_1_trans + [0, 0, -2.0];
screw_hole_2_trans = hole_support_2_trans + [0, 0, -2.0];

module hole_support()
{
   cylinder(h=sol_height/2+0.5, d=hole_sup, $fn=60);  
}

module screw_hole()
{
   cylinder(h=sol_height/2+2.0+1, d=screw_hole, $fn=60);
}

difference()
{
  union()
  {
    cube(base_plate_size);    // plate
    translate(hole_support_1_trans) { hole_support(); } //1
    translate(hole_support_2_trans) { hole_support(); } //2
    translate(copy_other_side_trans)
    {
      translate(hole_support_1_trans) { hole_support(); } //3
      translate(hole_support_2_trans) { hole_support(); } //4
    }
  }     // end of union
  translate(screw_hole_1_trans)  { screw_hole(); }  //1
  translate(screw_hole_2_trans)  { screw_hole(); }  //2
  translate(copy_other_side_trans)
  {
      translate(screw_hole_1_trans) { screw_hole(); } //3
      translate(screw_hole_2_trans) { screw_hole(); } //4
  }
  translate([plung_ex+1+2, hole_sup+tab_len+wall+1, -0.5 ])
  {
    cube([sol_length-2, sol_width-2, 2.0+1.0]);
  }
}
