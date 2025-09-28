// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;

mirror_copy([1,-1,0])
translate([plate_size/4-(plate_lock_depth+0.2),-plate_lock_depth,0]) {

girl_lock();

color("blue")
translate([0,0,-1]) 
girl_slot();

}

module girl_lock(center=true, height_tol=0) {
	$fn=24;
	linear_extrude(plate_lock_height-height_tol, center=center, convexity=2)
	mirror_copy([0,1])
	mirror_copy([1,0])
	_girl_lock_part();
}

module girl_slot(center=true) {
	$fn=24;
	linear_extrude(plate_lock_height+0.2, center=center, convexity=2)
	girl_slot_profile();
}


module girl_slot_profile() {
	union() {
		mirror_copy([0,1])
		mirror_copy([1,0])
		_girl_slot_part();

		// Ensure connectivity
		square([plate_lock_width+0.4, plate_lock_shoulder*2], center=true);
	}
}

module _girl_slot_part() {
	polygon([
		[                     0, 0.00],
		[plate_lock_width/2+0.2, 0.00],
		[plate_lock_width/2+0.2, plate_lock_shoulder+0.2],
		[plate_lock_width/2-0.7, plate_lock_shoulder+0.2],
		[plate_lock_width/2-1.0, plate_lock_shoulder+0.5],
		[plate_lock_width/2-1.0, plate_lock_depth       ],
		[plate_lock_width/2+0.2, plate_lock_depth       ],
		[plate_lock_width/2+0.2, plate_lock_depth   +3.3],
		[plate_lock_width/2-5.2, plate_lock_depth   +3.3],
		[plate_lock_width/2-5.2, plate_lock_shoulder+0.6],
		[plate_lock_width/2-5.8, plate_lock_shoulder+0.2],
		[                     0, plate_lock_shoulder+0.2],
	]);
}

module _girl_lock_part() {
	difference() {
		polygon([
			[                 0,                     0.00],
			[plate_lock_width/2,                     0.00],
			[plate_lock_width/2,     plate_lock_shoulder ],
			
			[plate_lock_width/2-0.8, plate_lock_shoulder ],
			[plate_lock_width/2-1.2, plate_lock_shoulder+0.4],
			
			[plate_lock_width/2-1.0, plate_lock_depth+0.1],
			[plate_lock_width/2,     plate_lock_depth+0.2],
			[plate_lock_width/2-0.8, plate_lock_depth+1.2],
			[plate_lock_width/2-2.6, plate_lock_depth+2.8],
			[plate_lock_width/2-3.1, plate_lock_depth+3.0],
			[plate_lock_width/2-3.9, plate_lock_depth+3.0],
			[plate_lock_width/2-4.1, plate_lock_depth+2.8],
			[plate_lock_width/2-4.2, plate_lock_depth+2.5],
			
			[plate_lock_width/2-3.8, plate_lock_shoulder+0.4],
			[plate_lock_width/2-4.2, plate_lock_shoulder ],
			
			[                     0, plate_lock_shoulder ],
		]);
		polygon([
			[plate_lock_width/2-1.7, plate_lock_shoulder/2],
			[plate_lock_width/2-2.3, plate_lock_shoulder],
			[plate_lock_width/2-2.1, plate_lock_depth+0.8],

			[plate_lock_width/2-3.1, plate_lock_depth+1.8],
			[plate_lock_width/2-2.7, plate_lock_shoulder],
			[plate_lock_width/2-3.2, plate_lock_shoulder/2],
		]);
	}
}

module mirror_copy(m) {
	mirror(m) children();
	children();	
}