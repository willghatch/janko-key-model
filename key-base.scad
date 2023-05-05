
// Key interface for M-audio keystation 49e.

// The key base needs to be 110mm long to go past the stopper.
keyBaseLength=110;
keyBaseWidth=11;
// Full white key length is 160mm.  135mm is the “user area” where the pads can be.
fullWhiteKeyLength=160;
userAreaOffset=fullWhiteKeyLength - 135;


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

module keybase(){



    module keyNoCutout() {
        // key top, upside down
        cube([keyBaseLength,keyBaseWidth,2]);

        // key sides, basic part
        translate([0,0,0])cube([keyBaseLength,2,10]);
        translate([0,9,0])cube([keyBaseLength,2,10]);

        // key well outside
        cube([10,keyBaseWidth,10]);

        module raisedPart() {
            // raised part
            translate([7,0,10])cube([16,2,5]);
            translate([5,2,10])rotate([0,0,180])tprism(2,2,5);
            translate([25,0,10])rotate([0,0,0])tprism(2,2,5);

            // triangle-ish bit
            translate([7+3, 2, 10+5])rotate([0,0,180])tprism(2,1,2.5);
            translate([7 + 4, 0, 10 + 5])cube([1,2,2.5]);
            translate([7+6, 0, 10+5])rotate([0,0,0])tprism(2,1,2.5);

            // rectangle with rounded bit
            //translate([7 + 7, 0, 10 + 5]) intersection(){
            //  cube([2.5,2,2.5]);
            //  translate([1.2,2,1.2])rotate([90,0,0])cylinder(h=2, r=1, center=false, $fn=40);
            //}
            translate([7 + 7, 0, 10 + 5]) union(){
                cube([2.5,2,1.5]);
                cube([2,2,2]);
                translate([2.5,0,1.5])tprism(2,0.5,0.5);
            }
        }
        raisedPart();
        translate([0,9,0])raisedPart();

        // the little inner bars by the hook
        barwidth=3.3;
        translate([13.7,0,0])cube([1,barwidth,14]);
        translate([13.7,keyBaseWidth - barwidth,0])cube([1,barwidth,14]);

        // the hook
        translate([19,3.5,0])cube([2,4,14]);
        translate([17,3.5,12])cube([2,4,2]);
        // TODO - the hook can be wider.  It just has to bend a tiny bit.
        // support fin
        // I'm discovering that the support fin is crucial.  The hook is what prevents the key from being pulled back TOO far.  Alternatively (or in addition), I could design something that goes below the stopper.  The white keys have two lower hook things, one of which his the upper stopper (and the lower one seems... irrelevant.  I don't understand it -- it doesn't hit the lower stopper on the way down or on the way up, it just doesn't hit anything).  If I put on the front lower hook, the back hook might even be unnecessary.  It will certainly be less of a critical failure point.
        translate([21,4,0])cube([2,3,13]);
        translate([21,4,0])cube([3,3,10]);
        translate([21,4,0])cube([5,3,8]);
        translate([21,4,0])cube([7,3,5]);
        translate([21,4,0])cube([11,3,3]);


        // plungers that actually press the actuators
        // I'm making them thicker, because at 1mm thickness they snap way too easily.
        translate([47,2,0])cube([1,7,19]);
        translate([46,2,0])cube([3,7,18]);

        translate([54,2,0])cube([1,7,19]);
        translate([53,2,0])cube([3,7,18]);


        // bottom hook -- IE the underside part farthest from the spring that keeps the key from rising up past its “neutral” point.
        // There are 44mm between the original far-from-spring 1mm plunger and the bottom hook.
        // The bottom hook closes maybe 1mm beyond where the plungers extend.
        // This is a bit of a wide bridge, so hopefully it works.  I'm going to pull in each side by 0.5mm which I think I can fit.
        bridgeHeightOffset = 5;
        // After trying to make the bridge 1mm thinner, the gap was too small and the key couldn't move freely.  If anything, I need to make the bridge wider...
        bridgeThinner = -0.1;
        translate([54 + 1 + 44, 0, bridgeHeightOffset])cube([5, 2 + bridgeThinner, 22 - bridgeHeightOffset]);
        translate([54 + 1 + 44, keyBaseWidth - 2 - bridgeThinner, bridgeHeightOffset])cube([5, 2 + bridgeThinner ,22 - bridgeHeightOffset]);
        translate([54 + 1 + 44, 0,20])cube([5,keyBaseWidth,2]);
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
        // TODO - this is unnecessary, it's probably there for their manufacturing process.  Maybe I should remove this hole.
        //translate([15,1.5,-0.01])cube([4,8,12]);
        // the cover goes just beyond this, eg. 5mm.  I should give probably ~10cm before any key.
    }

}



// First pass design, pads are 22x22 squares
module pad() {
    padHeight = 3;
    translate([0,-5.25,0])
    translate([2,2,0])
    minkowski() {
        cube([17.5,17.5,padHeight]);
        cylinder(h=0.1, r=2, center=true, $fn=50);
    }
}


module bottomRowKey() {
    keybase();

    // extend key base
    translate([50,0,0])cube([fullWhiteKeyLength-50,keyBaseWidth,2]);
    translate([50,0,0])cube([fullWhiteKeyLength-50,2,10]);
    translate([50,9,0])cube([fullWhiteKeyLength-50,2,10]);

    translate([fullWhiteKeyLength - 20,0,0])pad();
    translate([fullWhiteKeyLength - (20 + 23 * 2) + 4,0,-20])cube([12, keyBaseWidth, 20]);
    translate([fullWhiteKeyLength - (20 + 23 * 2),0,-20])pad();
    translate([fullWhiteKeyLength - (20 + 23 * 4) + 4,0,-40])cube([12, keyBaseWidth, 40]);
    translate([fullWhiteKeyLength - (20 + 23 * 4),0,-40])pad();
}


module bottomRowKeyWithHoles() {
    difference(){
        union(){
            keybase();

            // extend key base
            translate([50,0,0])cube([fullWhiteKeyLength-50,keyBaseWidth,2]);
            translate([50,0,0])cube([fullWhiteKeyLength-50,2,10]);
            translate([50,9,0])cube([fullWhiteKeyLength-50,2,10]);

            translate([fullWhiteKeyLength - 20,0,0])pad();

            // hole perimiter
            // My first try at this put one of the hole perimiters over the key depression stopper, so I need to move it forward about 7mm or re-design.
            // If I can't use this design and avoid the holes, an alternative is a hole with no front/back holders, and a shallow peg, then superglue.
            //translate([fullWhiteKeyLength - (20 + 23 * 2) + 6,0,0])cube([2,keyBaseWidth,10]);
            //translate([fullWhiteKeyLength - (20 + 23 * 2) + 6 + keyBaseWidth-2,0,0])cube([2,keyBaseWidth,10]);

            //translate([fullWhiteKeyLength - (20 + 23 * 4) + 6,0,0])cube([2,keyBaseWidth,10]);
            //translate([fullWhiteKeyLength - (20 + 23 * 4) + 6 + keyBaseWidth-2,0,0])cube([2,keyBaseWidth,10]);
        }
        translate([fullWhiteKeyLength - (20 + 23 * 2) + 8, 2,-0.1])cube([keyBaseWidth-4,keyBaseWidth-4, 2.5]);
        translate([fullWhiteKeyLength - (20 + 23 * 4) + 8, 2,-0.1])cube([keyBaseWidth-4,keyBaseWidth-4, 2.5]);
    }
    //translate([fullWhiteKeyLength - (20 + 23 * 2) + 4,0,-20])cube([12, keyBaseWidth, 20]);
    //translate([fullWhiteKeyLength - (20 + 23 * 2),0,-20])pad();
    //translate([fullWhiteKeyLength - (20 + 23 * 4) + 4,0,-40])cube([12, keyBaseWidth, 40]);
    //translate([fullWhiteKeyLength - (20 + 23 * 4),0,-40])pad();
}

module topRowKey() {
    keybase();

    // extend key base
    translate([50,0,0])cube([fullWhiteKeyLength-50 - 27,keyBaseWidth,2]);
    translate([50,0,0])cube([fullWhiteKeyLength-50 - 27,2,10]);
    translate([50,9,0])cube([fullWhiteKeyLength-50 - 27,2,10]);

    translate([fullWhiteKeyLength - (20 + 23 * 1) + 4,0,-10])cube([12, keyBaseWidth, 10]);
    translate([fullWhiteKeyLength - (20 + 23 * 1),0,-10])pad();
    translate([fullWhiteKeyLength - (20 + 23 * 3) + 4,0,-30])cube([12, keyBaseWidth, 30]);
    translate([fullWhiteKeyLength - (20 + 23 * 3),0,-30])pad();
}

module topRowKeyWithHoles() {
    difference(){
        union(){
            keybase();
            // extend key base
            translate([50,0,0])cube([fullWhiteKeyLength-50 - 23,keyBaseWidth,2]);
            translate([50,0,0])cube([fullWhiteKeyLength-50 - 23,2,10]);
            translate([50,9,0])cube([fullWhiteKeyLength-50 - 23,2,10]);

            // hole perimiter
            //translate([fullWhiteKeyLength - (20 + 23 * 1) + 6,0,0])cube([2,keyBaseWidth,10]);
            //translate([fullWhiteKeyLength - (20 + 23 * 1) + 6 + keyBaseWidth-2,0,0])cube([2,keyBaseWidth,10]);

            //translate([fullWhiteKeyLength - (20 + 23 * 3) + 6,0,0])cube([2,keyBaseWidth,10]);
            //translate([fullWhiteKeyLength - (20 + 23 * 3) + 6 + keyBaseWidth-2,0,0])cube([2,keyBaseWidth,10]);
        }
        translate([fullWhiteKeyLength - (20 + 23 * 1) + 8, 2,-0.1])cube([keyBaseWidth-4,keyBaseWidth-4, 2.5]);
        translate([fullWhiteKeyLength - (20 + 23 * 3) + 8, 2,-0.1])cube([keyBaseWidth-4,keyBaseWidth-4, 2.5]);
    }

    //translate([fullWhiteKeyLength - (20 + 23 * 1) + 4,0,-10])cube([12, keyBaseWidth, 10]);
    //translate([fullWhiteKeyLength - (20 + 23 * 1),0,-10])pad();
    //translate([fullWhiteKeyLength - (20 + 23 * 3) + 4,0,-30])cube([12, keyBaseWidth, 30]);
    //translate([fullWhiteKeyLength - (20 + 23 * 3),0,-30])pad();
}

module padPeg(offset) {
    pad();
    translate([4,0,0])cube([12, keyBaseWidth, 10 * offset]);
    translate([8,2,0])cube([keyBaseWidth-4, keyBaseWidth-4, 10 * offset + 2]);
    //translate([fullWhiteKeyLength - (20 + 23 * 2) + 4,0,-20])cube([12, keyBaseWidth, 20]);
    //translate([fullWhiteKeyLength - (20 + 23 * 2),0,-20])pad();
}

module demo() {
    // IE a function to visualize everything
    translate([0,(keyBaseWidth + 1) * -3, 0])padPeg(offset=1);
    translate([0,(keyBaseWidth + 1) * -5, 0])padPeg(offset=2);
    translate([0,(keyBaseWidth + 1) * -7, 0])padPeg(offset=3);
    translate([0,(keyBaseWidth + 1) * -9, 0])padPeg(offset=4);

    translate([0,(keyBaseWidth + 1) * 1,0])topRowKeyWithHoles();
    translate([0,(keyBaseWidth + 1) * 2,0])bottomRowKeyWithHoles();

    translate([0,(keyBaseWidth + 1) * 3,0])topRowKey();
    translate([0,(keyBaseWidth + 1) * 4,0])bottomRowKey();
    translate([0,(keyBaseWidth + 1) * 5,0])topRowKey();
    translate([0,(keyBaseWidth + 1) * 6,0])bottomRowKey();
}
//demo();
