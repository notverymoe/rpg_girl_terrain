# BF_COLLINEAR

Some operations with collinear faces creates
degenerate faces. These issue do not seem to
affect printability, so it was only fixed in
the core designs. The sample files containing
decorative elements would take more time than
it's worth.

Appears related to negative scales or mirror
operations. The current solutions just offsets
some surfaces or makes elements slightly thicker.

You can test a sample file using admesh. As a
helper you can run `./scripts/test_mesh.sh <scad file in src/>`
to use openscad to generate the stl and check
it with admesh. For example:
 `./scripts/test_mesh.sh sample/base/girl_baseplate_1.scad`

 If the output complains about degenerate faces,
 then this issue might be applicable.