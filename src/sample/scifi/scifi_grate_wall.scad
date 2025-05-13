// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_floor_grate_parts.scad>;
use<_scifi_wall_pipes_parts.scad>;

scifi_grate_wall();

module scifi_grate_wall() {
	girl_tile();

	translate([wall_width/2,0,tile_height-0.01])
		_scifi_floor_grate([grid_size-wall_width,grid_size]);
	
	translate([-grid_size/2,grid_size/2,tile_height-0.01]) {
		rotate([90,0,0]) {
			_scifi_wall_pipes([grid_size, grid_size/3, wall_width]);
		}
	}
}
