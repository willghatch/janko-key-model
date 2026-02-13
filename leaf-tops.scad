
include <key-base.scad>
include <rollercoaster.scad>

//flatPadLength = 19;
flatPadLength = 17;

keyRoundingRadius = 2;

// Leaf-specific parameters
leafStartX = 23;  // Leaf starts 23mm from back of key
leafHeight = 3;   // Height of the main leaf body above the key base
leafBaseThickness = 2;  // Thickness of the solid base underneath the leaf

// Calculate peg positions for bottom row (rows 0, 2, 4)
// Row 0 is farthest from spring/back (highest X)
Peg0X = bottomPadOffset - interPadOffset * 0;  // Row 0, farthest from back
Peg2X = bottomPadOffset - interPadOffset * 2;  // Row 2, middle
Peg4X = bottomPadOffset - interPadOffset * 4;  // Row 4, closest to back

// Calculate peg positions for top row (rows 1, 3, 5)
Peg1X = bottomPadOffset - interPadOffset * 1;  // Row 1, farthest from back
Peg3X = bottomPadOffset - interPadOffset * 3;  // Row 3, middle
Peg5X = bottomPadOffset - interPadOffset * 5;  // Row 5, closest to back

// Base lengths should match the key base lengths minus leafStartX
bottomRowBaseLength = (fullWhiteKeyLength + extraBottomRowLength) + 2 - leafStartX;
topRowBaseLength = (fullWhiteKeyLength - 15) + 2 - leafStartX;



module sharedLeafBack(){
  rollerCoaster([
                  [[0, "absolute"], [0, "absolute"]],
                  [[leafStartX, "absolute"], [0, "absolute"]],
                  [0.1, 1],
                  [2, 20],
                  [[Peg5X-8, "absolute"], [25, "absolute"]],
                  [[Peg5X-6, "absolute"], [27, "absolute"]],
                  [[Peg5X-4, "absolute"], [28.5, "absolute"]],
                  [[Peg5X-2, "absolute"], [29.5, "absolute"]],
                  [5, 0],
                  [1, -20],
                  [5,0],
                  ],
                keyBaseWidth, keyRoundingRadius,
                xAbsRelDefault="relative",
                zAbsRelDefault="relative"
    );

}

function leafZOffset(n) = padZOffset(n) - 3;

module mainLeafBottomRow(){
  // %translate([Peg0X + padFullX/2 - flatPadLength/2, 0, leafBaseThickness])
  //   cube([flatPadLength, keyBaseWidth, leafZOffset(0)]);
  // %translate([Peg2X + padFullX/2 - flatPadLength/2, 0, leafBaseThickness])
  //   cube([flatPadLength, keyBaseWidth, leafZOffset(2)]);
  // %translate([Peg4X + padFullX/2 - flatPadLength/2, 0, leafBaseThickness])
  //   cube([flatPadLength, keyBaseWidth, leafZOffset(4)]);
  rollerCoaster([
                  [[0, "absolute"], [0, "absolute"]],
                  [[leafStartX, "absolute"], [0, "absolute"]],
                  [1,1],
                  [[Peg4X, "absolute"], [28.5, "absolute"]],
                  [flatPadLength, 0],
                  [0.5, -20],
                  [[Peg2X, "absolute"], [20.2, "absolute"]],
                  [flatPadLength, 0],
                  [0.5, -15],
                  [[Peg0X, "absolute"], [7, "absolute"]],
                  [flatPadLength-3, 0],
                  [0.01, -6],
                  [2, [1, "absolute"]]
                  //[[bottomRowBaseLength, "absolute"], [0.5, "absolute"]], // 142.5
                  ],
                keyBaseWidth, keyRoundingRadius,
                xAbsRelDefault="relative",
                zAbsRelDefault="relative"
    );
}

module mainLeafTopRow(){
  // %translate([Peg1X + padFullX/2 - flatPadLength/2, 0, leafBaseThickness])
  //   cube([flatPadLength, keyBaseWidth, leafZOffset(1)]);
  // %translate([Peg3X + padFullX/2 - flatPadLength/2, 0, leafBaseThickness])
  //   cube([flatPadLength, keyBaseWidth, leafZOffset(3)]);
  // %translate([Peg5X + padFullX/2 - flatPadLength/2, 0, leafBaseThickness])
  //   cube([flatPadLength, keyBaseWidth, leafZOffset(5)]);
  rollerCoaster([
                  [[0, "absolute"], [0, "absolute"]],
                  [[leafStartX, "absolute"], [0, "absolute"]],
                  [[Peg5X, "absolute"], [29.5, "absolute"]],
                  [flatPadLength, 0],
                  [0.5, -20],
                  [[Peg3X, "absolute"], [25.5, "absolute"]],
                  [flatPadLength, 0],
                  [0.5, -15],
                  [[Peg1X, "absolute"], [13.5, "absolute"]],
                  [flatPadLength, 0],
                  [0.5, -12],
                  [2, [1, "absolute"]]
                  //[[bottomRowBaseLength, "absolute"], [0.5, "absolute"]], // 142.5
                  ],
                keyBaseWidth, keyRoundingRadius,
                xAbsRelDefault="relative",
                zAbsRelDefault="relative"
    );

}

module singlePeg(){
  // A single peg that fits into the peg holes with some tolerance
  // The peg holes are pegSize x pegSize, so we scale down slightly
  pegTolerance = 0.95;  // Slightly smaller for easier insertion and glue space

  // Use the same offset as padPegHole() to align with the actual hole position
  // padPegHole() uses: translate([((padFullX - pegSize) / 2), keyWallWidth, -0.25])
  // We need to center the hole, then account for the scaling shifting the center
  pegOffsetX = (padFullX - pegSize) / 2 + pegSize * (1 - pegTolerance) / 2;
  pegOffsetY = keyWallWidth + pegSize * (1 - pegTolerance) / 2;

  translate([pegOffsetX, pegOffsetY, -3.5])
    scale([pegTolerance, pegTolerance, 1])
      cube([pegSize, pegSize, 3.5]);
}

module pegsBottomRow(){
  // Pegs positioned under each main body section for bottom row (rows 0, 2, 4)

  // Peg for row 0 (farthest from back)
  translate([Peg0X, 0, 0])
    singlePeg();

  // Peg for row 2 (middle)
  translate([Peg2X, 0, 0])
    singlePeg();

  // Peg for row 4 (closest to back)
  translate([Peg4X, 0, 0])
    singlePeg();
}

module pegsTopRow(){
  // Pegs positioned under each main body section for top row (rows 1, 3, 5)

  // Peg for row 1 (farthest from back)
  translate([Peg1X, 0, 0])
    singlePeg();

  // Peg for row 3 (middle)
  translate([Peg3X, 0, 0])
    singlePeg();

  // Peg for row 5 (closest to back)
  translate([Peg5X, 0, 0])
    singlePeg();
}


module topRowLeaf(){
  union() {
    sharedLeafBack();
    mainLeafTopRow();
    pegsTopRow();
  };
}
module bottomRowLeaf(){
  union() {
    sharedLeafBack();
    mainLeafBottomRow();
    pegsBottomRow();
  };
}

// Demo module to visualize the leaf toppers
module demoLeafToppers(){
  // Show bottom row key base (rotated 180° around X axis, semi-transparent)
  %translate([0, 0, 0])
    rotate([180, 0, 0])
      translate([0, -keyBaseWidth, 0])
        color("gray", alpha=0.3)
          bottomRowKeyWithHoles();

  // Show bottom row leaf on top of key base
  translate([0, 0, 0])
    //color("lightblue")
      bottomRowLeaf();

  // Show top row key base (rotated 180° around X axis, semi-transparent)
  %translate([0, keyBaseWidth + 1, 0])
    rotate([180, 0, 0])
      translate([0, -keyBaseWidth, 0])
        color("gray", alpha=0.3)
          topRowKeyWithHoles();

  // Show top row leaf on top of key base
  translate([0, keyBaseWidth + 1, 0])
    //color("lightgreen")
      topRowLeaf();
}

%demoLeafToppers();
