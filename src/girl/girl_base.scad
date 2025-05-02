// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;

base_thickness = 1.5;
base_gap       = magnet_height;

base_rad      = base_size/2;
base_rad_top  = (base_size - 2)/2;
base_rad_in   = base_rad_top+(base_rad-base_rad_top)*(base_gap/(base_thickness+base_gap));
 
girl_base();

module girl_base() {
	$fn=24;
	difference() {
		union() {
			_girl_base_part();
			cylinder(d=magnet_dia+2*base_thickness, h=base_gap);
			
			for(i = [0:2])
			rotate(60*i)
			linear_extrude(base_gap)
			square([base_size-1.45*base_thickness,base_thickness], center=true);
		}
		
		_girl_base_magnet_hole();
	}
}

module _girl_base_part() {
	rotate_extrude($fn=6)
	intersection() {
		polygon([ 
			[                  base_rad,                       0],
			[              base_rad_top, base_thickness+base_gap],
			[                        -1, base_thickness+base_gap],
			[                        -1,                base_gap],
			[base_rad_in-base_thickness,                base_gap],
			[base_rad   -base_thickness,                       0],
		]);
		square([base_rad, base_thickness+base_gap]);
	}
}

module _girl_base_magnet_hole(tolerance=0.15) {
	mad_d = magnet_dia+2*tolerance;
	mag_h = magnet_height+2*tolerance;
	
	translate([0,0,-0.05])
	cylinder(d=mad_d, h=mag_h+0.05);
}