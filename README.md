libgamepad
=========

This is a GLib/GObject-based library written in Vala to simplify interactions with gamepads. It aims to be cross-platform (though currently it is Linux-only). It is also compatible with the SDL mapping format and thus is compatible with the huge list of mappings from the community maintained SDL mapping database.

Building
========
This project is built using cmake (so make sure you have cmake installed). Its cmake configuration is built using the awesome [autovala](https://github.com/rastersoft/autovala) (required only for development).
```
mkdir install
cd install
cmake .. -DBUILD_VALADOC=ON
make
sudo make install
sudo ldconfig
```

Running
=======
This comes with a sample test program `libgamepadtest`. You can run it to test the program.
