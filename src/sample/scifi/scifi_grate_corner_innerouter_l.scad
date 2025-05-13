// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_floor_grate_parts.scad>;
use<_scifi_wall_pipes_parts.scad>;

scifi_grate_corner_innerouter_l();

module scifi_grate_corner_innerouter_l() {
	girl_tile();

	translate([0,0,tile_height-0.01])
		_scifi_floor_grate([grid_size-2*wall_width,grid_size-2*wall_width]);
	
	rotate(180)
	mirror_copy([1,1])
	translate([-(grid_size-wall_width)/2,0,tile_height-0.01])
		_scifi_floor_grate([wall_width,grid_size-2*wall_width]);
	
	translate([grid_size/2,-grid_size/2,tile_height+0.01])
		rotate(90)
		_scifi_wall_corner_outer([grid_size/3, wall_width]);
	
	translate([-(grid_size-wall_width)/2,0,tile_height-0.01])
		_scifi_floor_grate([wall_width,grid_size-2*wall_width]);
	
	rotate(90)
	mirror_copy([1,0])
	translate([-grid_size/2, grid_size/2, tile_height+0.01])
		rotate(270)
		_scifi_wall_corner_door([grid_size/3, wall_width]);

	mirror([1,1])
	translate([-grid_size/2,grid_size/2-wall_width,tile_height-0.01]) {
		rotate([90,0,0]) {
			_scifi_wall_pipes([grid_size-wall_width, grid_size/3, wall_width]);
		}
	}
	
}
