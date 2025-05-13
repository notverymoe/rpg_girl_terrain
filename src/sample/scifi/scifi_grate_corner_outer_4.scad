// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_grate_gen.scad>;

girl_tile();

translate([-grid_size/2,-grid_size/2,tile_height-0.01])
_scifi_grate_gen(
	2, 2, 2, 
	2,    2, 
	2, 2, 2,
	[1,1,1,1]
);
