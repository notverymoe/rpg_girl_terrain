// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_floor_grate_parts.scad>;
use<_scifi_wall_pipes_parts.scad>;

scifi_tile_full();

module scifi_tile_full() {
	girl_tile();

	translate([0,0,tile_height-0.01])
	    _scifi_floor_grate(grid_size);
}