// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_floor_grate_parts.scad>;
use<_scifi_wall_pipes_parts.scad>;

scifi_tile_wall_deadend();

module scifi_tile_wall_deadend() {
	girl_tile();

	translate([0,-wall_width/2,tile_height-0.01])
		_scifi_floor_grate([grid_size-wall_width*2,grid_size-wall_width]);
	
	mirror_copy([1,0])
	translate([-grid_size/2,grid_size/2-wall_width,tile_height-0.01]) {
		rotate([90,0,0]) {
			_scifi_wall_pipes([grid_size-wall_width, grid_size/3, wall_width]);
		}
	}
	
	mirror([1,1])
	translate([-grid_size/2,grid_size/2-wall_width,tile_height-0.01]) {
		rotate([90,0,0]) {
			_scifi_wall_pipes([grid_size-wall_width*2, grid_size/3, wall_width]);
		}
	}
	
	mirror_copy([1,0])
	translate([-grid_size/2,grid_size/2-wall_width,tile_height+0.01])
		cube([wall_width,wall_width,grid_size/3+1]);
}
