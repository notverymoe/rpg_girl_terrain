// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_baseplate.scad>;

girl_tile(1, false);

module girl_tile(size = 1, solid = false) {

	$fn=24;

	x = is_num(size) ? size : size[0];
	y = is_num(size) ? size : size[1];
	grid_key_width_tol = 0.4;

	lattice_wall = max(grid_key_width+grid_key_width_tol+fdm_ideal_wall, frame_size/4*3);

	difference() {
		linear_extrude(tile_height) 
		square([grid_tile_size*x,grid_tile_size*y], center=true);

		if (!solid) {
			repeat([grid_tile_size, grid_tile_size, 1], x, y, 1, true) 
			repeat([grid_tile_size/2, grid_tile_size/2, 1], 2, 2, 1, true)
			difference() {
				translate([0,0,-0.005]) 
				linear_extrude(tile_base_thickness+0.005, scale=0.75, convexity=2)
				difference() {
					square(grid_tile_size/2, center=true);
					_girl_baseplate_lattice(grid_tile_size/2, lattice_wall, 1);
				}
			}
		}

		translate([0,0,-0.1]) 
		linear_extrude(magnet_height+0.1, convexity=2) 
		repeat([grid_tile_size, grid_tile_size, 1], x, y, 1, true) {
			circle(d=magnet_dia+0.25, $fn=32);
			if (solid) {
				rotate( 45) square([magnet_dia*2.00, magnet_dia/2], center=true);
				rotate(-45) square([magnet_dia*2.00, magnet_dia/2], center=true);
			} else {
				rotate( 45) square([magnet_dia*3.00, magnet_dia/3], center=true);
				rotate(-45) square([magnet_dia*3.00, magnet_dia/3], center=true);
			}
		}
		
		repeat([grid_tile_size, grid_tile_size, 1], x, y, 1, true) {
			_girl_baseplate_tile_key(grid_key_width, grid_key_width_tol, 0.8);
		}
	}

}
