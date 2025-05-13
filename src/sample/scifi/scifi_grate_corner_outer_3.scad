// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_floor_grate_parts.scad>;
use<_scifi_wall_pipes_parts.scad>;

scifi_grate_corner_outer_3();

module scifi_grate_corner_outer_3() {
	girl_tile();

	translate([wall_width/2,-wall_width/2,tile_height-0.01])
		_scifi_floor_grate([grid_size-wall_width,grid_size-wall_width]);
	
	mirror_copy([1,1])
	translate([-(grid_size-wall_width)/2,0,tile_height-0.01])
		_scifi_floor_grate([wall_width,grid_size-2*wall_width]);
	
	mirror_copy([1,0])
	translate([-grid_size/2,grid_size/2,tile_height+0.01])
		rotate(270)
		_scifi_wall_corner_outer([grid_size/3, wall_width, 1.0]);
	
	mirror([0,1])
	translate([-grid_size/2,grid_size/2,tile_height+0.01])
		rotate(270)
		_scifi_wall_corner_outer([grid_size/3, wall_width, 1.0]);
}
