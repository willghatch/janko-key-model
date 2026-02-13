// rollerCoaster module.


// Helper function to find the index of the previous non-null X before index i (inclusive)
function prevNonNullXIndex(xzPairs, i) =
  i < 0 ? -1 :
  xzPairs[i][0] != undef ? i :
  prevNonNullXIndex(xzPairs, i-1);

// Helper function to find the index of the next non-null X after index i (inclusive)
function nextNonNullXIndex(xzPairs, i) =
  i >= len(xzPairs) ? -1 :
  xzPairs[i][0] != undef ? i :
  nextNonNullXIndex(xzPairs, i+1);

// Helper function to replace null Z values with previous Z value (forward fill)
function fillZNulls(xzPairs, i=0, prevZ=undef) =
  i >= len(xzPairs) ? [] :
  let(
    currentZ = xzPairs[i][1] != undef ? xzPairs[i][1] : prevZ
  )
  concat([[xzPairs[i][0], currentZ]], fillZNulls(xzPairs, i+1, currentZ));

// Helper function to replace null X values with interpolated values
function fillXNulls(xzPairs, i=0) =
  i >= len(xzPairs) ? [] :
  xzPairs[i][0] != undef ?
    concat([[xzPairs[i][0], xzPairs[i][1]]], fillXNulls(xzPairs, i+1)) :
    let(
      prevIdx = prevNonNullXIndex(xzPairs, i-1),
      nextIdx = nextNonNullXIndex(xzPairs, i+1),
      prevX = xzPairs[prevIdx][0],
      nextX = xzPairs[nextIdx][0],
      totalSteps = nextIdx - prevIdx,
      currentStep = i - prevIdx,
      interpolatedX = prevX + (nextX - prevX) * currentStep / totalSteps
    )
    concat([[interpolatedX, xzPairs[i][1]]], fillXNulls(xzPairs, i+1));

// Helper function to check if a coordinate is in [value, mode] format
function hasMode(coord) =
  is_list(coord) && len(coord) == 2 && is_string(coord[1]);

// Helper function to extract the numeric value from a coordinate
// Handles both plain numbers and [number, mode] format
function getCoordValue(coord) =
  hasMode(coord) ? coord[0] : coord;

// Helper function to determine if a coordinate should be treated as relative
// Returns true if relative, false if absolute, undef if coord is undef
// defaultMode should be "absolute" or "relative"
function isCoordRelative(coord, defaultMode) =
  coord == undef ? undef :
  hasMode(coord) ? (coord[1] == "relative") :
  (defaultMode == "relative");

// Preprocess coordinates: convert all to absolute, handling per-coordinate mode overrides
// Each coordinate can be:
//   - A number (uses the default mode for that axis)
//   - [number, "absolute"] (always treated as absolute)
//   - [number, "relative"] (always treated as relative)
//   - undef (preserved as undef)
function preprocessCoordinates(xzPairs, xDefaultMode, zDefaultMode, i=0, accumX=0, accumZ=0) =
  i >= len(xzPairs) ? [] :
  let(
    xCoord = xzPairs[i][0],
    zCoord = xzPairs[i][1],

    xValue = getCoordValue(xCoord),
    zValue = getCoordValue(zCoord),

    xIsRelative = isCoordRelative(xCoord, xDefaultMode),
    zIsRelative = isCoordRelative(zCoord, zDefaultMode),

    newX = xValue == undef ? undef :
           xIsRelative ? accumX + xValue : xValue,
    newZ = zValue == undef ? undef :
           zIsRelative ? accumZ + zValue : zValue,

    nextAccumX = newX != undef ? newX : accumX,
    nextAccumZ = newZ != undef ? newZ : accumZ
  )
  concat([[newX, newZ]], preprocessCoordinates(xzPairs, xDefaultMode, zDefaultMode, i+1, nextAccumX, nextAccumZ));

module rollerCoaster(xzPairs, thickness, roundingRadius, xAbsRelDefault="absolute", zAbsRelDefault="absolute") {
  // xzPairs is a list of (pair) lists like [[x1,z1], [x2,z2], [x3,z3]].
  // The x coordinates are offsets, and the z coordinates are heights.
  // Elements can have undef x or z coordinates to represent null values.
  // For X: undef values are replaced with evenly spaced values between surrounding non-undef X values
  //        (first and last element must have non-undef X)
  // For Z: undef values are replaced with the previous Z value (forward fill)
  //        (first element must have non-undef Z)
  // Between x coordinates, the surface slopes between adjacent z heights.
  // The module is basically equally thick in Y.
  // However, the top has a rounded radius on the sides.
  //
  // xAbsRelDefault and zAbsRelDefault specify the default interpretation mode for coordinates.
  // Can be "absolute" or "relative". When "relative", coordinates are interpreted as offsets
  // from the previous coordinate, starting from an implicit (0, 0).
  // Individual coordinates can override the default mode by using [value, "absolute"] or [value, "relative"].

  // Preprocess coordinates: convert all to absolute, handling per-coordinate mode overrides
  absolutePairs = preprocessCoordinates(xzPairs, xAbsRelDefault, zAbsRelDefault);

  // Process null values in the input
  processedPairs = fillXNulls(fillZNulls(absolutePairs));

  segmentWidth = 0.001;  // Small width for each segment point

  if (roundingRadius > 0) {
    // Calculate bounds
    minX = min([for (pair = processedPairs) pair[0]]);
    maxX = max([for (pair = processedPairs) pair[0]]);
    maxZ = max([for (pair = processedPairs) pair[1]]);

    difference() {
      // translate down by the rounding radius so that it doesn't make it taller than it was supposed to be.
      translate([0,0,-roundingRadius*2])
      minkowski() {
        // Core shape, lifted by roundingRadius so bottom will be at Z=0 after minkowski
        // Hull each adjacent pair separately to allow valleys and peaks
        for (i = [0 : len(processedPairs) - 2]) {
          hull() {
            translate([processedPairs[i][0], roundingRadius, roundingRadius])
              cube([segmentWidth, thickness - 2*roundingRadius, processedPairs[i][1]]);
            translate([processedPairs[i+1][0], roundingRadius, roundingRadius])
              cube([segmentWidth, thickness - 2*roundingRadius, processedPairs[i+1][1]]);
          }
        }

        // Sphere for uniform rounding
        sphere(r=roundingRadius, $fn=16);
      }

      // Cut off anything below Z=0
      translate([minX - roundingRadius - 1, -1, -roundingRadius - 10])
        cube([maxX - minX + 2*roundingRadius + 2, thickness + 2, 10]);

      // Cut off anything past the left edge
      translate([minX - roundingRadius*2, -1, -roundingRadius-1])
        cube([roundingRadius*2, thickness + 2, maxZ * 2 + roundingRadius * 2 + 1]);

      // Cut off anything past the right edge
      translate([maxX, -1, -roundingRadius-1])
        cube([roundingRadius*2, thickness + 2, maxZ*2 + roundingRadius * 2 + 1]);
    }
  } else {
    // No rounding - just create the base shape
    // Hull each adjacent pair separately to allow valleys and peaks
    for (i = [0 : len(processedPairs) - 2]) {
      hull() {
        translate([processedPairs[i][0], 0, 0])
          cube([segmentWidth, thickness, processedPairs[i][1]]);
        translate([processedPairs[i+1][0], 0, 0])
          cube([segmentWidth, thickness, processedPairs[i+1][1]]);
      }
    }
  }
}
