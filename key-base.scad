
// Key interface for M-audio keystation 49e.

// The key base needs to be 110mm long to go past the stopper.
keyBaseLength=110;
keyBaseWidth=11;
keyWallWidth=2;
keyInnerWidth = keyBaseWidth - keyWallWidth;
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
        translate([0,0,0])cube([keyBaseLength,keyWallWidth,10]);
        translate([0,keyInnerWidth,0])cube([keyBaseLength,keyWallWidth,10]);

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

        //////////// the back hook
        union() {
            translate([19,3.5,0])cube([2,4,14]);
            //// Because the hook has an overhang, it tends to snag.  Now that I've added the bottom front hook, I'm not certain that the back hook is completely necessary.
            // hook overhang
            //translate([17,3.5,12])cube([2,4,2]);
            //// TODO - the hook can be wider.  It just has to bend a tiny bit.
            // support fin
            // I'm discovering that the support fin is crucial.  The hook is what prevents the key from being pulled back TOO far.  Alternatively (or in addition), I could design something that goes below the stopper.  The white keys have two lower hook things, one of which his the upper stopper (and the lower one seems... irrelevant.  I don't understand it -- it doesn't hit the lower stopper on the way down or on the way up, it just doesn't hit anything).  If I put on the front lower hook, the back hook might even be unnecessary.  It will certainly be less of a critical failure point.
            translate([21,4,0])cube([2,3,13]);
            translate([21,4,0])cube([3,3,10]);
            translate([21,4,0])cube([5,3,8]);
            translate([21,4,0])cube([7,3,5]);
            translate([21,4,0])cube([11,3,3]);
        }



        // plungers that actually press the actuators
        // I'm making them thicker, because at 1mm thickness they snap way too easily.
        plungerHeight = 18.5;
        translate([47,2,0])cube([1,7,plungerHeight]);
        translate([46,2,0])cube([3,7,plungerHeight-1]);

        translate([54,2,0])cube([1,7,plungerHeight]);
        translate([53,2,0])cube([3,7,plungerHeight-1]);


        // bottom front hook -- IE the underside part farthest from the spring that keeps the key from rising up past its “neutral” point.
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


padX = 16;
padY = 18;
padRoundExtra = 2;
padFullX = padX + padRoundExtra * 2;
padFullY = padY + padRoundExtra * 2;

module pad() {
    // Pad is "centered" such that if you translate it the same amount as a pad peg hole the pads will be at the same X,Y position.
    padZ = 3;
    translate([0,-5.25,0])
    translate([2,2,0]) // center relative to minkowsky effect
    minkowski() {
        cube([padX,padY,padZ]);
        cylinder(h=0.01, r=padRoundExtra, center=true, $fn=50);
    }
}

pegSize = keyBaseWidth - 4;
module padPegHole() {
    // "centered" similar to pad.
    translate([((padFullX - pegSize) / 2), keyWallWidth, -0.25])cube([pegSize,pegSize, 2.5]);
}

module padPeg(offset) {
    // "centered" similar to pad.
    pad();
    translate([((padFullX - 12) / 2), 0, 0])cube([12,keyBaseWidth, 10 * offset]);
    translate([((padFullX - pegSize) / 2), keyWallWidth, 0])cube([pegSize,pegSize, 10 * offset + 2]);
}


bottomPadOffset = fullWhiteKeyLength - 13;
interPadOffset = padFullX + 4;

module bottomRowKeyWithHoles() {
    difference(){
        union(){
            keybase();

            // extend key base
            translate([50,0,0])cube([fullWhiteKeyLength-50,keyBaseWidth,2]);
            translate([50,0,0])cube([fullWhiteKeyLength-50,2,10]);
            translate([50,9,0])cube([fullWhiteKeyLength-50,2,10]);
            translate([fullWhiteKeyLength, 0,0])cube([2,keyBaseWidth,10]);

            translate([bottomPadOffset,0,0])pad();
        }
        translate([bottomPadOffset - interPadOffset * 2, 0,0])padPegHole();
        translate([bottomPadOffset - interPadOffset * 4, 0,0])padPegHole();
    }
}


module topRowKeyWithHoles() {
    difference(){
        union(){
            keybase();
            // extend key base
            translate([50,0,0])cube([fullWhiteKeyLength-50 - 15,keyBaseWidth,2]);
            translate([50,0,0])cube([fullWhiteKeyLength-50 - 15,2,10]);
            translate([50,9,0])cube([fullWhiteKeyLength-50 - 15,2,10]);
            translate([fullWhiteKeyLength-15, 0,0])cube([2,keyBaseWidth,10]);
        }
        translate([bottomPadOffset - interPadOffset * 1, 0,0])padPegHole();
        translate([bottomPadOffset - interPadOffset * 3, 0,0])padPegHole();
        translate([bottomPadOffset - interPadOffset * 5, 0,0])padPegHole();
    }
}


// TODO - these key modules are useful for visualizing - but I need to make them as keyWithHole plus pegs.
module bottomRowKeyFilled() {
    bottomRowKeyWithHoles();
    translate([bottomPadOffset - interPadOffset * (2 + 0), 0, -10 * 2])mirror([0,0,0])padPeg(2);
    translate([bottomPadOffset - interPadOffset * (4 + 0), 0, -10 * 4])mirror([0,0,0])padPeg(4);
}
module topRowKeyFilled() {
    topRowKeyWithHoles();
    translate([bottomPadOffset - interPadOffset * (1 + 0), 0, -10 * 1])mirror([0,0,0])padPeg(1);
    translate([bottomPadOffset - interPadOffset * (3 + 0), 0, -10 * 3])mirror([0,0,0])padPeg(3);
    translate([bottomPadOffset - interPadOffset * (5 + 0), 0, -10 * 5])mirror([0,0,0])padPeg(5);
}


module demo() {
    // IE a function to visualize everything
    translate([0,(keyBaseWidth + 1) * -3, 0])padPeg(offset=1);
    translate([0,(keyBaseWidth + 1) * -5, 0])padPeg(offset=2);
    translate([0,(keyBaseWidth + 1) * -7, 0])padPeg(offset=3);
    translate([0,(keyBaseWidth + 1) * -9, 0])padPeg(offset=4);

    translate([0,(keyBaseWidth + 1) * 1,0])topRowKeyWithHoles();
    translate([0,(keyBaseWidth + 1) * 2,0])bottomRowKeyWithHoles();

    translate([0,(keyBaseWidth + 1) * 3,0])topRowKeyFilled();
    translate([0,(keyBaseWidth + 1) * 4,0])bottomRowKeyFilled();
    translate([0,(keyBaseWidth + 1) * 5,0])topRowKeyFilled();
    translate([0,(keyBaseWidth + 1) * 6,0])bottomRowKeyFilled();
}
//demo();

//difference(){
//    pad();
//    padPegHole();
//}
//translate([10,50,0])padPeg(offset=2);
