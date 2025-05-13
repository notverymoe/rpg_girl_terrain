// Copyright 2025 Natalie Baker // Apache v2 //

include<_girl_sample_config.scad>;
include<../../girl/girl_common.scad>;
use<../../girl/girl_lock.scad>;


repeat([lock_width+2, 1, 1], 4, 1, 1, center = true)
girl_lock(false);

linear_extrude(cfg_brim_height) 
square([lock_width*4+2*3, lock_shoulder+1], center=true);