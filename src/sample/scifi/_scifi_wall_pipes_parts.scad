// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

_scifi_wall_corner_door();

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
		
		translate([d/3, d/2+1]) 
			_scifi_wall_pipes_part(d);
		
		translate([d/4, d/4*5.9]) 
			_scifi_wall_pipes_ledge(d);
	}
}

module _scifi_wall_corner_door(size = [grid_size/3, wall_width], door_thickness = wall_width/3+0.4) {

	h = size[0];
	d = size[1];	
	
	difference() {
		cube([d,d*2,h]);
		
		translate([0,d,0]) {
			translate([(d-door_thickness)/2,0,-0.05])
				cube([door_thickness, d+1, h+0.1]);
			
			translate([-0.1,d/4,-0.05])
				cube([1.1, d/2, h+0.1]);
			
			translate([d-1,d/4,-0.05])
				cube([1.1, d/2, h+0.1]);
		}
		
	}
	
	translate([1,d+ceil(d/2)/2,0])
	repeat([1,1,1], 1, ceil(d/2), 1) 
		cylinder(d=1,h=h,$fn=16);
	
	translate([d-1,d+ceil(d/2)/2,0])
	repeat([1,1,1], 1, ceil(d/2), 1) 
		cylinder(d=1,h=h,$fn=16);
}

module _scifi_wall_corner_inner(size = [grid_size/3, wall_width]) {
	
	h = size[0];
	d = size[1];	

	rotate([90,0,90]) {
		linear_extrude(d) {
			_scifi_wall_pipes_profile(d, h);
		}
		
		translate([d,0])
		rotate([0,-90,0])
		linear_extrude(d) {
			_scifi_wall_pipes_profile(d, h);
		}
	}
	
}

module _scifi_wall_corner_outer(size = [grid_size/3, wall_width]) {

	h = size[0];
	d = size[1];	

	rotate([90,0,90]) {
		intersection() {
			linear_extrude(d) {
				_scifi_wall_pipes_profile(d, h);
			}
			
			translate([d,0])
			rotate([0,-90,0])
			linear_extrude(d) {
				_scifi_wall_pipes_profile(d, h);
			}
		}
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
	linear_extrude(t) {
		_scifi_wall_pipes_profile(d, h);
	}
}

module _scifi_wall_pipes_profile(d, h) {
	polygon([[0, 0], [d, 0], [0, d]]);
	square([d/2, h]);
}
