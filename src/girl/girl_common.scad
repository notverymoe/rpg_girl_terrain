// Copyright 2025 Natalie Baker // Apache v2 //

// // Settings // //

tile_tol   = 0.5; 
base_size  = 35;
wall_width = (50-(base_size+tile_tol))/2;

// // Magnets // //

magnet_dia    = 6.2;
magnet_height = 2.8;

// // Lock // //

lock_height   = 1.9;
lock_depth    = 4.9;
lock_shoulder = 2.0;
lock_width     = 11; 

// // Grid // //

grid_key_width = 1.8;

grid_tile_size =  base_size + 2*wall_width;
grid_tile_diag   = sqrt(2*grid_tile_size*grid_tile_size);

grid_base_size   = grid_tile_size + tile_tol;
grid_base_diag   = sqrt(2*grid_base_size*grid_base_size);
grid_base_height = max(lock_height, magnet_height)+1.2;

// // Tile // //

tile_height        = grid_base_height;
tile_top_thickness = tile_height-magnet_height;

// // Frame // //

frame_size = lock_depth;

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
