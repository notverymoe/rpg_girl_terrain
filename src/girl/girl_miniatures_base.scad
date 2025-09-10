// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;

base_thickness = 1.5;
base_gap       = magnet_height;

base_rad     = miniature_scale/2;
base_rad_top = base_rad - 1.5;
base_rad_in  = base_rad_top+(base_rad-base_rad_top)*(base_gap/(base_thickness+base_gap));
 
girl_mini_base();

module girl_mini_base() {
	$fn=24;
	difference() {
		_girl_mini_base_part();
		_girl_mini_base_magnet_hole();
	}
}

module _girl_mini_base_part() {
	magnet_offset = (magnet_dia/2+base_thickness/2) / (sqrt(3)/2);
	rotate_extrude($fn=8)
	polygon([ 
		[              base_rad,                          0],
		[          base_rad_top,    base_thickness+base_gap],
		[                     0,    base_thickness+base_gap],
		[                     0,                          0],
		[         magnet_offset,                          0],
		[1.25*base_gap+magnet_offset,              base_gap],
		[base_rad_in-base_thickness-base_gap*1.25, base_gap],
		[base_rad   -base_thickness,                      0],
	]);
}

module _girl_mini_base_magnet_hole() {
	mad_d = magnet_dia;
	mag_h = magnet_height;
	
	translate([0,0,-0.05])
	cylinder(d=mad_d, h=mag_h+0.05);
	
	translate([0,0,(mag_h-0.05)/2])
	cube([mad_d/2, base_rad, mag_h+0.05], center=true);
}