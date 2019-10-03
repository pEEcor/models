

*preview();
print();

//------------------------------------ settings ------------------------------//
margin = 0.05;

// bracket
shaftDiameter = 1;          // shaft diameter
outerDiameter = 2.5;        // shaft holder outer diameter
shaftLength = 2.75;         // shaft holder length

// arm
armWidth = 1.5 - margin;                    // y
armHeight = 0.75 - margin;                  // z
armLength = armWidth + armHeight + 0.25;    // x
armDistance = 3;                            // distance of arms (end to end)

// connector cube
connectorEdge = armDistance - (2*armHeight) - (3*margin);
connector = [connectorEdge, connectorEdge, connectorEdge];

//--------------------------------- model previews ---------------------------//
module preview() {
    bracket();
    rotate([0, 0, -135]){
        connector();
        rotate([90, 0, 0]) bracket();
    }
}

module print() {
    translate([0, 0, 1]) rotate([0, -45, 0])
        translate([shaftLength + armLength - (armWidth/2), 0, 0]) bracket();
        
    translate([0, 4, 1]) rotate([0, -45, 0])
        translate([shaftLength + armLength - (armWidth/2), 0, 0]) bracket();
    translate([2, 7, 0]) rotate([0, -45, 0])
        translate([connector.x/2, connector.y/2, connector.z/2]) connector();
}

//------------------------------------ bracket -------------------------------//
module bracket() {
    // set origin into turing point of bracket
    translate([-shaftLength - armLength + (armWidth/2), 0, 0]) {
        difference() {
            // unite shaft and brackets
            union() {
                hull() {
                    // cylinder with shaft
                    rotate([0, 90, 0])
                        cylinder(d = outerDiameter, h = shaftLength, $fn = 60);
                    // arm base to form hull
                    translate([0, -(armWidth)/2, -armDistance/2]) {
                        for(z=[0, armDistance-armHeight]) {
                            translate([shaftLength-1, 0, z])
                                cube([1, armWidth, armHeight]);
                        }
                    }
                }
                // arms
                translate([0, -armWidth/2, -armDistance/2]) {
                    for(z=[0, armDistance-armHeight]) {
                        translate([shaftLength, 0, z]) arm();
                    }
                }
            }
            // shaft hole
            rotate([0, 90, 0])
                cylinder(d = shaftDiameter, h = shaftLength, $fn = 60);
        }
    }
}

module arm() {
    difference() {
        hull() {
            cube([armLength-armWidth, armWidth, armHeight]);
            translate([armLength-(armWidth/2), armWidth/2, 0])
                cylinder(d = armWidth, h = armHeight, $fn = 60);    
        }
        // hole
        translate([armLength-(armWidth/2), armWidth/2, 0])
            cylinder(d = 0.5 + 2*margin, h = armHeight, $fn = 60);
    }
}

//------------------------------------ connector -----------------------------//
module connector() {
    // set origin into center of cube
    translate([-connector.x/2, -connector.y/2, -connector.z/2]) {
        difference() {
            cube(connector);
            // holes
            translate([0, connectorEdge/2, connectorEdge/2]) rotate([0, 90, 0])
                cylinder(d = 0.5+(2*margin), h = connectorEdge, $fn = 60);
            translate([connectorEdge/2, 0, connectorEdge/2]) rotate([-90, 0, 0])
                cylinder(d = 0.5+(2*margin), h = connectorEdge, $fn = 60);
        }
    }

}
