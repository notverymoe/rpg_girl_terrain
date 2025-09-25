// Copyright 2025 Natalie Baker // Apache v2 //

include <girl_common.scad>
use <girl_plate.scad>

girl_riser();

module girl_riser(height = tile_wall_partial_height, add_support=true) {

    intersection() {
        union() {
            _girl_plate_edge_slots(270);
            _girl_plate_edge_slots(90);
            _girl_plate_edge_slots(0);
            _girl_plate_edge_slots(180);

            translate([0,0,plate_height]) 
            linear_extrude(height-plate_height, convexity=2)
            difference() {
                edge_thickness = plate_lock_depth + 0.2;
                square(plate_size,                  center=true);
                square(plate_size-2*edge_thickness, center=true);
            }

            difference() {
                union() {
                    translate([0,0,height]) 
                    _girl_plate_tile_key(plate_key_width);
                    
                    linear_extrude(height, convexity=3) {
                        circle(d=plate_magnet_dia+4*fdm_ideal_wall);
                        rotate_copy([0,0,90]) square([plate_size, plate_key_width + 2*plate_key_width_tol + 2*fdm_ideal_wall], center=true);
                    }
                }

                _girl_plate_tile_key(plate_key_width, plate_key_width_tol, plate_key_profile_tol);

                translate([0,0,-0.05])  {
                    cylinder(d=plate_magnet_dia, h=plate_magnet_height+0.05, $fn=32);

                    linear_extrude(plate_magnet_height+0.05) 
                    rotate(45) 
                    square([plate_magnet_dia/2, plate_magnet_dia+5*fdm_ideal_wall], center=true);
                }

                translate([0,0,height-plate_magnet_height+0.05]) {
                    cylinder(d=plate_magnet_dia, h=plate_magnet_height+0.05, $fn=32);

                    linear_extrude(plate_magnet_height+0.05) 
                    rotate(45) 
                    square([plate_magnet_dia/2, plate_magnet_dia+5*fdm_ideal_wall], center=true);
                }


            }
        }

		linear_extrude(height+20, convexity=2)
		offset( plate_lock_depth/2)
		offset(-plate_lock_depth/2)
		square([plate_size, plate_size], center=true);
    }

    if (add_support) {
        difference() {
        cylinder(d=plate_magnet_dia-2*fdm_ideal_wall, h=plate_magnet_height-fdm_layer_height, $fn=32);
        cylinder(d=plate_magnet_dia-3*fdm_ideal_wall, h=plate_magnet_height-fdm_layer_height, $fn=32);
        }
    }

}
