// Pendelnde Vorderachse
//
// suspensionMount()
// steeringLink(length)
// top(length)
// bottom(length)
// steeringArm(left:bool)
//


*allSetup();
print();
*suspensionMount();
//------------------------------------ all items -----------------------------//

module all() {
    length = 17;
    suspensionMount();
    translate([0, 10, 0]) steeringLink();
    translate([0, 20, 0]) top();
    translate([0, 30, 0]) bottom();
    translate([0, 40, 0]) steeringArm(true);
    translate([0, 50, 0]) steeringArm(false);
}

module allSetup() {
    length = 18;
    translate([-5, -2.5, 0]) suspensionMount();
    translate([-length/2, 0, 2]) bottom(length);
    translate([-length/2, 0, 6]) rotate([180, 0, 0]) top(length);
    translate([(length-2)/2, 0, 6-margin]) rotate([0, 180, 0]) steeringArm(true);
    translate([-(length-2)/2, 0, 6-margin]) rotate([0, 180, 0]) steeringArm(false);
    translate([-(length-2)/2, -5.75, 3-(2*margin)]) steeringLink(length);
}

module print() {
    length = 18.5;
    rotate([0, -45, 0])suspensionMount();
    rotate([0, -45, 0]) translate([0, 8, 0]) steeringLink(length);
    rotate([0, -45, 0]) translate([0, 12.5, 0]) top(length);
    rotate([0, -45, 0]) translate([0, 18, 0]) bottom(length);
    translate([-8, 15, 0]) rotate([45, -45, 0]) translate([1.5, 1, -1]) rotate([0, 0, 90]) steeringArm(true);
    translate([-8, 10, 0]) rotate([45, -45, 0]) translate([1.5, 1, -1]) rotate([0, 0, 90]) steeringArm(false);
}

//------------------------------------ settings ------------------------------//
margin = 0.05;

//------------------------------------ Suspension ----------------------------//

module suspensionMount() {
    // size of mounting plate
    plate = [10, 5, 1];

    // mounting plate
    cube(plate);
    for (y = [0, 4+margin]) {
        translate([2.5, y, 1]) bracket();
    }
}

module bracket() {
    // size of suspension brackets
    bracketX = 5;
    bracketY = 1-margin;
    bracketZ = 5;
    difference() {
        cube([bracketX, bracketY, bracketZ]);
        // holes:
        translate([bracketX/2, 0, 3])
            rotate([-90, 0, 0])
                cylinder(d = 1+margin, h = 1-margin, $fn = 60);
    }
}

//------------------------------- Steering Link ------------------------------//

module steeringLink(length = 18.5) {
    steeringArmInfluence = 2;
    steeringLinkLength = length-steeringArmInfluence;
    holeDistance = steeringLinkLength-2;

    // steering link
    difference() {
        hull() {
            translate([1, 0, 0]) {
                for(x=[0, holeDistance]) {
                    translate([x, 0, 0]) cylinder(d = 2, h = 1, $fn = 60);
                }
            }
        }
        // holes
        translate([1, 0, 0]) {
            for(x=[0, holeDistance]){
                translate([x, 0, 0]) cylinder(d = 1+margin, h = 1, $fn = 60);
            }
        }
    }
    // stick
    translate([(steeringLinkLength/2), 0, 1]) cylinder(d = 1-margin, h = 3, $fn = 60);
}

//------------------------------- top  ---------------------------------------//

module top(length = 18.5) {
    holeDistance = length-2;
    base = [10, 3, 1];
    
    // base with holes
    difference() {
        hull() {
            translate([1, 0, 0]) {
                for(x=[0, holeDistance]) {
                    translate([x, 0, 0]) cylinder(d = 2, h = 1, $fn = 60);
                }
            }
            translate([(length-base.x)/2, -1.5, 0]) cube(base);
        }
        // subtract:
        translate([1, 0, 0]) {
            for(x=[0, holeDistance]){
                translate([x, 0, 0]) cylinder(d = 1+margin, h = 1, $fn = 60);
            }
        }
    }
    // side panels
    difference() {
        // panels
        for(y=[0, 2]) {
            translate([(length-base.x)/2, y-1.5, 1]) cube(size=[10, 1, 3], center=false);
        }
        // holes
        for(y=[0, 2]) {
            translate([length/2, y-1.5, 2]) rotate([-90, 0, 0]) cylinder(d = 1+margin, h = 1, $fn = 60);
        }
    }
}

//------------------------------- Bottom -------------------------------------//

module bottom(length = 18.5) {
    base = [10, 3, 1];
    holeDistance = length-2;

    // base with holes
    difference() {
        difference() {
            // base
            hull() {
                translate([1, 0, 0]) {
                    for(x=[0, holeDistance]) {
                        translate([x, 0, 0]) cylinder(d = 2, h = 1, $fn = 60);
                    }
                }
                translate([(length-base.x)/2, -1.5, 0]) cube(base);
            }
            // holes:
            translate([1, 0, 0]) {
                for(x=[0, holeDistance]){
                    translate([x, 0, 0]) cylinder(d = 1+margin, h = 1, $fn = 60);
                }
            }
        }
        // ausschnitt
        for(y=[0, 2-margin]) {
            translate([(length-base.x)/2, y-1.5, 0]) cube([base.x, 1+margin, base.z]);
        }
    }
    difference() {
        // shaft which is slided into top
        width = 1-(2*margin);
        translate([(length-base.x)/2, -0.5+margin, 1]) cube([10, width, 2-margin]);
        // hole
        translate([length/2, -0.5+margin, 2]) rotate([-90, 0, 0]) cylinder(d = 1+margin, h = 1, $fn = 60);
    }
}

//------------------------------- lenker -------------------------------------//

module steeringArm(left = true) {
    height = 2 - (2 * margin);
    base = [2, 3, height];
    
    translate([-1, -1.5, 1]) {
        // base
        difference() {
            union() {
                // cube
                cube(base);
                //stick
                translate([1, 1.5, -1]) cylinder(d=1-margin, h = 4, $fn = 60);
            }
            translate([0, 1.5, 1]) rotate([0, 90, 0]) cylinder(d = 1+margin, h = 2, $fn = 60);
        }
        
        // connector
        hull() {
            if (left) {
                cube([1, 0.01, height]);
                translate([1, -3, 0]) cube([1, 0.01, 1]);
            } else {
                translate([1, 0, 0]) cube([1, 0.01, height]);
                translate([0, -3, 0]) cube([1, 0.01, 1]);
            }
        }
        // plate
        hull() {
            if (left) {
                // round plate
                translate([2, -4.25, 0]) cylinder(d = 2.5, h = 1, $fn = 60);
                // fake cube
                translate([1, -3, 0]) cube([1, 0.01, 1]);
            } else {
                translate([0, -4.25, 0]) cylinder(d = 2.5, h = 1, $fn = 60);
                // fake cube
                translate([0, -3, 0]) cube([1, 0.01, 1]);
            }
        }
        // stick
        if (left)
            translate([2, -4.25, 0]) cylinder(d=1-margin, h = 4, $fn = 60);
        else
            translate([0, -4.25, 0]) cylinder(d=1-margin, h = 4, $fn = 60);
    }



}