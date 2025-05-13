// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_floor_grate_parts.scad>;
use<_scifi_wall_pipes_parts.scad>;

scifi_grate_wall_door();

module scifi_grate_wall_door() {
	girl_tile();

	translate([wall_width/2,0,tile_height-0.01])
		_scifi_floor_grate([grid_size-wall_width,grid_size]);
	
	translate([-(grid_size-wall_width)/2,0,tile_height-0.01])
		_scifi_floor_grate([wall_width,grid_size-2*wall_width]);

	mirror_copy([0,1])
	translate([-grid_size/2+wall_width,grid_size/2,tile_height+0.01])
		rotate(180)
		_scifi_wall_corner_door([grid_size/3, wall_width, 1.0]);
}
