// Copyright 2025 Natalie Baker // Apache v2 //

base_size  = 32;
wall_width =  9;

magnet_dia    = 6.2;
magnet_height = 2.8;

lock_height   = 1.9;
lock_depth    = 4.9;
lock_width    = 11;

lock_hole_dia = 2.25;

grid_size   = base_size + 2*wall_width;
grid_diag   = sqrt(2*grid_size*grid_size);
grid_height = max(lock_height, magnet_height)+1.2;

frame_size = 2.4;

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
