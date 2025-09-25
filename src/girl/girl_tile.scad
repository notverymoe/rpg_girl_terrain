// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_baseplate.scad>;

grid_key_width_tol   = 0.3;
grid_key_profile_tol = 0.4;

tile_base_wall = 3.0;

girl_tile();

module girl_tile(size = 1, solid = false) {
	x = is_num(size) ? size : size[0];
	y = is_num(size) ? size : size[1];

    infill_thickness = solid ? tile_base_thickness : tile_base_thickness/3;
    
    repeat([grid_tile_size, grid_tile_size, 1], x, y, 1, true) 
	translate([0,0,tile_base_thickness])
    rotate([180,0,0]) {
        // Tile Baseplate Key
        color("turquoise") 
        tile_grid_magnet_and_key();

        // Tile Base Walls
        color("turquoise") 
        linear_extrude(tile_base_thickness) 
        difference() {
            square(grid_tile_size, center=true);

            offset( tile_base_wall/2, $fn=32) 
            offset(-tile_base_wall/2, $fn=32)
            square(grid_tile_size-2*tile_base_wall, center=true);
        }

        // Tile Top
        color("aqua") 
        mirror([0,0,1])
        linear_extrude(tile_top_thickness) 
        square(grid_tile_size, center=true);

        // Infill
        color("darkred") 
        linear_extrude(infill_thickness) 
        difference() {
            square(grid_tile_size-tile_base_wall, center=true);

            offset( fdm_ideal_wall, $fn=32) 
            offset(-fdm_ideal_wall, $fn=32)
            tile_profile_magnet_and_key();
        }

    }
}

module tile_grid_magnet_and_key() {
    difference() {
        linear_extrude(magnet_height, convexity=2) 
        difference() {
            offset( fdm_ideal_wall, $fn=32) 
            offset(-fdm_ideal_wall, $fn=32)
            tile_profile_magnet_and_key();

            // Magnet
            rotate(45) 
            offset( magnet_dia/8, $fn=32) 
            offset(-magnet_dia/8, $fn=32)
            tile_profile_magnet_holder();
        }

        // Grid Key
        translate([0,0,magnet_height]) 
        mirror([0,0,1])
        _girl_baseplate_tile_key(grid_key_width, grid_key_width_tol, grid_key_profile_tol);
    }
}

module tile_profile_magnet_and_key() {
	// Magnet
	circle(d=magnet_dia+3*fdm_ideal_wall, $fn=32);

	// Grid Key
	for(i = [0 : 3])
	rotate(i*90)
	translate([grid_base_size/4, 0]) 
	square(
		[
			grid_key_length + 2.5*fdm_ideal_wall,
			grid_key_width  + 2.5*fdm_ideal_wall
		],
		center=true
	);
}


module tile_profile_magnet_holder() {
    circle(d=magnet_dia, $fn=32);
    square([magnet_dia/3*2, magnet_dia+5*fdm_ideal_wall], center=true);
}