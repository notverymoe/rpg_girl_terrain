// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_lock.scad>;

grid_grid_map([[1]]);

module grid_grid_map(m) {

	for(y = [0:len(m)-1]) {
		for(x = [0:len(m[y])-1]) {
			translate([x*grid_size, y*grid_size])
			if (m[y][x]) {
				
				tile_px = m[y][x+1] == 1;
				tile_nx = m[y][x-1] == 1;
				tile_py = m[y+1][x] == 1;
				tile_ny = m[y-1][x] == 1;
				
				air_px = m[y][x+1] != 1;
				air_nx = m[y][x-1] != 1;
				air_py = m[y+1][x] != 1;
				air_ny = m[y-1][x] != 1;
				
				air_pxpy = m[y+1][x+1] != 1;
				air_pxny = m[y-1][x+1] != 1;
				air_nxpy = m[y+1][x-1] != 1;
				air_nxny = m[y-1][x-1] != 1;
				
				girl_grid_section(air_px, air_py, air_nx, air_ny);
				
				linear_extrude(grid_height)
				union() {
					if (tile_px && air_pxpy) {
						translate([grid_size/2, (grid_size-lock_depth)/2])
						square([lock_depth*2, lock_depth], center=true);
					}
						
					if (tile_px && air_pxny) {
						translate([grid_size/2, -(grid_size-lock_depth)/2])
						square([lock_depth*2, lock_depth], center=true);
					}
					
					// -- //
				
					if (tile_nx && air_nxpy) {
						translate([-grid_size/2, (grid_size-lock_depth)/2])
						square([lock_depth*2, lock_depth], center=true);
						
					}
						
					if (tile_nx && air_nxny) {
						translate([-grid_size/2, -(grid_size-lock_depth)/2])
						square([lock_depth*2, lock_depth], center=true);
					}
					
					// -- //
				
					if (tile_py && air_pxpy) {
						translate([(grid_size-lock_depth)/2, grid_size/2])
						square([lock_depth, lock_depth*2], center=true);
					}
				
					if (tile_py && air_nxpy) {
						translate([-(grid_size-lock_depth)/2, grid_size/2])
						square([lock_depth, lock_depth*2], center=true);
					}
					
					// -- //
					
					if (tile_ny && air_pxny) {
						translate([(grid_size-lock_depth)/2, -grid_size/2])
						square([lock_depth, lock_depth*2], center=true);
					}
						
					if (tile_ny && air_nxny) {
						translate([-(grid_size-lock_depth)/2, -grid_size/2])
						square([lock_depth, lock_depth*2], center=true);
					}
				}
			}
		}
	}
	
}

module girl_grid_section(x_p, y_p, x_n, y_n) {
	$fn=24;
	intersection() {
		union() {
			_girl_grid_single();
			
			if (x_p)
			rotate(270)
			translate([0,grid_size/2])
			_girl_grid_slots();
			
			if (x_n)
			rotate(90)
			translate([0,grid_size/2])
			_girl_grid_slots();
			
			if (y_p)
			translate([0,grid_size/2,0])
			_girl_grid_slots();
			
			if (y_n)
			rotate(180)
			translate([0,grid_size/2,0])
			_girl_grid_slots();
		}
			
		linear_extrude(grid_height+100, convexity=2)
		offset( lock_depth/2)
		offset(-lock_depth/2)
		square([grid_size,grid_size],center=true);
	}
}


module _girl_grid_slots() {

	difference() {
		translate([-grid_size/2,-lock_depth,0])
			cube([grid_size,lock_depth,grid_height]);

		translate([-grid_size/4,0,grid_height/2])
			girl_slot();

		translate([grid_size/4,0,grid_height/2])
			girl_slot();
	}
		
}

module _girl_grid_single() {
	union() {
		render()
		difference() {
			linear_extrude(grid_height)
			intersection() {
				repeat([grid_diag/2,grid_diag/2,1], 2, 2, 1, true)
					_girl_grid_lattice(grid_diag/2, frame_size, 6.0);
				square(grid_size, center=true);
			}
			
			_girl_grid_magnet_hole();
			_girl_grid_key(frame_size/3*2,  0.2);
		}
		
		translate([0,0,grid_height])
		_girl_grid_key(frame_size/3*2);
	}
}

module _girl_grid_magnet_hole(tolerance=0.15) {
	mad_d = magnet_dia+2*tolerance;
	mag_h = magnet_height+2*tolerance;
	
	translate([0,0,-tolerance])
	cylinder(d=4, h=grid_height-magnet_height+2*tolerance);
	
	translate([0,0,grid_height-magnet_height])
	cylinder(d=mad_d, h=mag_h);
}

module _girl_grid_lattice(size, wall, radius) {
	intersection() {
		offset(-radius)
		offset( radius)
		union() {
			difference() {
				square(size*26, center=true);
				square(size-wall, center=true);
			}
		}
		square(size, center=true);
	}
}

module _girl_grid_key(wall, tolerance=0) {
	translate([0,-grid_size/4,0])
	rotate([0,0,90])
	_girl_grid_key_single(wall, tolerance);

	translate([0,grid_size/4,0])
	rotate([0,0,90])
	_girl_grid_key_single(wall, tolerance);

	translate([-grid_size/4,0,0])
	_girl_grid_key_single(wall, tolerance);

	translate([grid_size/4,0,0])
	_girl_grid_key_single(wall, tolerance);
}

module _girl_grid_key_single(wall, tolerance=0) {
	rotate([90,0,0])
	translate([0,0,-wall/2-tolerance])
	linear_extrude(wall+2*tolerance)
	offset(tolerance)
	polygon([
		[ 0.00,-0.25],
		[ 3.00,-0.25],
		[ 2.00, 1.00],
		[ 0.00, 1.50],
		[-2.00, 1.00],
		[-3.00,-0.25]
	]);
}
