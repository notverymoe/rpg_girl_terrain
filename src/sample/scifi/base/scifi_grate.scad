
include<../../../girl/girl_common.scad>;
use<../../../girl/girl_tile.scad>;

//scifi_tile_full();
//scifi_tile_wall_side();
//scifi_tile_wall_hallway();
//scifi_tile_wall_corner();
scifi_tile_wall_deadend();


module scifi_tile_full() {
	girl_tile();

	translate([0,0,tile_height-0.01])
	scifi_tile_top(grid_size);
}

module scifi_tile_wall_side() {
	girl_tile();

	translate([wall_width/2,0,tile_height-0.01])
	scifi_tile_top([grid_size-wall_width,grid_size]);
	
	translate([-grid_size/2,grid_size/2,tile_height+1-0.01]) {
		rotate([90,0,0]) {
			scifi_tile_wall([grid_size, grid_size/3, wall_width]);
			
			translate([0,-1,0])
			linear_extrude(grid_size)
			square([wall_width,1]);
		}
	}
}

module scifi_tile_wall_hallway() {
	girl_tile();

	translate([0,0,tile_height-0.01])
	scifi_tile_top([grid_size-wall_width*2,grid_size]);
	
	mirror_copy([1,0])
	translate([-grid_size/2,grid_size/2,tile_height+1-0.01]) {
		rotate([90,0,0]) {
			scifi_tile_wall([grid_size, grid_size/3, wall_width]);
			
			translate([0,-1,0])
			linear_extrude(grid_size)
			square([wall_width,1]);
		}
	}
}

module scifi_tile_wall_corner() {
	girl_tile();

	translate([wall_width/2,-wall_width/2,tile_height-0.01])
	scifi_tile_top([grid_size-wall_width,grid_size-wall_width]);
	
	mirror_copy([1,1])
	translate([-grid_size/2,grid_size/2-wall_width,tile_height+1-0.01]) {
		rotate([90,0,0]) {
			scifi_tile_wall([grid_size-wall_width, grid_size/3, wall_width]);
			
			translate([0,-1,0])
			linear_extrude(grid_size-wall_width)
			square([wall_width,1]);
		}
	}
	
	translate([-grid_size/2,grid_size/2-wall_width,tile_height+0.01])
	cube([wall_width,wall_width,grid_size/3+1]);
}


module scifi_tile_wall_deadend() {
	girl_tile();

	translate([0,-wall_width/2,tile_height-0.01])
	scifi_tile_top([grid_size-wall_width*2,grid_size-wall_width]);
	
	mirror_copy([1,0])
	translate([-grid_size/2,grid_size/2-wall_width,tile_height+1-0.01]) {
		rotate([90,0,0]) {
			scifi_tile_wall([grid_size-wall_width, grid_size/3, wall_width]);
			
			translate([0,-1,0])
			linear_extrude(grid_size-wall_width)
			square([wall_width,1]);
		}
	}
	
	mirror([1,1])
	translate([-grid_size/2,grid_size/2-wall_width,tile_height+1-0.01]) {
		rotate([90,0,0]) {
			scifi_tile_wall([grid_size-wall_width*2, grid_size/3, wall_width]);
			
			translate([0,-1,0])
			linear_extrude(grid_size-wall_width)
			square([wall_width,1]);
		}
	}
	
	mirror_copy([1,0])
	translate([-grid_size/2,grid_size/2-wall_width,tile_height+0.01])
	cube([wall_width,wall_width,grid_size/3+1]);
}

module scifi_tile_wall(size = [grid_size, grid_size/3, wall_width]) {
	
	w = size[0];
	h = size[1];
	d = size[2];	
	
	linear_extrude(2) {
		polygon([[0, 0], [d, 0], [0, d]]);
		square([d/2, h]);
	}
	
	translate([0, 0, w-2]) 
	linear_extrude(2) {
		polygon([[0, 0], [d, 0], [0, d]]);
		square([d/2, h]);
	}

	linear_extrude(w) {
		difference() {
			square([d, d/2]);
			translate([d, d/2]) circle(d=d, $fn=32);
		}
		
		square([d/4, h]);
		
		translate([d/3, d/2+1]) 
		repeat([1,d/4,1], 1, 4, 1) {
			translate([-d/8, -d/8]) square([d/8, d/4]);
			circle(d=d/4, $fn=16);
		}
		
		translate([d/4, d/4*5.9]) 
		square([d/6, d/6]);
	}
}


module scifi_tile_top(size) {

	w = is_num(size) ? size : size[0];
	h = is_num(size) ? size : size[1];

	linear_extrude(0.5) {
		difference() {
			square([w,h], center=true);
			
			repeat([3,3,1], (w)/3, (h)/3, 1, center=true)
				circle(d=1.5, $fn=6);
			
			repeat([3,3,1], (w)/3-1, (h)/3-1, 1, center=true)
				circle(d=1.5, $fn=6);
		}
	}

	translate([0,0,0.5])
	intersection() {
		resize([w+0.2,h+0.2,0.75])
		minkowski() {	
			linear_extrude(1)
			offset(-0.5)
				scifi_grate_frame([w,h], 2.5);
			
			rotate([45,45,45])
				cube(0.5, center=true);
		}
		
		linear_extrude(0.75)
			square([w,h],center=true);
	}
}

module scifi_grate_frame(size, thickness) {
	w = is_num(size) ? size : size[0];
	h = is_num(size) ? size : size[1];
	
	difference() {
		square([w,h], center=true);
		square([w-2*thickness,h-2*thickness], center=true);
	}
	
	mirror_copy([1,0])
	mirror_copy([0,1])
	translate([(w - 2*thickness)/2,(h - 2*thickness)/2])
	rotate(45)
	square(sqrt(pow(2*thickness, 2)/2), center=true);
}