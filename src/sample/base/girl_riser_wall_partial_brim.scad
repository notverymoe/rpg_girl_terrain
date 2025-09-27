// Copyright 2025 Natalie Baker // Apache v2 //

include<_girl_sample_config.scad>;
include<../../girl/girl_common.scad>;
use<../../girl/girl_riser.scad>;

girl_riser(
    height = tile_wall_partial_height,
    add_support=false,
    brim=cfg_brim_height,
);
