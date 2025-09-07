// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_grate_gen.scad>;

girl_tile();

translate([-grid_tile_size/2,-grid_tile_size/2,tile_height-0.01])
_scifi_grate_gen(
	3, 3, 3, 
	1,    1, 
	0, 0, 0,
	[1,0,1,1]
);
