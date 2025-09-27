// Copyright 2025 Natalie Baker // Apache v2 //

include <girl_common.scad>
use <girl_plate.scad>

girl_riser();

module girl_riser(
    height = tile_wall_partial_height,
    add_support=true,
    brim=0
) {

    // // Outer // //

    // Outer - Base
    _girl_frame_outer();

    // Outer - Mid/Top
    translate([0,0,plate_height]) 
    linear_extrude(height-plate_height) 
    _girl_frame_profile_outer(hole_slots=false);

    // // Inner - Bottom // //

    // Walls
    difference() {
        // Flip for Magnet
        translate([0,0,plate_height]) 
        mirror([0,0,1]) 
        _girl_frame_inner();

        // Cut Key 
		_girl_plate_tile_key(plate_key_width, plate_key_width_tol, plate_key_profile_tol);
    }

    // Magnet Support
    if (add_support) {
        linear_extrude(plate_height-fdm_layer_height) 
        difference() {
            circle(d=plate_magnet_dia-2*fdm_ideal_wall, $fn=16);
            circle(d=plate_magnet_dia-3*fdm_ideal_wall, $fn=16);
        }
    }

    // // Inner - Middle // //

    translate([0,0,plate_height]) 
    linear_extrude(height-2*plate_height) 
    _girl_frame_profile_inner(hole_magnet=false);

    // // Inner - Top // //

    // Walls
    translate([0,0,height-plate_height]) 
    _girl_frame_inner();

    // Key
    translate([0,0,height]) 
    _girl_plate_tile_key(plate_key_width);

    // // Brim // //

    if (brim > 0) {
        linear_extrude(brim) {
            translate([  plate_size/2,  plate_size/2]) circle(d=12);
            translate([ -plate_size/2,  plate_size/2]) circle(d=12);
            translate([ -plate_size/2, -plate_size/2]) circle(d=12);
            translate([  plate_size/2, -plate_size/2]) circle(d=12);
        }
    }
}
