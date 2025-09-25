// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

use<_scifi_floor_grate_parts.scad>;
use<_scifi_wall_pipes_parts.scad>;

_scifi_grate_gen(
	2, 3, 2, 
	2,    2, 
	4, 2, 4,
	[1,1,1,1]
);

module _scifi_grate_gen(
	c_nx_py = 0, py = 0, c_px_py = 0,
    nx      = 0,         px      = 0,
	c_nx_ny = 0, ny = 0, c_px_ny = 0,
	inner = [0,0,0,0]
) {
	_scifi_grate_gen_side(c_nx_ny, ny, c_px_ny);
	
	translate([tile_size,0,0])
	rotate(90)
	_scifi_grate_gen_side(c_px_ny, px, c_px_py);
	
	translate([tile_size,tile_size,0])
	rotate(180)
	_scifi_grate_gen_side(c_px_py, py, c_nx_py);
	
	translate([0,tile_size,0])
	rotate(270)
	_scifi_grate_gen_side(c_nx_py, nx, c_nx_ny);
	
	inner_w = tile_size-(inner[2]*tile_wall_width+inner[0]*tile_wall_width);
	inner_h = tile_size-(inner[3]*tile_wall_width+inner[1]*tile_wall_width);
	translate([inner[0]*tile_wall_width + inner_w/2, inner[1]*tile_wall_width + inner_h/2, 0])
	_scifi_floor_grate([inner_w, inner_h]);
}


module _scifi_grate_gen_side(
    corner_s = 0,
    mid      = 0,
    corner_e = 0,
) {
	off_s = corner_s == 0 ?         0 : tile_wall_width;
	off_e = corner_e == 0 ? tile_size : tile_size - tile_wall_width;

	if (corner_s == 1) {
		_scifi_wall_corner_inner([tile_size/3, tile_wall_width]);
	} else if (corner_s == 2) {
		_scifi_wall_corner_outer([tile_size/3, tile_wall_width]);
	} if (corner_s == 3) {
		// ignore
	} if (corner_s == 4) {
		// ignore
	} if (corner_s == 5) {
		translate([tile_wall_width/2,tile_wall_width/2,0])
		_scifi_floor_grate([tile_wall_width, tile_wall_width], 1.5);
	}
	
	if (mid == 1) {
		
		off_s = corner_s == 4 ?         0 : off_s;
		off_e = corner_e == 4 ? tile_size : off_e;
		
		translate([off_s,0,0])
		rotate([90,0,90])
		_scifi_wall_pipes([off_e-off_s, tile_size/3, tile_wall_width]);
		
	} else if (mid == 2) {
		
		translate([off_s,0,0])
		translate([(off_e-off_s)/2,tile_wall_width/2,0])
		_scifi_floor_grate([off_e-off_s,tile_wall_width], 1.5);
		
	} else if (mid == 3) {
		
		_scifi_wall_corner_door([tile_size/3, tile_wall_width]);
		
		translate([tile_size,0,0])
		mirror([1,0])
		_scifi_wall_corner_door([tile_size/3, tile_wall_width]);
		
		translate([tile_size/2,tile_wall_width/2,0])
		_scifi_floor_grate([off_e-off_s, tile_wall_width], 1.5);
	}
}