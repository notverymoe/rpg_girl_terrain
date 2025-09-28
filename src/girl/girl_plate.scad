// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_lock.scad>;

girl_plate_map([[1,1,1],[1,1,1],[1,1,1]]);

module girl_plate_map(map, brim=0.2) {

	for(y = [0:len(map)-1]) {
		for(x = [0:len(map[y])-1]) {
			translate([x*plate_size, y*plate_size])
			if (map[y][x]) {
				girl_plate_single(
					x_p = map[y][x+1] != 1,
					y_p = map[y+1][x] != 1,
					x_n = map[y][x-1] != 1,
					y_n = map[y-1][x] != 1,
					brim  = brim
				);
			}
		}
	}

	if (len(map) > 1 && len(map[0]) > 1) {

		for(y = [1:len(map)-1]) {
			for(x = [1:len(map[y])-1]) {
				
				solid_pxpy = map[y  ][x  ];
				solid_pxny = map[y-1][x  ];
				solid_nxpy = map[y  ][x-1];
				solid_nxny = map[y-1][x-1];

				connect = (( solid_pxpy &&  solid_nxny) && (!solid_pxny || !solid_nxpy)) 
					   || ((!solid_pxpy || !solid_nxny) && ( solid_pxny &&  solid_nxpy));
				
				if (connect) {
					translate([(x-0.5)*plate_size, (y-0.5)*plate_size])
					linear_extrude(plate_height) 
					difference() {
						square(plate_frame_width*2, center=true);

						round_amount = (solid_pxpy + solid_pxny + solid_nxpy + solid_nxny) > 2 ? 0 : plate_frame_width;

						if (!solid_pxpy) round(round_amount) square(plate_size);
						if (!solid_nxpy) round(round_amount) rotate( 90) square(plate_size);
						if (!solid_nxny) round(round_amount) rotate(180) square(plate_size);
						if (!solid_pxny) round(round_amount) rotate(270) square(plate_size);
					}
				}
			}
		}
	}

}

module girl_plate_single(
	x_p = true,
	y_p = true,
	x_n = true,
	y_n = true,

	brim = 0
) {
	difference() {
		union() {
			translate([0,0,plate_height-fdm_layer_height]) 
			_girl_plate_frame_chamfer(
				hole_magnet = true,
				x_p = x_p,
				x_n = x_n,
				y_p = y_p,
				y_n = y_n,
			);

			translate([0,0,fdm_layer_height]) 
			mirror([0,0,1]) 
			_girl_plate_frame_chamfer(
				hole_magnet = false,
				x_p = x_p,
				x_n = x_n,
				y_p = y_p,
				y_n = y_n,
			);

			_girl_frame_outer(
				base_adj=fdm_layer_height,
				top_adj =fdm_layer_height,
				x_p = x_p,
				x_n = x_n,
				y_p = y_p,
				y_n = y_n,
			);

			_girl_frame_inner(
				base_adj=fdm_layer_height,
				top_adj =fdm_layer_height,
			);

			translate([0,0,plate_height]) 
			_girl_plate_tile_key(plate_key_width);

			linear_extrude(brim) 
			if (brim > 0) {
				if (x_p && y_p) translate([  plate_size/2,  plate_size/2]) circle(d=12);
				if (x_n && y_p) translate([ -plate_size/2,  plate_size/2]) circle(d=12);
				if (x_n && y_n) translate([ -plate_size/2, -plate_size/2]) circle(d=12);
				if (x_p && y_n) translate([  plate_size/2, -plate_size/2]) circle(d=12);
			}
		}
		_girl_plate_tile_key(plate_key_width, plate_key_width_tol, plate_key_profile_tol);
	}
}

module _girl_plate_frame_chamfer(
	hole_magnet = false,
	x_p = true,
	y_p = true,
	x_n = true,
	y_n = true,
) {
	intersection() {
		roof(convexity=2) {
			_girl_frame_profile_inner(hole_magnet = hole_magnet);

			if (!x_p) {
				translate([ plate_size/2,0]) square(plate_lattice_width, center=true);
				if (y_p) translate([plate_size/2-plate_frame_width/2,  plate_size/2-plate_frame_width/2]) square([2*plate_frame_width,plate_frame_width], center=true);
				if (y_n) translate([plate_size/2-plate_frame_width/2, -plate_size/2+plate_frame_width/2]) square([2*plate_frame_width,plate_frame_width], center=true);
			}

			if (!x_n) {
				translate([-plate_size/2,0]) square(plate_lattice_width, center=true);
				if (y_p) translate([-plate_size/2+plate_frame_width/2,  plate_size/2-plate_frame_width/2]) square([2*plate_frame_width,plate_frame_width], center=true);
				if (y_n) translate([-plate_size/2+plate_frame_width/2, -plate_size/2+plate_frame_width/2]) square([2*plate_frame_width,plate_frame_width], center=true);
			}

			if (!y_p) {
				translate([0, plate_size/2]) square(plate_lattice_width, center=true);
				if (x_p) translate([ plate_size/2-plate_frame_width/2, plate_size/2-plate_frame_width/2]) square([plate_frame_width,2*plate_frame_width], center=true);
				if (x_n) translate([-plate_size/2+plate_frame_width/2, plate_size/2-plate_frame_width/2]) square([plate_frame_width,2*plate_frame_width], center=true);
			}

			if (!y_n) {
				translate([0,-plate_size/2]) square(plate_lattice_width, center=true);
				if (x_p) translate([ plate_size/2-plate_frame_width/2, -plate_size/2+plate_frame_width/2]) square([plate_frame_width,2*plate_frame_width], center=true);
				if (x_n) translate([-plate_size/2+plate_frame_width/2, -plate_size/2+plate_frame_width/2]) square([plate_frame_width,2*plate_frame_width], center=true);
			}
			
			_girl_frame_profile_outer(
				hole_slots  = false,
				x_p = x_p,
				x_n = x_n,
				y_p = y_p,
				y_n = y_n,
			);
		}
		linear_extrude(fdm_layer_height) 
		square([plate_size, plate_size], center=true);
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


module _girl_frame_inner(
	base_adj = 0,
	top_adj  = 0,
) {
	base_magnet = plate_height-plate_magnet_height;

	translate([0,0,base_adj]) 
	linear_extrude(base_magnet-base_adj)
	_girl_frame_profile_inner(hole_magnet = false);

	translate([0,0,base_magnet]) 
	linear_extrude(plate_magnet_height-top_adj)
	_girl_frame_profile_inner(hole_magnet = true);
}


module _girl_frame_outer(
	base_adj = 0,
	top_adj  = 0,
	x_p = true,
	y_p = true,
	x_n = true,
	y_n = true,
) {
	
	base_lock = (plate_height-plate_lock_height)/2;

	translate([0,0,base_adj]) 
	linear_extrude(base_lock-base_adj)
	_girl_frame_profile_outer(
		hole_slots = false,
		x_p = x_p,
		x_n = x_n,
		y_p = y_p,
		y_n = y_n,
	);

	translate([0,0,base_lock]) 
	linear_extrude(plate_lock_height)
	_girl_frame_profile_outer(
		hole_slots = true,
		x_p = x_p,
		x_n = x_n,
		y_p = y_p,
		y_n = y_n,
	);

	translate([0,0,base_lock+plate_lock_height]) 
	linear_extrude(base_lock-top_adj)
	_girl_frame_profile_outer(
		hole_slots = false,
		x_p = x_p,
		x_n = x_n,
		y_p = y_p,
		y_n = y_n,
	);
}

module _girl_frame_profile_outer(
	hole_slots = true,

	x_p = true,
	y_p = true,
	x_n = true,
	y_n = true,
) {
	if (y_p) _girl_frame_profile_side_slots(hole_slots);
	if (x_n) rotate( 90) _girl_frame_profile_side_slots(hole_slots);
	if (y_n) rotate(180) _girl_frame_profile_side_slots(hole_slots);
	if (x_p) rotate(270) _girl_frame_profile_side_slots(hole_slots);

	_girl_frame_profile_side_corner(x_p, y_p);
	rotate( 90) _girl_frame_profile_side_corner(x_n, y_p);
	rotate(180) _girl_frame_profile_side_corner(x_n, y_n);
	rotate(270) _girl_frame_profile_side_corner(x_p, y_n);

}

module _girl_frame_profile_side_corner(
	a,
	b,
) {
	if (a && b) {
		_girl_frame_profile_side_corner_rnd();
	} else if (a || b) {
		_girl_frame_profile_side_corner_sqr();
	}
}

module _girl_frame_profile_side_corner_rnd() {
	translate([plate_size/2-plate_frame_width,plate_size/2-plate_frame_width]) 
	intersection() {
		circle(r=plate_frame_width, $fn=32);
		square(plate_frame_width);
	}
}

module _girl_frame_profile_side_corner_sqr() {
	translate([plate_size/2-plate_frame_width,plate_size/2-plate_frame_width]) 
	square(plate_frame_width);
}

module _girl_frame_profile_side_slots(slot_hole=true) {
	translate([0,plate_size/2-plate_frame_width/2]) 
	difference() {
		square([plate_size-2*plate_frame_width, plate_frame_width], center=true);
		if (slot_hole) {
			translate([ plate_size/4,plate_lock_depth/2]) girl_slot_profile();
			translate([-plate_size/4,plate_lock_depth/2]) girl_slot_profile();
		}
	}
}

module _girl_frame_profile_inner(hole_magnet=true) {

	intersection() {
		offset( fdm_ideal_wall/2, $fn=16)
		offset(-fdm_ideal_wall/2) 
		{
			_girl_frame_profile_magnet(hole=hole_magnet);
			_girl_plate_profile_lattice(fdm_ideal_wall);
		}

		square(plate_size, center=true);
	}
}

module _girl_plate_profile_lattice(size_adj=0) {
	difference() {
		union() {
			square([plate_lattice_width, plate_size+size_adj], center=true);
			square([plate_size+size_adj, plate_lattice_width], center=true);
		}

		offset(-0.01) // Ensure connectivity
		_girl_frame_profile_magnet_solid();
	}
}

module _girl_frame_profile_magnet(hole=false) {
	if (hole) {
		_girl_frame_profile_magnet_hole();
	} else {
		_girl_frame_profile_magnet_solid();
	}
}

module _girl_frame_profile_magnet_hole() {
	difference() {
		// Magnet Frame
		_girl_frame_profile_magnet_solid();
	
		// Magnet Hole
		circle(d=plate_magnet_dia, $fn=64);

		// Removal Hole
		radius = (plate_magnet_dia+4*fdm_ideal_wall)/2;
		y      = plate_lattice_width/2;
		angle  = asin(y/radius);
		x      = radius*cos(angle);
		diag   = sqrt(pow(x-y, 2)*2); // Simplified
		diag_l = min(plate_magnet_dia*0.8, diag); // Ensure holder can exist
		rotate(45) square([2*radius, diag_l], center=true);
	}

}

module _girl_frame_profile_magnet_solid() {
	circle(d=plate_magnet_dia+4*fdm_ideal_wall, $fn=64);
}