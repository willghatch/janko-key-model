Janko Key Model
===============

This has some scad files for generating Janko keyboard keys to replace the normal keys on a MIDI keyboard.

Specifically I've written it specifically for the M-Audio Keystation 49e keyboard.
But the keys of several keyboards, including several other M-Audio keyboards, are very similar.  For many, I would only need to change the part of the key that rests at the back where it hinges.

This is the first non-trivial thing I've ever modeled.  So be warned that I made some poor early decisions that I just ran with to finish the model.


To download and build, for Linux or other sufficiently Unix-y things:

* You need `openscad` and (to follow these instructions, at least) `git` and GNU `make` installed to build it.

* You need to get the git submodule `Round-Anything`, not just the main git repository.  Run `git clone --recursive https://github.com/willghatch/janko-key-model` to get the repo with submodule.

* In the repository, run `make`, and it will build the STL files in a directory called `stl`.  Alternatively, just use `openscad` on the files directly in a manner you are accustomed to, if you normally use the openscad GUI and don't know what `make` is and these instructions don't make sense to you.

If you really want to print this and you can't figure out how to build the STL files, I could probably be convinced to put the STL files in so you can download them from github rather than building them.  Feel free to email me (william@hatch.uno) about it, or about Janko keyboard stuff in general.
