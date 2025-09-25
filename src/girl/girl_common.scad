// Copyright 2025 Natalie Baker // Apache v2 //

// // Settings // //

scale_mm_per_m   = 38/1.7; // Units per Metre - Scientifically deterimed by looking at minatures

// Tile shared
tile_tol         =  0.25; // Spacing between tile toppers
tile_wall_width  =  8;    // The width of walls on a tile

// Miniatures
miniature_scale         = 32;    // The miniature scale of the system
miniature_scale_spacing = 2 - tile_tol; // The flat space required for a miniature

// Misc
fdm_layer_height = 0.3; // Used for rounding the height of things to the nearest layer
fdm_ideal_wall   = 1.2; // Used as a minimum where a wall of arbitrary thickness is required

// // Core // //
tile_size       = miniature_scale + miniature_scale_spacing + 2*tile_wall_width;   // The xy size of a tile on a baseplate
plate_size  = tile_size + tile_tol;  // The xy size of a baseplate cell for a tile

// // Baseplate // //

// Magnet
plate_magnet_dia    = 6.2; // The magnet hole's diameter, including tolerances
plate_magnet_height = 3.0; // The magnet hole's depth/height, including tolerances

// Lock
plate_lock_height   = 1.9; // The thickness of the locking tab
plate_lock_depth    = 4.9; // The depth of the locking tab's tip, from the center of the tab
plate_lock_shoulder = 2.0; // The depth of the locking tab's shoulder, from the center of the tab
plate_lock_width    = 11;  // The full width of the locking tab slot, 

// Key
plate_key_length = 6.0; // Length of the locking tab profile
plate_key_width  = 1.8; // The width of the locking key between the grid tile
					        // Note: The locking key uses the baseplate size not the 
					        //       tile size for spacing for legacy compat. Unlikely
					        //       to cause an issue, but something to be aware of in
					        //       development work.
plate_key_width_tol   = 0.2;
plate_key_profile_tol = 0.3;

// Frame
plate_lattice_width = plate_lock_depth; // The width of the baseplate's inner frame
plate_height        = ceil_to_fdm_layer(    // The thickness of the baseplate
	max(plate_lock_height, plate_magnet_height), 
	4
);

// // Tile // //

tile_thickness = max( // The thickness of a tile
	ceil_to_fdm_layer(plate_height, -3),
	ceil_to_fdm_layer(    plate_magnet_height, 3),
);
tile_thickness_base = plate_magnet_height; 
tile_thickness_top  = tile_thickness-tile_thickness_base; // The thickness of the tile above the 

tile_wall_partial_height =  ceil_to_plate_layer(0.8*scale_mm_per_m);

// // Util // //

// Rounds the given value to the next fdm layer height, with optional base offset and additional layers
function ceil_to_fdm_layer(value, add_layers = 0, base_offset = 0) = ceil((base_offset + value)/fdm_layer_height)*fdm_layer_height + add_layers*fdm_layer_height - base_offset;

function ceil_to_plate_layer(value, add_layers = 0, base_offset = 0) = ceil((base_offset + value)/plate_height)*plate_height + add_layers*plate_height - base_offset;

module mirror_copy(m) {
	mirror(m) children();
	children();	
}

module rotate_copy(a) {
	rotate(a) children();
	children();	
}

module repeat(size, x, y, z, center) {
	off = center 
		? [(x-1)*size[0],(y-1)*size[1],(z-1)*size[2]]/2 
		: [0,0,0];

	for(i = [0 : x-1])
	for(j = [0 : y-1])
	for(k = [0 : z-1])
		translate([
			size[0]*i-off[0],
			size[1]*j-off[1],
			size[2]*k-off[2]
		]) children();
}
