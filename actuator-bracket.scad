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
tab_wid = 1.0;
tab_height = 3.0;
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

tab_dim = [tab_wid, tab_len+0.5, tab_height+0.5];

tab_dim_r = [ tab_len+0.5, tab_width, tab_height+0.5];

module hole_support()
{
   cylinder(h=sol_height/2+0.5, d=hole_sup, $fn=60);  
}

module screw_hole()
{
   cylinder(h=sol_height/2+2.0+1, d=screw_hole, $fn=60);
}

module tab()
{
    cube(tab_dim);  
}

module tab_r()
{
    translate([plung_ex+2-tab_len, hole_sup+wall, 0 ]+[-0.5, 3.5*1.0, 1.5])
    {
        rotate(a=-90, v=[0,0,1]){cube(tab_dim);}  
    }
}

module stopwall()
{
    translate([0.1, 0.1, 1.5])
    {
        cube([1.9, plate_width-0.2, 0.5 + sol_height/2]);
    }  
}
 
module sidewall()
{
    translate([0.2, 0.15, 1.5])
    {
        cube([plate_length-0.4, 2.3, 0.45 + sol_height/2]);
    }  
}
 
module tabsupport()
{
    translate([4.5, 1, 1.5])
    {
        cube([4.5,11.2,2.0]);
    }  
} 
  
difference()
{
  union()
  {
    cube(base_plate_size);    // plate
    stopwall();
    sidewall();
    translate([0, 30, 0]) {sidewall();}
    tabsupport();
    translate([0, 20-0.7, 0]) {tabsupport();}
    translate([sol_length+6, 0, 0])
    {
        tabsupport();
        translate([0, 20-0.7, 0]) {tabsupport();}
    }
    translate(hole_support_1_trans) { hole_support(); } //1
    translate(hole_support_2_trans) { hole_support(); } //2
    translate(copy_other_side_trans)
    {
      translate(hole_support_1_trans) { hole_support(); } //3
      translate(hole_support_2_trans) { hole_support(); } //4
    }
    translate(hole_support_1_trans + [-tab_wid/2, hole_sup/2-0.5, 0]) { tab(); }
    translate(hole_support_2_trans + [-tab_wid/2, hole_sup/2-0.5, 0]) { tab(); }
    translate(copy_other_side_trans)
    {
      translate(hole_support_1_trans + [-tab_wid/2, -tab_len-0.5 -(hole_sup/2-0.5), 0]) { tab(); }
      translate(hole_support_2_trans + [-tab_wid/2, -tab_len-0.5 -(hole_sup/2-0.5), 0]) { tab(); }
    }
    tab_r();
    translate([0, 8, 0]) {tab_r();}
    translate([ sol_length+tab_len+0.5, 0, 0]) {tab_r();}
    translate([ sol_length+tab_len+0.5, 8, 0]) {tab_r();}
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
  translate([2.05, hole_sup+tab_len+wall+1, -0.5 ])
  {
    cube([2.3, sol_width-2, 2.0+1.0]);
  }
  translate([plung_ex+sol_length, hole_sup+tab_len+wall+4.5, -0.5 ])
  {
    cube([2.3, 3 , 2.0+1.0]);
  }
}
