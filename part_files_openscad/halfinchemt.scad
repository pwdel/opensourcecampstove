// Variables
cap_w = 8*25.4;
cap_h = 12*25.4;
cap_lip = 25.4;
cap_ga = .3175;
pipe_ga = .2;
inch = 25.4;

// Raw Parts
module odCylinder() {
    color("Gainsboro")
    cylinder(h=6*inch,d=inch*.5);
}

// Cuts
module idCylinder() {
    color("Red")
    translate([0,0,-inch])
    cylinder(h=8*inch,d=inch*.5-inch*.5*pipe_ga);
}
// Cut Part
module halfinchEmt(); {
    difference() {
        odCylinder();
        union() {
            idCylinder();
        }
    }
}