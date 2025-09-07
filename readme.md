# The Girl Interlocking Terrain System

An open-source 32mm scale 3D printable interlocking modular terrain system written in OpenScad.

**Warning.** This is still in development & the main branch may in an untested state.

## About 

The system is designed for 32mm scale miniatures and places them on a 50mm grid, making room for 8mm walls on each side while still leaving a spacious 1mm gap for all those pieces that extend beyond their box or are tricking to grab placed up against a wall. The 32mm scale was selected due to its adoption amongst digital miniature artists for the stylized detail it allows and the compatibility with more traditional 24mm/25mm/1" miniatures either with or without rescaling - compared with the minimum wall width issues present in scaling down a 32mm piece.

It was created as an alternative to existing systems that contain either restrictive or unclear licensing terms, but fully aims to be a powerful system that stands on its own. You can find the licensing terms bellow, or in the (license)[license.md] file.

![Girl Terrain Tile](/media/tile_offset.jpg "Girl Terrain Tile")

# License 

Copyright 2025 Natalie Baker

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

### TL;DR

For those unfamiliar with the Apache v2.0 license, you can
find a (non-binding) layman explanation here:
https://www.tldrlegal.com/license/apache-license-2-0-apache-2-0

# Building from Source

On linux install OpenScad and run `./generate_all.sh`, all
output files should be in the "out/" directory.

Windows/MacOSX build scripts havent't been written, but you
can open files under `src/sample/` in OpenScad and manually
export them.

Eventually we will create releases containing all the basic
files.

# Usage

This system makes use of a few pieces:
- Base plates
- Tiles
- Lock Inserts
- 6x3mm Magnets 

The base plates and lock inserts are designed for FDM printing, they have been tested mostly in ABS. It's likely that they will both work in PLA but I would recommend a less stiff filament like ABS or PETG. Plus, they wouldn't melt when they're accidentally left in a car.

The tiles are intended for resin printing, however use a lot of material effectively being a larger block. It's recommended to orient them on-edge and then tilt them slight back so the underside receives the supports. As an less-costly alternative, they can be printed on an FDM 3D printer, to retain detail it's reccomneded to print them fully on-edge (see-bellow) however this may require supports on visible parts of the piece that will require post-processing.

### Magnets

The default setup makes use of 6mm diameter, 3mm thick, neodimium magnets. 
It's possible to this in the [Definition File](/src/girl/girl_common.scad) 
to fit the size of magnets you have, however I recommend visually inspecting
the output files and printing test pieces for fitment. Currently more work
is required to accommodate most larger diameter magnets however, and please
note that mixing magnet sizes is likely to result in an uneven play surface.

### Miniature Base

Also included is an optional miniature base. It's octogonal to support
facing, without sacrificing surface area as a square or hex base would,
and allows a magnet to be inserted. With thinner tiles, this magnet
should help keep in upright.

### SciFi Tile Set

Currently there's a WIP sci-fi themed tile set included. We'd love to
make more as this stabilizes.

![SciFi Tile Set Preview](/media/scifi_wip.png "A scifi tile set with grates and pipes in the wall")

## Future Goals 
- Better documentation & code cleanliness
- Small library of basic scifi, modern and fantasy tiles
- Support for 3D layouts

# Design

The system employs a separated tile-baseplate system. Tiles
are magnetically attached to baseplates of different sizes,
and baseplates are connected to eachother using a printed
locking insert allowing for the creation of complex layouts
and reuse of components. 

The purpose of the magnetically attached tiles is to allow a
dungeon master to swap the out easily, without hacing to pull
the map apart when players inevitably dig through a wall or
discover a hidden passage. Special care was taken in the design
of this mechanism, similar designs often make use 4 magnets. To
reduce cost, a single magnet is used and physical tabs prevent
the rotation of a tile. The locking mechanism is also integrated
into the underside of the baseplate, allowing them to be stacked
for storage.

![Locking Mechanism](/media/magnetic_lock.png "Locking Mechanism")

A secondary purpose of magnetically attacked tiles is to allow
for mixing printing methods. With this system it's intended that
the baseplated be printed with traditional FDM for strength and
the tiles be printed with resin to ensure maximal detail. The
tiles can of course be printed using FDM still and you can get
amazing results with a well tuned machine and printing the tile
on its edge (see example bellow of an early prototype).

![FDM Tile Printed on Edge](/media/z_terrain.jpg "FDM Tile Printed on Edge")

The baseplate interlocking mechanism makes use of a key-slot lock,
like most other systems of this type. It makes use of flexible teeth
that are squeezed into the slot and lock in place once they're pushed
through. Due to the corner smoothing of FDM the piece can also be
removed by pulling firmly. Care was put in to make this locking mechanism
thin, durable and printable with both 0.4mm nozzles and 0.6mm.

So far it has only been tested with ABS, but I expect PLA should function well.

![Locking Mechanism - Lock](/media/lock.png "Locking Mechanism - Lock")
![Locking Mechanism - Slot](/media/slot.png "Locking Mechanism - Slot")

Additionally as is common, the positions of the slots are space by half a tile exactly. Making it possible to place a tile inbetween two others to create an offsets.
![Girl Terrain build an with offset tile attached](/media/tile_offset.jpg "Girl Terrain Tile with an offset")

