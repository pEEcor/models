# 3D model collection
3D model collection of miniature parts for 1:78 (H0) scale RC models created in
[openSCAD](https://www.openscad.org "openSCAD Homepage"). I do print these models
on an [Anycubic Photon](https://www.anycubic.com/collections/anycubic-photon-3d-printers/products/anycubic-photon-3d-printer "Homepage") thus the `margin` variable
in all source files is tweaked to yield good precision with this particular
printer. This variable defines the amount which is subtracted on various parts
such that all parts stick nicely together mechanically.

## Available models and tweaks
The listed variables underneath each model image can easily be tweaked inside the
respective models `.scad` file to your liking.

### Cardan
![alt text][cardan-image]
1. `shaftDiameter` shaft diameter
2. `outerDiameter` shaft holder outer diameter
3. `shaftLength` shaft holder length
### Suspension
![alt text][suspension-image]
1. `length` wheelbase


[cardan-image]: ./images/cardan-200x200.png "Cardan"
[suspension-image]: ./images/suspension-200x200.png "Suspension"
