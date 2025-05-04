
include<../../girl/girl_common.scad>;
use<../../girl/girl_tile.scad>;

$fn=16;
	
color("red")
girl_tile();

scifi_tile_top(grid_size);

module scifi_tile_top(size) {
	
	w = is_num(size) ? size : size[0];
	h = is_num(size) ? size : size[1];

	linear_extrude(0.66) {
		difference() {
			square([w,h], center=true);
			
			repeat([3,3,1], (w)/3, (h)/3, 1, center=true)
				circle(d=1.5, $fn=6);
			
			repeat([3,3,1], (w)/3-1, (h)/3-1, 1, center=true)
				circle(d=1.5, $fn=6);
		}
	}

	resize([w,h,1.5])
	minkowski() {	
		linear_extrude(1)
		offset(-0.5)
		scifi_grate_frame([w,h], 2.5);
		
		rotate([45,45,45]) cube(0.5, center=true);
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