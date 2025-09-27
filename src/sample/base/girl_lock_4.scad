// Copyright 2025 Natalie Baker // Apache v2 //

include<_girl_sample_config.scad>;
include<../../girl/girl_common.scad>;
use<../../girl/girl_lock.scad>;

repeat([plate_lock_width+2, 1, 1], 4, 1, 1, center = true)
girl_lock(center=false, height_tol=0.1);

linear_extrude(cfg_brim_height) 
square([plate_lock_width*4+2*3, plate_lock_shoulder+1], center=true);