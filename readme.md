# Girl Terrain

This is Girl Terrain, a 32mm 3D printable opensource modular
terrain system written in OpenScad.

**First**, a warning, this is still in heavy development and
testing is ongoing. I would reccomend against printing out
100 pieces as this is not considered stable yet.

## About

This is designed as a 32mm scale system, with enough room
on each tile to have walls without encroaching on the mini's
base. The result is really big tile, 50mm (~2") on each side.

I created this because I didn't like the existing ecosystem
surrounding modular terrain systems. Many exert control over
your projects, require royalties or don't provide an actual
license text. I wanted something simple that was clear on
how it could be used and not limiting.

For those unfamiliar with the Apache v2.0 license, you can find a layman explanation here:
https://www.tldrlegal.com/license/apache-license-2-0-apache-2-0

## Building

On linux install OpenScad and run `./generate_all.sh`, all
output files should be in the "out/" directory.

Windows/MacOSX build scripts havent't been written, but you
can open files under `src/sample/` in OpenScad and manually
export them.

Eventually we will create releases containing all the basic
files.

## Design

The system employs a sperated tile-baseplate system. Tiles
are magnetically attached to baseplates of different sizes,
and baseplates are connected to eachother using a printed
locking insert allowing for the creation of complex layouts
and reuse of components. 

The purpose of the magnetically attached tiles is to allow a
dungeon master to swap the out easily, without hacing to pull
the map apart when players inevitabily dig through a wall or
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

## Magnet Selection

The default setup makes use of neodimium magnets nominally 6mm in
dia, 3mm tall. You can adjust this in the [Definition File](/src/girl/girl_common.scad) 
to fit the size of magnets you have. Currently more work is required
to accomodate most larger diameter magnets however, and please note
that mixing magnet sizes is likely to result in an uneven play surface.

## Misc

Also included is a miniture baseplate. It's hexagonal to allow for
facing without sacrificing surface area as a square base would. It
can also accept a magnet should you be playing in an environment
where your game table is often knocked. It might not work with the
tiles's magnet depending on the thickness of the tile's surface.

## Future Goals 
- Better documentation & code cleanliness
- Small library of basic scifi and fantasy tiles
- Support for 3D layouts with baseplate spacers

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

