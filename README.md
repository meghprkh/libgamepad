libgamepad
=========

This is a GLib/GObject-based library written in Vala to simplify interactions with gamepads. It aims to be cross-platform (though currently it is Linux-only). It is also compatible with the SDL mapping format and thus is compatible with the huge list of mappings from the community maintained SDL mapping database.

Building
========
This project is built using [mesonbuild](http://mesonbuild.com/) (so make sure you have mesonbuild installed).

```
mkdir build
meson build
cd build
ninja-build
sudo ninja-build install
sudo ldconfig
```

Running
=======
This comes with a sample test program `libgamepadtest`. You can run it to test the program.
