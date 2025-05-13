// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

module _scifi_floor_grate(size = grid_size, frame_w = 2.5) {

	w = is_num(size) ? size : size[0];
	h = is_num(size) ? size : size[1];

	_scifi_floor_grate_sheet([w,h], 0.5);

	translate([0,0,0.5])
		_scifi_floor_grate_frame([w,h], frame_w);
}

module _scifi_floor_grate_sheet(size = grid_size, thickness = 0.5) {
	w = is_num(size) ? size : size[0];
	h = is_num(size) ? size : size[1];

	linear_extrude(thickness) {
		difference() {
			square([w,h], center=true);
			
			repeat([3,3,1], (w)/3, (h)/3, 1, center=true)
				circle(d=1.5, $fn=6);
			
			repeat([3,3,1], (w)/3-1, (h)/3-1, 1, center=true)
				circle(d=1.5, $fn=6);
		}
	}
}

module _scifi_floor_grate_frame(size = grid_size, thickness = 2.5) {
	w = is_num(size) ? size : size[0];
	h = is_num(size) ? size : size[1];

	// TODO height control
	intersection() {
		resize([w+0.2,h+0.2,0.75])
		minkowski() {	
			linear_extrude(1)
			offset(-0.5) {
				difference() {
					square([w,h], center=true);
					square([w-2*thickness,h-2*thickness], center=true);
				}
				
				mirror_copy([1,0])
				mirror_copy([0,1])
				translate([(w - 2*thickness)/2,(h - 2*thickness)/2])
				rotate(45)
					square(sqrt(pow(2*thickness, 2)/2), center=true);
			}

			rotate([45,45,45]) {
				cube(0.5, center=true);
			}
		}
		
		linear_extrude(0.75) {
			square([w,h],center=true);
		}
	}

}
