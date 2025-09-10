// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_baseplate.scad>;

girl_tile(1);

module girl_tile(size = 1, solid = false) {

	$fn=24;

	x = is_num(size) ? size : size[0];
	y = is_num(size) ? size : size[1];
	grid_key_width_tol = 0.4;

	lattice_wall = max(grid_key_width+grid_key_width_tol+1.2, frame_size/4*3);

	difference() {
		union() {
			if (solid) {
				linear_extrude(tile_height) 
				square([grid_tile_size*x,grid_tile_size*y], center=true);
			} else {
				translate([0,0,tile_base_thickness]) 
				linear_extrude(tile_top_thickness) 
				square([grid_tile_size*x,grid_tile_size*y], center=true);

				repeat([grid_tile_size, grid_tile_size, 1], x, y, 1, true) 
				repeat([grid_tile_size/2, grid_tile_size/2, 1], 2, 2, 1, true)
				union()	{
						linear_extrude(tile_base_thickness, scale=0.33, convexity=2) 
						_girl_baseplate_lattice(grid_tile_size/2, lattice_wall, magnet_dia/3*2);
							
						// [BF_COLLINEAR] HACK: Ideally this should be `lock_depth`, but if we make it exact we get degenerate faces
						translate([0,0,-0.01]) 
						linear_extrude(tile_base_thickness-0.01, convexity=2)
						_girl_baseplate_lattice(grid_tile_size/2, lattice_wall, magnet_dia/3*2);
				}
			}
		}

		translate([0,0,-0.1]) 
		linear_extrude(magnet_height+0.1) 
		repeat([grid_tile_size, grid_tile_size, 1], x, y, 1, true) {
			circle(d=magnet_dia+0.25, $fn=32);
			square([magnet_dia*2.00, lattice_wall-0.6], center=true);
		}
		
		repeat([grid_tile_size, grid_tile_size, 1], x, y, 1, true) {
			_girl_baseplate_tile_key(grid_key_width, grid_key_width_tol, 0.8);
		}
	}

}
