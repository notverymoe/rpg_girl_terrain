// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_grid.scad>;

girl_tile(1);

module girl_tile(size = 1) {

	$fn=24;

	x = is_num(size) ? size : size[0];
	y = is_num(size) ? size : size[1];

	difference() {
		union() {
			top_height = max(1.5, tile_height/4);
			translate([0,0,tile_height-top_height]) 
			linear_extrude(top_height) 
			square([grid_size*x,grid_size*y], center=true);

			linear_extrude(tile_height, convexity=2) 
			repeat([grid_size, grid_size, 1], x, y, 1, true) 
				repeat([grid_size/2, grid_size/2, 1], 2, 2, 1, true)
					_girl_grid_lattice(
						grid_size/2,
						max(grid_key_width+1.2, frame_size/3*2),
						3.5
					);
		}

		translate([0,0,-0.1]) 
		linear_extrude(magnet_height+0.1) 
		repeat([grid_size, grid_size, 1], x, y, 1, true) {
			circle(d=magnet_dia+0.2);
		}
		
		repeat([grid_size, grid_size, 1], x, y, 1, true) {
			_girl_grid_key(grid_key_width, 0.25, 0.5);
		}
	}

}
