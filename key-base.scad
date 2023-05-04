
// Key interface for M-audio keystation 49e.

// Make the keys at least 70mm long, which is long enough to be a bit past all of the interface elements.

// prism taken from openscad user manual
module prismBorrowed(l, w, h){
      polyhedron(//pt 0        1        2        3        4        5
              points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
              faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
              );
      }
module tprism(l,w,h){
    rotate([0,0,90])prismBorrowed(l,w,h);
}


module keyNoCutout() {
    // key top, upside down
    cube([70,11,2]);

    // key sides, basic part
    translate([0,0,0])cube([70,2,10]);
    translate([0,9,0])cube([70,2,10]);

    // key well outside
    cube([10,11,10]);

    module raisedPart() {
        // raised part
        translate([7,0,10])cube([16,2,5]);
        translate([5,2,10])rotate([0,0,180])tprism(2,2,5);
        translate([25,0,10])rotate([0,0,0])tprism(2,2,5);

        // triangle-ish bit
        translate([7+3, 2, 10+5])rotate([0,0,180])tprism(2,1,3);
        translate([7 + 4, 0, 10 + 5])cube([1,2,3]);
        translate([7+6, 0, 10+5])rotate([0,0,0])tprism(2,1,3);

        // rectangle with rounded bit
        //translate([7 + 7, 0, 10 + 5]) intersection(){
        //  cube([2.5,2,2.5]);
        //  translate([1.2,2,1.2])rotate([90,0,0])cylinder(h=2, r=1, center=false, $fn=40);
        //}
        translate([7 + 7, 0, 10 + 5]) union(){
          cube([2.5,2,2]);
          cube([2,2,2.5]);
          translate([2.5,0,2])tprism(2,0.5,0.5);
        }
    }
    raisedPart();
    translate([0,9,0])raisedPart();

    // the little inner bars by the hook
    translate([13.7,0,0])cube([1,4,14]);
    translate([13.7,7,0])cube([1,4,14]);

    // the hook
    translate([19,3.5,0])cube([2,4,14]);
    translate([17,3.5,12])cube([2,4,2]);
    // support fin
    translate([21,5.5,0])cube([2,1,10]);


    // plungers that actually press the actuators
    translate([47,2,0])cube([1,7,18]);
    translate([54,2,0])cube([1,7,18]);
}

module keywellCutout() {
    // small inner circle
    // cylinder hight greater to cut fully through
    translate([5,5.5,-1])cylinder(h=12, r=3, center = false, $fn=40);

    // bigger outer circle, white keys have this 4mm deep, black keys have it at 6mm deep.  This does not include the angled part.
    // Since this is a cutout, I am cutting to the top of the angled part.
    // Since I am ignoring the difference between black and white keys for now, I will split the difference and have the big hole angle go from 4-5mm (instead of 3-4 or 4-5).
    extraZ=1;
    translate([4.5,5.5,-extraZ])cylinder(h=4+extraZ, r=4.5, center=false, $fn=40);

    // Here is the angled part joining the inner and outer circles.
    translate([5,5,5-0.01])cylinder(h=1.01, r1=4.5, r2=3, center=false, $fn=40);

    // Now the cube part that goes to the end connecting the inner circle.
    translate([-1,2.5,-1])cube([6,6,12]);

};

difference(){
    keyNoCutout();
    keywellCutout();
    // rectangle hole
    translate([15,1.5,-0.01])cube([4,8,12]);
}

