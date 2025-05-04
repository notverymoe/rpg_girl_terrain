// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_grid.scad>;

girl_tile(2);

module girl_tile(x = 1, y= 1) {
	$fn=16;
	translate([0,0,-(magnet_height+0.7)]) {
		
		translate([0,0,magnet_height])
		linear_extrude(0.7) 
		offset( 0.1)
		offset(-0.1)
		square([grid_size*x,grid_size*y], center=true);
	  
		difference() {
			linear_extrude(magnet_height) 
			difference() {
				square([grid_size*x,grid_size*y], center=true);

				repeat([grid_size, grid_size, 1], x, y, 1, true) {
					circle(d=magnet_dia+0.2);
				}
			}
			
			repeat([grid_size, grid_size, 1], x, y, 1, true) {
				_girl_grid_key(frame_size/3*2, 0.2);
			}
		}
	}
}


//_girl_grid_key();