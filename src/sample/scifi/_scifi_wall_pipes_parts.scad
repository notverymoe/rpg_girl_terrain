// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

_scifi_wall_pipes();

module _scifi_wall_pipes(size = [grid_size, grid_size/3, wall_width], door_offset) {
	
	w = size[0];
	h = size[1];
	d = size[2];	
	
	_scifi_wall_pipes_end(d, h, 2);
	
	translate([0, 0, w-2]) 
		_scifi_wall_pipes_end(d, h, 2);

	linear_extrude(w) {
		_scifi_wall_pipes_back(d, h);
		_scifi_wall_pipes_slope(d);
		_scifi_wall_pipes_back(d, h);
		
		translate([d/3, d/2+1]) 
			_scifi_wall_pipes_part(d);
		
		translate([d/4, d/4*5.9]) 
			_scifi_wall_pipes_ledge(d);
	}
}

module _scifi_wall_pipes_ledge(d) {
	square([d/6, d/6]);
}

module _scifi_wall_pipes_slope(d) {
	difference() {
		square([d, d/2]);
		translate([d, d/2]) circle(d=d, $fn=32);
	}
}

module _scifi_wall_pipes_part(d) {
	
	repeat([1,d/4,1], 1, 4, 1) {
		translate([-d/8, -d/8]) square([d/8, d/4]);
		circle(d=d/4, $fn=16);
	}
	
}

module _scifi_wall_pipes_back(d, h) {
	square([d/4, h]);
}

module _scifi_wall_pipes_end(d, h, t) {
	linear_extrude(2) {
		polygon([[0, 0], [d, 0], [0, d]]);
		square([d/2, h]);
	}
}
