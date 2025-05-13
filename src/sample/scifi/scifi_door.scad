// Copyright 2025 Natalie Baker // Apache v2 //

include<../../girl/girl_common.scad>;

scifi_door();

module scifi_door(
	size = [
		grid_size - wall_width - 0.4, 
		50.0, 
		wall_width/3
	],
	wall_height=grid_size/3
) {
	
	mirror_copy([0,0,1])
	mirror_copy([1,0]) {
		_scifi_door_part(size);
		
		linear_extrude(size[2]/2)
			square([size[0]/2, wall_height-2]);
	}
	
	

}


module _scifi_door_part(
	size = [
		grid_size - wall_width - 0.4, 
		50.0, 
		wall_width/3
	]
) {
	
	passage_o = wall_width;
	passage_w = size[0] - 2*passage_o;
	passage_h = size[1];
	
	difference() {
		translate([0, passage_h,0])
		rotate([90,0,0])
		linear_extrude(passage_h)
		polygon([
			[0,0],
			[0,size[2]/2+1],
			[1,size[2]/2+1.2],
			[passage_w/2-1,size[2]/2+1.2],
			[passage_w/2,1],
			[passage_w/2,0],

		]);
		
		translate([0,0,(size[2]/2+1.2-0.5)])
		linear_extrude(0.6)
		translate([1.5, 1])
		offset( passage_w/10, $fn=1)
		offset(-passage_w/10, $fn=1)
			square([passage_w/2 - 3, passage_h - 2]);
	}

}

