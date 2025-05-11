// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;

girl_lock();

//color("blue")
//translate([0,0,-1]) 
//girl_slot();

module girl_lock(center=true) {
	$fn=24;
	linear_extrude(lock_height, center=center, convexity=2)
	mirror_copy([0,1])
	mirror_copy([1,0])
	_girl_lock_part();
}

module girl_slot(center=true) {
	$fn=24;
	linear_extrude(lock_height+0.2, center=center, convexity=2)
	mirror_copy([0,1])
	mirror_copy([1,0])
	_girl_slot_part();
}

module _girl_slot_part() {
	polygon([
		[           0,      0.00],
		[lock_width/2+0.30, 0.00],
		[lock_width/2+0.30, lock_shoulder+0.2],
		[lock_width/2-0.45, lock_shoulder+0.2],
		[lock_width/2-0.75, 2.80],
		[lock_width/2-0.55, lock_depth],
		[lock_width/2+0.50, lock_depth],
		[lock_width/2+0.50, 8.25],
		[lock_width/2-5.00, 8.25],
		[lock_width/2-4.70, 2.75],
		[lock_width/2-5.00, 2.30],
		[           0,      2.30],
	]);
}

module _girl_lock_part() {
	difference() {
		polygon([
			[           0,      0.00],
			[lock_width/2,      0.00],
			[lock_width/2,      lock_shoulder],
			[lock_width/2-0.95, lock_shoulder],
			[lock_width/2-0.60, lock_depth+0.1],
			[lock_width/2,      lock_depth+0.1],
			[lock_width/2-0.30, 6.20],
			[lock_width/2-2.15, 7.65],
			[lock_width/2-2.60, 7.90],
			[lock_width/2-3.00, 8.00],
			[lock_width/2-3.40, 7.90],
			[lock_width/2-3.60, 7.70],
			[lock_width/2-3.70, 7.45],
			[lock_width/2-3.25, 2.00],
			[           0,      2.00],
		]);
		polygon([
			[lock_width/2-2.10, 1.00],
			[lock_width/2-1.60, 5.50],
			[lock_width/2-2.50, 6.50],
			[lock_width/2-2.20, 1.00],
		]);
	}
}

module mirror_copy(m) {
	mirror(m) children();
	children();	
}