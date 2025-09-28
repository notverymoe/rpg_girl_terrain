// Copyright 2025 Natalie Baker // Apache v2 //

include<girl_common.scad>;
use<girl_plate.scad>;

tile_base_wall = 3.0;

girl_tile();

module girl_tile(size = 1, solid = false) {
	x = is_num(size) ? size : size[0];
	y = is_num(size) ? size : size[1];

    infill_thickness = solid ? tile_thickness_base : tile_thickness_base/3;
    
    repeat([tile_size, tile_size, 1], x, y, 1, true) 
	translate([0,0,tile_thickness_base])
    rotate([180,0,0]) {
        // Tile Baseplate Key
        color("turquoise") 
        tile_grid_magnet_and_key();

        // Tile Base Walls
        color("turquoise") 
        linear_extrude(tile_thickness_base-fdm_layer_height) 
        difference() {
            square(tile_size, center=true);

            offset( tile_base_wall/2, $fn=32) 
            offset(-tile_base_wall/2, $fn=32)
            square(tile_size-2*tile_base_wall, center=true);
        }

        // Chamfer
        color("turquoise") 
        translate([0,0,tile_thickness_base-fdm_layer_height]) 
        intersection() {
            roof()
            difference() {
                square(tile_size, center=true);

                offset( tile_base_wall/2, $fn=32) 
                offset(-tile_base_wall/2, $fn=32)
                square(tile_size-2*tile_base_wall, center=true);
            }
            linear_extrude(fdm_layer_height) 
            square(tile_size, center=true);
        }

        // Tile Top
        color("aqua") 
        mirror([0,0,1])
        linear_extrude(tile_thickness_top) 
        square(tile_size, center=true);

        // Infill
        color("darkred") 
        linear_extrude(infill_thickness) 
        difference() {
            square(tile_size-tile_base_wall, center=true);

            offset( fdm_ideal_wall, $fn=32) 
            offset(-fdm_ideal_wall, $fn=32)
            tile_profile_magnet_and_key();
        }

    }
}

module tile_grid_magnet_and_key() {
    difference() {
        linear_extrude(plate_magnet_height, convexity=2) 
        difference() {
            offset( fdm_ideal_wall, $fn=32) 
            offset(-fdm_ideal_wall, $fn=32)
            tile_profile_magnet_and_key();

            // Magnet
            rotate(45) 
            offset( plate_magnet_dia/8, $fn=32) 
            offset(-plate_magnet_dia/8, $fn=32)
            tile_profile_magnet_holder();
        }

        // Grid Key
        translate([0,0,plate_magnet_height]) 
        mirror([0,0,1])
        _girl_plate_tile_key(plate_key_width, plate_key_width_tol, plate_key_profile_tol);
    }
}

module tile_profile_magnet_and_key() {
	// Magnet
	circle(d=plate_magnet_dia+3*fdm_ideal_wall, $fn=32);

	// Grid Key
	for(i = [0 : 3])
	rotate(i*90)
	translate([plate_size/4, 0]) 
	square(
		[
			plate_key_length + 2.5*fdm_ideal_wall,
			plate_key_width  + 2.5*fdm_ideal_wall
		],
		center=true
	);
}


module tile_profile_magnet_holder() {
    circle(d=plate_magnet_dia, $fn=32);
    square([plate_magnet_dia/3*2, plate_magnet_dia+5*fdm_ideal_wall], center=true);
}