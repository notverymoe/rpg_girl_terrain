// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_lock.scad>;

grid_grid_map([[1,1,1],[1,1,1],[1,1,1]]);

module grid_grid_map(m, brim=0.2) {
	
	// TODO interior corners

	for(y = [0:len(m)-1]) {
		for(x = [0:len(m[y])-1]) {
			translate([x*grid_size, y*grid_size])
			if (m[y][x]) {
				girl_grid_section(
					m[y][x+1] != 1,
					m[y+1][x] != 1,
					m[y][x-1] != 1,
					m[y-1][x] != 1,
					brim
				);
			}
		}
	}
	
	if (len(m) > 1 && len(m[y]) > 1) {
		for(y = [1:len(m)-1]) {
			for(x = [1:len(m[y])-1]) {
				
				solid_pxpy = m[y  ][x  ] == 1;
				solid_pxny = m[y-1][x  ] == 1;
				solid_nxpy = m[y  ][x-1] == 1;
				solid_nxny = m[y-1][x-1] == 1;
				
				if ((solid_pxpy && solid_nxny) && (!solid_pxny && !solid_nxpy)) {
					translate([(x-0.5)*grid_size, (y-0.5)*grid_size])
					rotate([0,0,-45])
					linear_extrude(grid_height)
					square([frame_size*2, lock_depth*2], center=true);
				}
				
				if ((!solid_pxpy && !solid_nxny) && (solid_pxny && solid_nxpy)) {
					translate([(x-0.5)*grid_size, (y-0.5)*grid_size])
					rotate([0,0,45])
					linear_extrude(grid_height)
					square([frame_size*2, lock_depth*2], center=true);
				}
			}
		}
	}
	
}

module girl_grid_section(x_p, y_p, x_n, y_n, brim) {
	$fn=24;
	intersection() {
		union() {
			difference() {
				_girl_grid_single();
				if (x_p) _girl_grid_slots_bar(270);
				if (x_n) _girl_grid_slots_bar(90);
				if (y_p) _girl_grid_slots_bar(0);
				if (y_n) _girl_grid_slots_bar(180);
			}
			if (x_p) _girl_grid_slots(270);
			if (x_n) _girl_grid_slots(90);
			if (y_p) _girl_grid_slots(0);
			if (y_n) _girl_grid_slots(180);
		}
		
		x1 = x_n ? -grid_size/2 : -grid_size/2 - lock_depth/2;
		x2 = x_p ?  grid_size/2 :  grid_size/2 + lock_depth/2;
		y1 = y_n ? -grid_size/2 : -grid_size/2 - lock_depth/2;
		y2 = y_p ?  grid_size/2 :  grid_size/2 + lock_depth/2;
			
		linear_extrude(grid_height+100, convexity=2)
		offset( lock_depth/2)
		offset(-lock_depth/2)
		translate([x1, y1])
		square([x2-x1,y2-y1]);
	}
	
	if (brim > 0) {
		if (x_p && y_p)
			translate([grid_size/2,grid_size/2])
			_girl_grid_brim_ear_corner(brim);
		
		if (x_n && y_p)
			translate([-grid_size/2,grid_size/2])
			rotate(90)
			_girl_grid_brim_ear_corner(brim);
		
		if (x_n && y_n)
			translate([-grid_size/2,-grid_size/2])
			rotate(180)
			_girl_grid_brim_ear_corner(brim);
		
		if (x_p && y_n)
			translate([grid_size/2,-grid_size/2])
			rotate(270)
			_girl_grid_brim_ear_corner(brim);
	}
}

module _girl_grid_brim_ear_corner(h, d = 16) {
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

module _girl_grid_slots_bar(a) {
	rotate(a)
	translate([0,grid_size/2,0])
	difference() {
		translate([-grid_size/2,-lock_depth,0])
			cube([grid_size, lock_depth, grid_height]);
		children();
	}
}

module _girl_grid_slots(a) {
	_girl_grid_slots_bar(a) {
		translate([-grid_size/4,0, grid_height/2]) girl_slot();
		translate([ grid_size/4,0, grid_height/2]) girl_slot();
	}
}

module _girl_grid_single() {
	difference() {
		linear_extrude(grid_height) {
			
			repeat([grid_size, grid_size,1], 2, 2, 1, true) 
				_girl_grid_lattice(grid_size, frame_size, magnet_dia/3*2);
			
			rotate_copy(90)
			mirror_copy([1,0])
			translate([grid_size/4, 0])
			resize([grid_size/4, lock_depth+1.5*grid_key_width]) 
			circle(r=grid_size, $fn=32);
			
		}
		
		_girl_grid_magnet_hole();
		_girl_grid_key(grid_key_width, 0.4, 0.8);
	}

	translate([0,0,grid_height])
		_girl_grid_key(grid_key_width);
}

module _girl_grid_magnet_hole(tolerance=0.15) {
	mad_d = magnet_dia+2*tolerance;
	mag_h = magnet_height+2*tolerance;
	
	translate([0,0,-tolerance])
		cylinder(d=3.2, h=grid_height-magnet_height+2*tolerance);
	
	translate([0,0,grid_height-magnet_height])
		cylinder(d=mad_d, h=mag_h);
}

module _girl_grid_lattice(size, wall, radius) {
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

module _girl_grid_key(wall, tolerance=0, profile_tolerance=-1) {
	rotate_copy(90)
	mirror_copy([1,0])
	translate([grid_size/4,0,0])
		_girl_grid_key_single(wall, tolerance, profile_tolerance);
}

module _girl_grid_key_single(wall, tolerance=0, profile_tolerance=-1) {
	profile_tolerance = profile_tolerance < 0 ? tolerance : profile_tolerance;
	
	rotate([90,0,0])
	translate([0,0,-wall/2-tolerance])
	linear_extrude(wall+2*tolerance)
	offset(profile_tolerance)
	polygon([
		[ 0.00,-0.25],
		[ 3.00,-0.25],
		[ 2.00, 1.00],
		[-2.00, 1.00],
		[-3.00,-0.25]
	]);
}
