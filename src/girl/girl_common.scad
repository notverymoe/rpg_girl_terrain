// Copyright 2025 Natalie Baker // Apache v2 //

// // Settings // //

tile_tol        =  0.25; // Spacing between tile toppers
wall_width      =  8;    // The width of walls on a tile
miniature_scale = 32;    // The miniature scale of the system
miniature_scale_size = miniature_scale + 2 - tile_tol; // The flat space required for a miniature

// // Magnets // //

magnet_dia    = 6.2; // The magnet hole's diameter, including tolerances
magnet_height = 3.0; // The magnet hole's depth/height, including tolerances

// // Lock // //

lock_height   = 1.9; // The thickness of the locking tab
lock_depth    = 4.9; // The depth of the locking tab's tip, from the center of the tab
lock_shoulder = 2.0; // The depth of the locking tab's shoulder, from the center of the tab
lock_width    = 11;  // The full width of the locking tab slot, 

// // Grid // //

grid_key_width = 1.8; // The width of the locking key between the grid tile
					  // Note: The locking key uses the baseplate size not the 
					  //       tile size for spacing for legacy compat. Unlikely
					  //       to cause an issue, but something to be aware of in
					  //       development work.

grid_tile_size = miniature_scale_size + 2*wall_width;   // The xy size of a tile on a baseplate
grid_tile_diag = sqrt(2*grid_tile_size*grid_tile_size); // The size of the xy diagonal of a tile on a baseplate

grid_base_size   = grid_tile_size + tile_tol;             // The xy size of a baseplate cell for a tile
grid_base_diag   = sqrt(2*grid_base_size*grid_base_size); // The size of the xy diagonal of a baseplate cell for a tile
grid_base_height = max(lock_height, magnet_height)+1.2;   // The thickness of the baseplate

// // Tile // //

tile_height = max(         // The thickness of a tile
	grid_base_height- 0.5, // We expect most floor textures to raise the surface by ~0.5mm
	magnet_height   + 0.6  // We should ensure a thickness of at least 0.6mm above the magnet and in the pits
);
tile_base_thickness = magnet_height; 
tile_top_thickness  = tile_height-tile_base_thickness; // The thickness of the tile above the magnet

// // Frame // //

frame_size = lock_depth; // The depth of the outer frame

// // Util // //

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
