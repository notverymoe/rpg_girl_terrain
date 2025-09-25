// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_lock.scad>;

girl_plate_map([[1,1,1],[1,1,1],[1,1,1]]);

module girl_plate_map(m, brim=0.2) {

	for(y = [0:len(m)-1]) {
		for(x = [0:len(m[y])-1]) {
			translate([x*plate_size, y*plate_size])
			if (m[y][x]) {
				girl_plate_single(
					m[y][x+1] != 1,
					m[y+1][x] != 1,
					m[y][x-1] != 1,
					m[y-1][x] != 1,
					brim
				);
			}
		}
	}

	if (len(m) > 1 && len(m[0]) > 1) {
		filler_w = plate_lattice_width*sqrt(2);
		filler_h = plate_lattice_width*sqrt(2);

		for(y = [1:len(m)-1]) {
			for(x = [1:len(m[y])-1]) {
				
				solid_pxpy = m[y  ][x  ] == 1;
				solid_pxny = m[y-1][x  ] == 1;
				solid_nxpy = m[y  ][x-1] == 1;
				solid_nxny = m[y-1][x-1] == 1;
				
				if ((solid_pxpy && solid_nxny) && (!solid_pxny || !solid_nxpy)) {
					translate([(x-0.5)*plate_size, (y-0.5)*plate_size])
					rotate([0,0,-45])
					linear_extrude(plate_height)
					square([filler_w, filler_h], center=true);
				}
				
				if ((!solid_pxpy || !solid_nxny) && (solid_pxny && solid_nxpy)) {
					translate([(x-0.5)*plate_size, (y-0.5)*plate_size])
					rotate([0,0,45])
					linear_extrude(plate_height)
					square([filler_w, filler_h], center=true);
				}
			}
		}
	}
	
}

module girl_plate_single(x_p = 1, y_p = 1, x_n = 1, y_n = 1, brim = 0) {
	$fn=24;
	intersection() {
		union() {
			difference() {
				_girl_plate_inner();
				if (x_p) _girl_plate_edge(270);
				if (x_n) _girl_plate_edge(90);
				if (y_p) _girl_plate_edge(0);
				if (y_n) _girl_plate_edge(180);
			}
			if (x_p) _girl_plate_edge_slots(270);
			if (x_n) _girl_plate_edge_slots(90);
			if (y_p) _girl_plate_edge_slots(0);
			if (y_n) _girl_plate_edge_slots(180);
		}
		
		x1 = x_n ? -plate_size/2 : -plate_size/2 - plate_lock_depth/2;
		x2 = x_p ?  plate_size/2 :  plate_size/2 + plate_lock_depth/2;
		y1 = y_n ? -plate_size/2 : -plate_size/2 - plate_lock_depth/2;
		y2 = y_p ?  plate_size/2 :  plate_size/2 + plate_lock_depth/2;
			
		linear_extrude(plate_height+100, convexity=2)
		offset( plate_lock_depth/2)
		offset(-plate_lock_depth/2)
		translate([x1, y1])
		square([x2-x1,y2-y1]);
	}
	
	if (brim > 0) {
		if (x_p && y_p)
			translate([plate_size/2,plate_size/2])
			_girl_plate_brim_ear(brim);
		
		if (x_n && y_p)
			translate([-plate_size/2,plate_size/2])
			rotate(90)
			_girl_plate_brim_ear(brim);
		
		if (x_n && y_n)
			translate([-plate_size/2,-plate_size/2])
			rotate(180)
			_girl_plate_brim_ear(brim);
		
		if (x_p && y_n)
			translate([plate_size/2,-plate_size/2])
			rotate(270)
			_girl_plate_brim_ear(brim);
	}
}

module _girl_plate_brim_ear(h, d = 16) {
	linear_extrude(h)
	difference() {
		union() {
			circle(d=d);
			polygon([
				[      0, -d*0.75+0.1],
				[   0.75, -d*0.75],
				[    d/2,       0],
				[      0,     d/2],
				[-d*0.75,    0.75],
				[-d*0.75+0.1,   0],
			]);
		}
		translate([-d/2-1,-d/2-1]) square(d/2);
	}
}

module _girl_plate_edge(a) {
	// [BF_COLLINEAR] HACK: Ideally this should be `plate_lock_depth`, but if we make it exact we get degenerate faces
	edge_thickness = plate_lock_depth + 0.2;

	rotate(a)
	translate([0,plate_size/2,0])
	difference() {
		translate([-plate_size/2, -edge_thickness, 0])
			cube([plate_size, edge_thickness, plate_height]);
		children();
	}
}

module _girl_plate_edge_slots(a) {
	_girl_plate_edge(a) {
		translate([-plate_size/4,0, plate_height/2]) girl_slot();
		translate([ plate_size/4,0, plate_height/2]) girl_slot();
	}
}

module _girl_plate_inner() {
	difference() {
		linear_extrude(plate_height) {
			
			repeat([plate_size, plate_size,1], 2, 2, 1, true) 
				_girl_plate_lattice(plate_size, plate_lattice_width, plate_magnet_dia/3*2);
			
			rotate_copy(90)
			mirror_copy([1,0])
			translate([plate_size/4, 0])
			resize([
				plate_key_length + 2*plate_key_profile_tol + 5*fdm_ideal_wall,
				plate_key_width  + 2*plate_key_width_tol   + 4*fdm_ideal_wall
			]) 
			circle(r=plate_key_length, $fn=32);
			
		}
		
		_girl_plate_magnet_slot();
		_girl_plate_tile_key(plate_key_width, plate_key_width_tol, plate_key_profile_tol);
	}

	translate([0,0,plate_height])
		_girl_plate_tile_key(plate_key_width);
}

module _girl_plate_magnet_slot(tolerance=0.15) {
	mad_d = plate_magnet_dia+2*tolerance;
	mag_h = plate_magnet_height+2*tolerance;

	translate([0,0,plate_height-plate_magnet_height]) 
	linear_extrude(mag_h) 
	offset(-1)
	offset( 1) {
		circle(d=mad_d);
		rotate( 45) square([mad_d/2, 20], center=true);
	}
}

module _girl_plate_lattice(size, wall, radius) {
	intersection() {
		offset(-radius)
		offset( radius)
		difference() {
			square(size*26, center=true);
			square(size-wall, center=true);
		}
		square(size, center=true);
	}
}

module _girl_plate_tile_key(wall, tolerance=0, profile_tolerance=-1) {
	rotate_copy(90)
	mirror_copy([1,0])
	translate([plate_size/4,0,0])
		_girl_plate_tile_key_single(wall, tolerance, profile_tolerance);
}

module _girl_plate_tile_key_single(wall, tolerance=0, profile_tolerance=-1) {
	profile_tolerance = profile_tolerance < 0 ? tolerance : profile_tolerance;
	
	rotate([90,0,0])
	translate([0,0,-wall/2-tolerance])
	linear_extrude(wall+2*tolerance)
	offset(profile_tolerance)
	polygon([
		[ 3.00, -0.25],
		[ 2.00,  1.00],
		[-2.00,  1.00],
		[-3.00, -0.25]
	]);
}
