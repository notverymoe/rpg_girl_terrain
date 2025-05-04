// Copyright 2025 Natalie Baker // Apache v2 //

use<../../girl/girl_lock.scad>;
include<../../girl/girl_common.scad>;

repeat([lock_width+2, 1, 1], 4, 1, 1, center = true)
girl_lock(false);

linear_extrude(0.25) 
square([lock_width*4+2*3, lock_shoulder+1], center=true);