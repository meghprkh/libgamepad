vala_sources = [
    'gamepad-monitor.vala',
    'gamepad.vala',
    'helpers.vala',
    'input-type.vala',
    'mapping-error.vala',
    'mapping-helpers.vala',
    'mappings-manager.vala',
    'mapping.vala',
    'standard-gamepad-axis.vala',
    'standard-gamepad-button.vala',
    'drivers/interface/raw-gamepad-monitor.vala',
    'drivers/interface/raw-gamepad.vala',
]

vala_deps = [glib, gobject, gio]

subdir('drivers')

library = shared_library('libgamepad',
                         vala_sources,
                         vala_args: ['--vapi=libgamepad.vapi', '--header=libgamepad.h'],
                         install: true,
                         dependencies : vala_deps + [driver])

install_headers(meson.current_build_dir() + '/../libgamepad.h')

pkg_mod = import('pkgconfig')
pkg_mod.generate(libraries : library,
                 version : '1.0',
                 name : 'libgamepad',
                 filebase : 'libgamepad',
                 description : 'A Library to barnicate your foos.')

# library_dep = declare_dependency(include_directories: include_directories('.'),
#                                  link_with: library)
#
# subdir('test')
