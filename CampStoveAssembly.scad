module pullElbow() { 
    import("part_files_stl/pullelbow.stl");
}
// Document Info
// Units in mm

// Variables
cap_w = 8*25.4;
cap_h = 12*25.4;
cap_lip = 25.4;
cap_ga = .3175;
inch = 25.4;

/* colors https://en.wikibooks.org/wiki/OpenSCAD_User_Manual/The_OpenSCAD_Language#color

cuts "Red"
metal "

 Libraries https://www.openscad.org/libraries.html
*/

// ----------------------- Base Parts -----------------------
// Create the endCap module
module endCap() {
    {
    color("Gainsboro") cube([cap_w,cap_h,cap_ga]);
    color("Gainsboro") cube([cap_w,cap_ga,25.4]);
    translate([0,cap_h,0])
    color("Gainsboro") cube([cap_w,cap_ga,25.4]);
    color("Gainsboro") cube([cap_ga,cap_h,25.4]);
    translate([cap_w,0,0])
    color("Gainsboro") cube([cap_ga,cap_h,25.4]);
    }
}
// ----------------------- Cuts -----------------------
// Create frontsquarecutOut module
module frontsquarecutOut() {
    lipOffset = 3.5;
    translate([cap_lip*lipOffset/2,cap_lip*lipOffset/2,-cap_ga]){
        color("Red") cube([cap_w-cap_lip*lipOffset,cap_w-cap_lip*lipOffset,cap_ga*3]);
    }
}

// frontsquarecutOut();
// Create topcirclecutOut module
module topcirclecutOut() {
    translate([cap_w/2,cap_h*(2/3),-cap_ga]){
        color("Red") cylinder(cap_ga*3,inch*1.75,inch*1.75);
    }
}
// frontpartlegCut
module frontpartlegCut() {
    translate([-cap_w*.1,cap_w+cap_ga*2,-inch])
    color("Red") cube([cap_w*1.2,cap_h-cap_w,inch*3]);
}
// frontpartlegCut();

module backlegCut() {
    translate([-cap_w*.1,-cap_ga*2,-cap_ga*2])
    color("Red") cube([cap_w*1.2,cap_h-cap_w,inch*1.2]);
}

//
// ----------------------- Cut Parts -----------------------
//endcapfrontCut
module endcapfrontCut() {
    difference() {
        endCap();
        union() {
            frontsquarecutOut();
        }
    }
}

// endcapfrontlegCut
module endcaplegfrontCut() {
    difference() {
        endcapfrontCut();
        union() {
            frontpartlegCut();
        }
    }
}
// endcaptopCircle
module endcaptopCircle() {
    difference() {
        endCap();
        union() {
            topcirclecutOut();
        }
    }
}
//
// endcapbacklegCut
module endcapbacklegCut() {
    difference() {
        endCap();
        union() {
            backlegCut();
        }  
    }
}

// ----------------------- Place Parts -----------------------

//    endcaplegfrontCut();

module box_assembly() {
// Front frontsquarecutOut Area
rotate([-90,0,0]){
    translate([0,-cap_h,0]) {
    endcaplegfrontCut();
    }
}
// Top with cutout
rotate([0,180,0]){
    translate([-cap_w,0,-cap_h]){
    endcaptopCircle();}}
// Bottom
rotate([0,180,0]){
    translate([0,0,-cap_h+cap_w]){
        rotate([0,180,0]){
    endCap();}}}
// Back End
rotate(90,[1,0,0]){
    translate([0,0,-cap_h]){
    endcapbacklegCut();}}
// Right Side
rotate(90,[0,1,0]){
    translate([-cap_h,0,0])
    endCap();}
// Left Side
rotate(-90,[0,1,0]){
    translate([cap_w/2,0,-cap_w])
    endCap();
}}


// Put Assembly
box_assembly();

color("Gainsboro")
rotate(90,[0,0,1])
translate([cap_h*0.9,-cap_w/2,cap_h-cap_w-cap_lip])
    pullElbow();

color("Gainsboro")
rotate(90,[0,0,1])
translate([cap_h*0.1,-cap_w/2,cap_h-cap_w-cap_lip])
    pullElbow();