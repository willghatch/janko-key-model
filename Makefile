all: stl/bottom-key.stl stl/top-key.stl stl/bottom-key-pegs.stl stl/top-key-pegs.stl stl/peg-set.stl stl/pad-top-placement-peg.stl stl/pad-top-blank.stl stl/leaf-key-top.stl stl/leaf-key-bottom.stl

# These are additional targets that I'm disabling for now.  I don't love the textures I for tactile distinguishing of keys, and they won't work nicely with the newly rounded key toppers without more work.  As the rounded keys are more important to me than the textures, I'm leaving them off for now because I want to get something printed that won't injure my fingers while playing.
#stl/pad-tops_pink.stl stl/pad-tops_red_no-pink.stl stl/pad-tops_green.stl stl/pad-tops_blue.stl

stl/%.stl: %.scad stl key-base.scad
	openscad -o $@ $<

stl:
	mkdir -p stl

.PHONY: clean
clean:
	rm -rf stl
