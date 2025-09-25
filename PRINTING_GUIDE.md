# Printing Guide

This guide is intended to help dial in print settings for the terrain system.

## FDM 

It's intended that you print the plates and risers using an FDM machine. The
pieces are designed for both 0.4mm and 0.6mm nozzles, by ensuring a minimal
wall thickness of 1.2mm. Most of the reccomended settings are the same, with
the exception of perimeter count and perimeter generator. Please note that
the 0.4mm settings are largely untested.

|        Setting       | 0.4mm Nozzles | 0.6mm Nozzles |
|----------------------|---------------|---------------|
| Initial Layer Height |         0.3mm |         0.3mm |
|         Layer Height |         0.3mm |         0.3mm |
|   Bottom Layer Count |             3 |             3 |
|      Top Layer Count |             3 |             3 |
|  Perimeter Generator |           Any |       Arachne |
|      Perimeter Count |             3 |             2 |
|          Infill Type |           Any |           Any |
|    Infill Percentage |        15-25% |        15-25% |

### Reference Machine

The "reference machine" used for developing this system is a
350mm Voron 2.4r2 with a 0.6mm nozzle. It's highly customized
with high power AB motors/driver, volcano ace hotend, orbitor
v2.5, pcb klicky probe, A4T toolhead & CANBus umbilical. It
has been tuned for skew correction, belt tension, klipper
input shaping and high speed+accel. Being a voron, it has a 
heated chamber hitting around 50°C (~120°F) and is printing
with ABS filament.

Files are sliced using development builds of SuperSlicer, a fork
of PrusaSlicer.

A lot of work has been put into this machine, but unfortunately
this means that the system might be more difficult to print on
lower spec machines - as they've not been explicitly tested.
Generally speaking the geometry is simple, and I expect it to
work - though perhaps at slower speeds or first-layer checks.

If you encounter issues with printing these parts on your machine
I would like to hear about them, so that I can fix it in later
revisions. In particular I expect the most issues will pop up with 
PETG.

### Troubleshooting

#### Plate - Sagging Interlocking Slots

Often times the interlocking slots on the sides of the plate can sag.
This can be caused by printing too hot, without enough cooling, with
wet filament, with untuned briding settings or it can be a property of
the particular brand/batch of filament.

Beyond tuning those paramaters, we can improve the generated output. In
prusaslicer-dervied slicers you can adjust the angle of bridging infill.
In Superslicer it's located at `Print Settings > Infill > Infill Angle > Bridging`.
It's reccomended that you set this to 45° and enable the "Rotate with
object" option. This will ensure that the bridges on each slot are done
at 45 degrees.

Without this setting or rotating the pieces, this will result in 2 of the
slot sets on opposite sides will have bridges running perpendicular to the
slot and the other two will run in parralel. The perpendicular bridges will 
be very short, not have much to anchor to and less time to cool. Whilst
the paralel ones will be extremely long and similarly be pone to drooping.

Setting the bridge angle to 45° will ensure that the slots are printed the
same on each side and allow for more reliable tuning. It also splits the
difference on briding lengths and gives more time for cooling. Rotate with
object will ensure that this angle is relative to the object, should you
decide to print with rotated objects.

#### Plate - Misformed Tile Key Bumps

The tile key bumps are rather small and can pose an issue with fast printers
or without sufficient cooling. The fix for this can involve reduing print
temperature, reduing print speed for perimiters or, and this is what I would
suggest, setting a minimium layer time >10s. This will allow you to print
the majority of the piece at maximium speed and slow down to ensure that each
layer of the key solidifies and isn't warped by printing the next layer on top
of it.
