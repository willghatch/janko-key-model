
// Key interface for M-audio keystation 49e.
// Looking around online I also want to find other keyboards that may be compatible:
// • M-audio code 49 looks like it has the same or similar keys with back spring from this video https://www.youtube.com/watch?v=ah3o2PHlj2U but I can't see the sit-on-bed contact.
// • The M-Audio Axiom Pro 49 looks like it is very similar, but may need some tweaks to the trapezoid area (where it rests on the bed near the spring).  (Based on a youtube video: https://www.youtube.com/watch?v=0EXhBHUBSy0).  On another video I see the M-Audio Axiom 61 has the same spring mechanism, but I can't see the key interface -- probably it is like the M-Audio Axiom Pro 49... (based from https://www.youtube.com/watch?v=KjNV4O8UoOk).
// • The M-Audio Keystation 61es looks like it has the same keys, based on https://www.youtube.com/watch?v=rw7M5bsJpx8 (which shows dissasembly of the keystation 49e)
// • The M-Audio Keystation Pro-88 looks like it has similar keys, but they have a different spring, and maybe 2 springs, but I can't tell for sure.  Definitely I would need a different model, but probably similar.  (From https://youtu.be/f-iIatuSr-s?t=56)
// • These keys that have the same spring but a different sit-on-the-bed contact, it looks like they are SIMPLER -- eg. a big groove instead of tiny teeth.  So it should actually be a lot easier to design the contact point for them.
// • The M-Audio Keystation 88es looks like it has similar keys, but also maybe the big groove.  From https://www.bustedgear.com/repair_M-Audio_keystation_usb_jack_2.html

// The keys have a part that goes really low on the front, and it doesn't make any sense on this keyboard.  It looks like other keyboards have an extra contact on the front for aftertouch.  So they either re-used the key completely or re-used some component.  A “Hydrasynth” keyboard from this video (https://youtu.be/-6JpllyS1nA?t=487) looks like it has nearly the same keys but uses that lower part for aftertouch.  This key shape may be a somewhat industry standard, or licensed to multiple companies, or some kind of whitelabel component.


// TODO - I wrote this stupidly using X for the long direction of the key and Y for the skinny direction of the key, as if you are looking at one key on its side.  I should have used X for the dimension that the keyboard is long in instead.  This bit me when doing the key pad toppers due to text, though otherwise it doesn't really matter.  But... it could be changed...

// TODO - I printed them and assembled them, but putting the pegs in was overly difficult.  I should at least scale the peg to 99% or something if I print more in the future.  Better yet, design it so that it can't go in rotated a quarter turn as well, and make it fit easier.  I ultimately super glued everything together anyway, it might as well be easier to assemble.


// coloring
// I could do black & white like a piano, which would let me orient somewhat like a normal pianist.
// Another possibility that I've considered is a 6 color scheme, where each key shares a color with one neighbor, IE each color appears once on each row, meaning that with color plus row (or color plus whether it's the left or the right) can distinctly identify a key.
// Roy Pertchik has a tri-color scheme where the three diminished chords are colored differently.  This is interesting, but each color is then used for 4 notes, and I'm not sure how helpful it would be in orienting myself (eg. when first sitting down or playing a key at a distance), since there is no obvious start/break in the pattern (like there is with the uneven numbers of black/white notes).  However, I could see it being helpful in noticing patterns.  Eg. when playing in a major key of color 1, I might come to remember and note the colors of different scale degrees.  The colors will have a certain ordering, eg. say I do RGB, with C as red, C# as Green, D as blue, the fourth scale degree is one color back (blue in C) and the fifth is one color forward (green in C).  If I add pink for C (IE a different shade of red) then I can orient based on that, but see the patterns.  Maybe RGB, but with one light tone of each color to help with orientation - pink C, light green G, light blue F.
// Decision: I will use tri-color RGB, except with pink C, maybe light green G and light blue F.

// pad tops
// After trying a print with braille, I'm not confident that it will be very useful to me.  An alternate idea I have is to have different textures to the keys: smooth, wavy horizontal, wavy vertical, maybe with two frequencies of waves, which gives 5 textures.  Maybe in addition I can have one key with a single horizontal or vertical line, giving 6 textures.  That means I can use each texture once on each row, and maybe on C/C# I do the single line, but to vertical on one and horizontal on the other.  But even if I stick to the idea of Braille, I need lower profile dots.  As it is, the pads are too rough.  It might work better if I had one of those resin stereolithography printers -- I think they can get much better resolution.  The key tops I've printed so far are rough and the bumps very course.  Another idea -- smooth, vertical line, horizontal line, diagonal one way, diagonal the other way, dot.  OR -- vertical, horizontal, and diagonal (3 orientations that match the 3 Roy Pertchik colors), plus 4 variations - single, double close, double wide, triple.
// Decision: With RGB coloring, red keys get horizontal stripes, green keys get diagonal (top-left to bottom-right), blue keys get vertical stripes.

// Rows: photos of old looking Janko keyboards seem to typically have C on the bottom row.  This doesn't matter much, but I'll be consistent with the old ones.

// So the color, tactile layout, and row is:
// C - R (pink), single horizontal stripe, bottom row
// C# - G, 1D, top row
// D - B, 1V, bottom row
// D# - R, 2H, top row
// E - G, 2D, bottom row
// F - B (light?), 2V, top row
// F# - R, 2wH, bottom row
// G - G (light?), 2wD, top row
// G# - B, 2wV, bottom row
// A - R, 3H, top row
// A# - G, 3D, bottom row
// B - B, 3V, top row

// 2023-05-10 - Fill - My latest design works great - I've been using 15% grid infill, which has worked fine, but I just tried 100% rectilinear infill for the base in hopes of having stronger tiny functional pieces (eg. the teeth where it rests by the spring), and it worked well.  I believe I will continue with low fill for the pegs and key toppers, but 100% fill for the key bases.




doPadBlunting = true;

// The key base needs to be 110mm long to go past the stopper.
keyBaseLength=110;
keyBaseWidth=11;
keyWallWidth=2;
keyInnerWidth = keyBaseWidth - keyWallWidth;
pegSize = keyBaseWidth - 4;
// Full white key length is 160mm.  135mm is the “user area” where the pads can be.
fullWhiteKeyLength=160;
extraBottomRowLength=pegSize/2;
userAreaOffset=fullWhiteKeyLength - 135;
pegScale = 0.92;

// Note, from the back of the key, where it holds the spring, to where the original black keys bump up (IE clearance for the case), it is about 22mm.  But the leverage at that point is really poor, so I put the top row of pads farther away to have better leverage.


padRoundExtra = 2;
padHexCenterToEdge = 8;
//padX = 2 * padHexCenterToEdge * 1.1547;
//padY = 2 * padHexCenterToEdge;
//padX = 16;
//padY = 18;
//padZ = 3;
//padFullX = padX + padRoundExtra * 2;
//padFullY = padY + padRoundExtra * 2;


padX = 19;
padY = 24;
padZ = 1;
padFullX = padX;
padFullY = padY;

padTopHeight = 5;
padAngle = - atan(padTopHeight / padX);
padTopHypotenuseLength = -padTopHeight / (sin(padAngle));
padTopPegHeight = 1.2;

bottomPadOffset = fullWhiteKeyLength - 10;
interPadOffset = padFullX + 4;
//interPadOffset = padFullX + 0;

behindHookBulgeWidth = 0.4;

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
            //// Because the hook has an overhang, it tends to sag.  Now that I've added the bottom front hook, I'm not certain that the back hook is completely necessary.
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
        bridgeHeightOffset = keyWallWidth;
        // After trying to make the bridge 1mm thinner, the gap was too small and the key couldn't move freely.  If anything, I need to make the bridge wider...
        //bridgeThinner = -0.1;
        // Trying anything to adjust the bridge was a mistake.  It catches on the pad.
        //bridgeThinner = 0;
        // After trying to make the bridge go farther forward to stop it catching on the stopper on the way down, I'm realizing that it can catch on the back as well as the front.  The only real way to fix it is to make the bridge thinner, which the official keys actually do.  So... maybe I just need to find the right size where it can move freely but not catch.  The biggest danger here, I think, is that FDM printers print rough edges that might still catch or just be too rough.  I don't want a big process of sanding or finishing keys after printing.
        // After using 0.25 bridgeThinner, it never catches on the way down, but on one of the two keys I printed it snags just enough to not raise back up 100% of the way (it gets to like 80-90%).  I think the only reasonable solution is some post-print polishing with eg. a very fine file to make it smoother.
        // Actually, I think rather than use a bridge thinner, I can instead make the gap wider around it.  There is at least a 2.5mm gap between keys, and this is exactly at a point where the keys are constrained to not jiggle.  I can make the keys bulge out by 0.5mm on each side behind the bridge so it can't snag and so it has enough room for the spring to pull it all the way back.  Then I won't need to do fine filing in a constrained space.
        //bridgeThinner = 0.25;
        bridgeThinner = 0;
        // The key length of the bridge (IE the width of the bridge part) was 5 on the original, but it has some fins that go forward that help the peg not catch on the key as it moves down in the corner between the bridge siding and the key bottom.  So I'm lengthening it to 8 so it can never snag.
        bridgeFullContactLength = 8;
        translate([54 + 1 + 44, 0, bridgeHeightOffset])cube([bridgeFullContactLength, 2 + bridgeThinner, 22 - bridgeHeightOffset]);
        translate([54 + 1 + 44, keyBaseWidth - 2 - bridgeThinner, bridgeHeightOffset])cube([bridgeFullContactLength, 2 + bridgeThinner ,22 - bridgeHeightOffset]);
        translate([54 + 1 + 44, 0,20])cube([bridgeFullContactLength,keyBaseWidth,2]);

        // behind bridge bulge
        translate([85,-behindHookBulgeWidth,0])cube([15,behindHookBulgeWidth,10]);
        translate([85,11,0])cube([15,behindHookBulgeWidth,10]);
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
        translate([5,5,4-0.01])cylinder(h=1.01, r1=4.5, r2=3, center=false, $fn=40);

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

        // cutout behind front underside hook (bridge)
        translate([87,11-2.1,2])cube([12,0.1 + behindHookBulgeWidth,10]);
        translate([87,2-behindHookBulgeWidth,2])cube([12,0.1 + behindHookBulgeWidth,10]);
    };

}



module pad() {
    // Pad is "centered" such that if you translate it the same amount as a pad peg hole the pads will be at the same X,Y position.

    // I would like a pad that is tilted so that the end higher to the player is higher, so if the keyboard is tilted up at the back, the player pressing down is a down+forward direction at the key pad.  But this seems difficult to design here.  Maybe I'll design an add-on part that I can glue on top of the pad.  Then I can eg. add bumps for different notes, and print them in different colors.

    // squarish pad version
    //color("green")
    //translate([0,-5.25,0])
    //translate([2,2,0]) // center relative to minkowsky effect
    //minkowski() {
    //    cube([padX,padY,padZ]);
    //    cylinder(h=0.01, r=padRoundExtra, center=true, $fn=50);
    //}

    // hex pad version
    //poly_n = 6;
    //translate([padFullX / 2, keyBaseWidth / 2, 0])
    //minkowski() {
    //    cylinder(r=padHexCenterToEdge /cos(180/poly_n), $fn=poly_n, center=false);
    //    cylinder(h=0.01, r=padRoundExtra, center=true, $fn=50);
    //}

    // oval pad version
    translate([padX/2,keyBaseWidth/2,0])
    scale([padX/2,padY/2,1])cylinder(r=1, h=padZ, $fn=50, center=false);
}



module padPegHole() {
    // "centered" similar to pad.
    translate([((padFullX - pegSize) / 2), keyWallWidth, -0.25])cube([pegSize,pegSize, 4]);
}

function padZOffset(row) =
    // The vertical distance that the pads move depends on their row, where 0 is the farthest from the spring/back/axis of rotation.
    // I want them offset so that when depressed, the key is just above or near the keys on the next row.
    // Because I plan to put a ~5mm thick angled topper on each pad, that means that the top of the bottom part of the key will be higher than the top part of the lower row key by a bit extra that I need to factor in..
    // The farthest pads move about 10mm vertically
    row == 0 ? 5 :
    row == 1 ? 13.5 :
    row == 2 ? 13.5 - 0.3 + 7 :
    row == 3 ? 13.5 + 7 + 5 :
    row == 4 ? 13.5 + 7 + 5 + 3 :
    row == 5 ? 13.5 + 7 + 5 + 3 + 1 :
    60;


module padPeg(offset) {
  // "centered" similar to pad.

  // The top key of a previous print only moves down by ~4mm when depressed, but moves forward ~5mm.
  //color("green")
  difference(){
    union(){
      pad();
      zOff = padZOffset(offset);
      translate([((padFullX - 12) / 2), 0, 0])cube([12,keyBaseWidth, zOff]);
      translate([((padFullX - pegSize + (1-pegScale)*pegSize) / 2), keyWallWidth + ((1-pegScale)*pegSize)/2, 0])scale([pegScale, pegScale, 1])cube([pegSize,pegSize, zOff + 2]);
      //translate([((padFullX - pegSize) / 2), keyWallWidth, 0])cube([pegSize,pegSize, zOff + 2]);
    }
    //translate([padX/2,keyBaseWidth/2,0])
    translate([((padX - pegSize)/2), ((keyBaseWidth - pegSize)/2), -0.01])cube([pegSize * pegScale, pegSize * pegScale, padTopPegHeight]);
  }
}



module bottomRowKeyWithHoles() {
    difference(){
        union(){
            keybase();

            // extend key base
            translate([100,0,0])cube([fullWhiteKeyLength-100 + extraBottomRowLength,keyBaseWidth,2]);
            translate([100,0,0])cube([fullWhiteKeyLength-100 + extraBottomRowLength,2,10]);
            translate([100,9,0])cube([fullWhiteKeyLength-100 + extraBottomRowLength,2,10]);
            translate([fullWhiteKeyLength + extraBottomRowLength, 0,0])cube([2,keyBaseWidth,10]);

            //translate([bottomPadOffset,0,0])pad();
        }
        translate([bottomPadOffset - interPadOffset * 0, 0,0])padPegHole();
        translate([bottomPadOffset - interPadOffset * 2, 0,0])padPegHole();
        translate([bottomPadOffset - interPadOffset * 4, 0,0])padPegHole();
    }
}


module topRowKeyWithHoles() {
    difference(){
        union(){
            keybase();
            // extend key base
            translate([100,0,0])cube([fullWhiteKeyLength-100 - 15,keyBaseWidth,2]);
            translate([100,0,0])cube([fullWhiteKeyLength-100 - 15,2,10]);
            translate([100,9,0])cube([fullWhiteKeyLength-100 - 15,2,10]);
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
    translate([bottomPadOffset - interPadOffset * (0 + 0), 0, -padZOffset(0)])mirror([0,0,0])padPeg(0);
    translate([bottomPadOffset - interPadOffset * (2 + 0), 0, -padZOffset(2)])mirror([0,0,0])padPeg(2);
    translate([bottomPadOffset - interPadOffset * (4 + 0), 0, -padZOffset(4)])mirror([0,0,0])padPeg(4);
}
module topRowKeyFilled() {
    topRowKeyWithHoles();
    translate([bottomPadOffset - interPadOffset * (1 + 0), 0, -padZOffset(1)])mirror([0,0,0])padPeg(1);
    translate([bottomPadOffset - interPadOffset * (3 + 0), 0, -padZOffset(3)])mirror([0,0,0])padPeg(3);
    translate([bottomPadOffset - interPadOffset * (5 + 0), 0, -padZOffset(5)])mirror([0,0,0])padPeg(5);
}





module padTop_sharp() {
    // A topper for the pads of a Janko keyboard.
    // I want the key tops to have an angle up toward the user, so that I can raise the back of the keyboard to make them flatter, but then pressing “down” will be pressing at an angle that is more favorable for the various raised keys.

    // I've been using X and Y swapped from what I should have.  So... they are swapped in these pad-related things so text extrusion can work well.

    intersection(){
        translate([padY/2, padX/2, 0])scale([padY/2,padX/2,1])cylinder(r=1, h=padTopHeight*2, $fn=50, center=false);
        //mirror([1,0,0])tprism(padX,padY,padTopHeight);
        translate([padY,padX,0])rotate([0,0,90])tprism(padY,padX,padTopHeight);
    }

    // This is the rotation to get something on the level with the pad top
    //rotate([0, padAngle, 0])cube([10,2,2]);
}
module padTop_sideCarveOut(){
  color("red")translate([-3,5,5])rotate([0,-10,0])rotate([10,0,0])cube([40,20,5], center=true);
  color("orange")translate([-3,5,5])rotate([0,-10,0])rotate([5,0,0])cube([40,20,5], center=true);
  color("blue")translate([-3,5,5.27])rotate([0,-7,0])rotate([5,0,0])cube([40,20,5], center=true);
  color("green")translate([-3,5,5])rotate([0,-15,0])rotate([20,0,0])cube([40,20,5], center=true);
}
module padTop() {
  difference(){
    padTop_sharp();
    // Carve out some rectangles to smooth out the pad so the angles are obtuse and don't hurt fingers.
    color("purple")translate([20,0,5.8])rotate([35,0,0])cube([40,10,5], center=true);
    color("blue")translate([20,0,5.7])rotate([27,0,0])cube([40,10,5], center=true);
    color("green")translate([20,0.7,6])rotate([10,0,0])cube([40,10,5], center=true);
    color("red")translate([20,0,6.2])rotate([3,0,0])cube([40,10,5], center=true);
    color("orange")translate([20,12,5.8])rotate([-4,0,0])cube([40,20,5], center=true);
    // Carve out more rectangles for the sides
    padTop_sideCarveOut();
    translate([padY/2,0,0])mirror([1,0,0])translate([-padY/2,0,0])padTop_sideCarveOut();
    // Carve out a peg hole
    translate([((padY - pegSize)/2), (padX - pegSize)/2, -0.01])cube([pegSize, pegSize, padTopPegHeight]);
  }
}

module padTop_lineVertical(centerOffset){
    intersection(){
        translate([padY/2, padX/2, 0])scale([padY/2,padX/2,1])cylinder(r=1, h=padTopHeight, $fn=50, center=false);
        // This line instead of the above bounds it a little better with rounding, but frankly I think I just want a different tactile system.
        //translate([padY/2, padX/2, 0])scale([(padY - 3)/2,(padX - 3)/2,1])cylinder(r=1, h=padTopHeight - 0.5, $fn=50, center=false);
        translate([centerOffset,0,0])
        translate([padY/2,padX,0])
        rotate([padAngle + 90,0,0]){
            cylinder(r=0.5, h=500, $fn=50, center=false);
        }
    }
}

module padTop_lineHorizontal(centerOffset){
    intersection(){
        translate([padY/2, padX/2, 0])scale([padY/2,padX/2,1])cylinder(r=1, h=padTopHeight, $fn=50, center=false);
        translate([centerOffset,0,0])
        translate([padY/2,padX,0])
        rotate([padAngle + 90,0,0]){
            translate([0,0,centerOffset])
            translate([0,0,padTopHypotenuseLength/2])
            rotate([0,90,0]){
                cylinder(r=0.5, h=500, $fn=50, center=true);
            }
        }
    }
}

module padTop_lineDiagonal_leftTopToRightBottom(centerOffset){
    intersection(){
        translate([padY/2, padX/2, 0])scale([padY/2,padX/2,1])cylinder(r=1, h=padTopHeight, $fn=50, center=false);
        translate([centerOffset,0,0])
        translate([padY/2,padX,0])
        rotate([padAngle + 90,0,0]){
            translate([centerOffset,0,centerOffset])
            translate([0,0,padTopHypotenuseLength/2])
            rotate([0,45,0]){
                cylinder(r=0.5, h=500, $fn=50, center=true);
            }
        }
    }
}

module padTop_lined(note) {
    // Using my note tactile and color plan in comment at top.
    // Empty string (or invalid string) for smooth top.
    padTop();

    if (note == "C"){
        padTop_lineHorizontal(0);
    } else if (note == "C#"){
        padTop_lineDiagonal_leftTopToRightBottom(0);
    } else if (note == "D"){
        padTop_lineVertical(0);
    } else if (note == "D#"){
        padTop_lineHorizontal(-2);
        padTop_lineHorizontal(2);
    } else if (note == "E"){
        padTop_lineDiagonal_leftTopToRightBottom(-2);
        padTop_lineDiagonal_leftTopToRightBottom(2);
    } else if (note == "F"){
        padTop_lineVertical(-2);
        padTop_lineVertical(2);
    } else if (note == "F#"){
        padTop_lineHorizontal(-4);
        padTop_lineHorizontal(4);
    } else if (note == "G"){
        padTop_lineDiagonal_leftTopToRightBottom(-4);
        padTop_lineDiagonal_leftTopToRightBottom(4);
    } else if (note == "G#"){
        padTop_lineVertical(-4);
        padTop_lineVertical(4);
    } else if (note == "A"){
        padTop_lineHorizontal(-4);
        padTop_lineHorizontal(0);
        padTop_lineHorizontal(4);
    } else if (note == "A#"){
        padTop_lineDiagonal_leftTopToRightBottom(-4);
        padTop_lineDiagonal_leftTopToRightBottom(0);
        padTop_lineDiagonal_leftTopToRightBottom(4);
    } else if (note == "B"){
        padTop_lineVertical(-4);
        padTop_lineVertical(0);
        padTop_lineVertical(4);
    } else {
        // Smooth top.
    }

    // TODO...
// C - R (pink), single horizontal stripe
// C# - G, 1D
// D - B, 1V
// D# - R, 2H
// E - G, 2D
// F - B (light?), 2V
// F# - R, 2wH
// G - G (light?), 2wD
// G# - B, 2wV
// A - R, 3H
// A# - G, 3D
// B - B, 3V
}

module padTop_text(s, offset, font, fontSize, s2="", offset2=[0,0,0]){
    padTop();

    // If only I could define a transformation...  for now I'll just copy paste this stuff because I don't this openscad is expressive enough to do what I want, according to things I have read.
    color("green")
    translate([0,0,padTopHeight]) rotate([padAngle,0,0]){
        translate(offset) linear_extrude(0.7)
            text(s, fontSize, font=font);
        translate(offset2) linear_extrude(0.7)
            text(s2, fontSize, font=font);
    }
}

function latinToBraille_upperSix(a) =
    // IE using the upper six braille dots, which I think is the normal thing to do.
    a == "A" ? "\u2801" :
    a == "B" ? "\u2803" :
    a == "C" ? "\u2809" :
    a == "D" ? "\u2819" :
    a == "E" ? "\u2811" :
    a == "F" ? "\u280B" :
    a == "G" ? "\u281B" :
    "?";

function latinToBraille_lowerSix(a) =
    // IE using the lower six braille dots, which I think is the weird thing to do.
    a == "A" ? "\u2802" :
    a == "B" ? "\u2806" :
    a == "C" ? "\u2812" :
    a == "D" ? "\u2832" :
    a == "E" ? "\u2822" :
    a == "F" ? "\u2816" :
    a == "G" ? "\u2836" :
    "?";

module padTop_braille(s, s2=""){
    padTop_text(s=latinToBraille_lowerSix(s), s2=s2, fontSize=7, offset=[8.25,4,0], offset2=[7.75,7,0], font="DejaVu Sans");
}

module rPadTop_lined(note) {
    // They print nicer when rotated on the side.  There is some extra support material needed, but the side prints so much smoother than the top, and removing the supports and sanding just a bit will still be a way nicer top when it's printed on the side than if it's printed upright (and still needs sanding anyway).
    // ! Actually, now that I've tried gluing them on after printing and testing them a bit, I actually find that I prefer the ones printed flat.
    rotate([90,0,0]) padTop_lined(note);
}

module padTopSet() {
    translate([(padY + 3) * 0, (padX + 3) * 0,0])padTop_lined("A");
    translate([(padY + 3) * 1, (padX + 3) * 0,0])padTop_lined("A#");
    translate([(padY + 3) * 2, (padX + 3) * 0,0])padTop_lined("B");
    translate([(padY + 3) * 3, (padX + 3) * 0,0])padTop_lined("C");
    translate([(padY + 3) * 4, (padX + 3) * 0,0])padTop_lined("C#");
    translate([(padY + 3) * 5, (padX + 3) * 0,0])padTop_lined("D");
    translate([(padY + 3) * 0, (padX + 3) * 1,0])padTop_lined("D#");
    translate([(padY + 3) * 1, (padX + 3) * 1,0])padTop_lined("E");
    translate([(padY + 3) * 2, (padX + 3) * 1,0])padTop_lined("F");
    translate([(padY + 3) * 3, (padX + 3) * 1,0])padTop_lined("F#");
    translate([(padY + 3) * 4, (padX + 3) * 1,0])padTop_lined("G");
    translate([(padY + 3) * 5, (padX + 3) * 1,0])padTop_lined("G#");
}

module padTopsRed_noPink() {
    translate([(padY + 3) * 0, (padX + 3) * 0,0])padTop_lined("A");
    translate([(padY + 3) * 1, (padX + 3) * 0,0])padTop_lined("D#");
    translate([(padY + 3) * 2, (padX + 3) * 0,0])padTop_lined("F#");
    //translate([(padY + 3) * 3, (padX + 3) * 0,0])padTop_lined("C");
}
module padTopsGreen() {
    translate([(padY + 3) * 0, (padX + 3) * 0,0])padTop_lined("A#");
    translate([(padY + 3) * 1, (padX + 3) * 0,0])padTop_lined("C#");
    translate([(padY + 3) * 2, (padX + 3) * 0,0])padTop_lined("E");
    // G maybe I should print in light green.
    translate([(padY + 3) * 3, (padX + 3) * 0,0])padTop_lined("G");
}
module padTopsBlue() {
    translate([(padY + 3) * 0, (padX + 3) * 0,0])padTop_lined("B");
    translate([(padY + 3) * 1, (padX + 3) * 0,0])padTop_lined("D");
    translate([(padY + 3) * 2, (padX + 3) * 0,0])padTop_lined("F");
    translate([(padY + 3) * 3, (padX + 3) * 0,0])padTop_lined("G#");
}
module padTopsPink() {
    padTop_lined("C");
}


module padTopPlacementPeg() {
  // Only use a fraction of the peg height.  I want to use more than 1 in case there is now bowing where there is bridging... but typically bridging fills a lot of space and makes the two holes have little room.
  scale(pegScale)cube([pegSize, pegSize, padTopPegHeight*1.4]);
}

module demo() {
    // IE a function to visualize everything
    translate([0,(padY + 2) * -1, 0])padPeg(offset=0);
    translate([0,(padY + 2) * -2, 0])padPeg(offset=1);
    translate([0,(padY + 2) * -3, 0])padPeg(offset=2);
    translate([0,(padY + 2) * -4, 0])padPeg(offset=3);
    translate([0,(padY + 2) * -5, 0])padPeg(offset=4);
    translate([0,(padY + 2) * -6, 0])padPeg(offset=5);

    translate([0,(keyBaseWidth + 2) * 1,0])topRowKeyWithHoles();
    translate([0,(keyBaseWidth + 2) * 2,0])bottomRowKeyWithHoles();

    translate([0,(keyBaseWidth + 1) * 3,0])topRowKeyFilled();
    translate([0,(keyBaseWidth + 1) * 4,0])bottomRowKeyFilled();
    translate([0,(keyBaseWidth + 1) * 5,0])topRowKeyFilled();
    translate([0,(keyBaseWidth + 1) * 6,0])bottomRowKeyFilled();

    translate([40,-60,0])padTopSet();

    translate([70,-90,0])padTop();

    translate([50, -80, 0])padTopPlacementPeg();
}
//demo();

