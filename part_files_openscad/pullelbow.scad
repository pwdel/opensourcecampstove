// https://www.menards.com/main/electrical/conduit-conduit-fittings-raceways/conduit-fittings/sigma-proconnex-trade-conduit-to-conduit-pull-elbow/46077m/p-1500273177717-c-9538.htm?tid=1594404088676465066&ipos=7

// Variables

inch = 25.4;
id = 0.72;
od = 0.93;
/* colors https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#color

cuts "Red"
metal "

 Libraries https://www.openscad.org/libraries.html
*/

// Base Parts
module outsideCylinder() {
    color("Gainsboro") cylinder(inch*1.5,inch/2*od,inch/2*od);
}

// Cuts
module centerCut() {
    translate([0,0,inch*-0.25]) {
        color("Red") cylinder(inch*3,inch/2*id,inch/2*id);
    }
}

// create halfinchPipe
module halfinchPipe() {
    difference() {
        outsideCylinder();
        union() {
            centerCut();
        }
        }
}

// Cut halfinchPipe
module cuthalfinchPipe() {
    translate([0,0,inch])
    rotate(-45,[1,0,0])
    translate([-inch, -inch, 0])
    linear_extrude(height = inch, center = false, convexity = 0, twist = 0, $fn = 0)
    color("Red") square([inch*2,inch*2]);
}

// singleArm
module singleArm() {
    difference() {
        halfinchPipe();
        union() {
            cuthalfinchPipe();
        }
    }
}


module elbowBottom() {
    translate([0,inch*.9,0])
    rotate(45,[1,0,0])
    singleArm();

    translate([0,-inch*.9,0])
    rotate(45,[1,0,0])
    rotate(180,[0,1,1])
    singleArm();
}

elbowBottom();

translate([0,0,18])
color("Gainsboro")
scale([.55,.92])
linear_extrude(height = inch*.15, center = false, convexity = 0, twist = 0, $fn = 100)
circle(r=inch*od);