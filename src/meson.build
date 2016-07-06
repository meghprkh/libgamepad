vala_sources = [
    'gamepad-monitor.vala',
    'gamepad.vala',
    'helpers.vala',
    'input-type.vala',
    'mapping-error.vala',
    'mapping-helpers.vala',
    'mappings-manager.vala',
    'mapping.vala',
    'raw-gamepad-interface.vala',
    'raw-gamepad-monitor-interface.vala',
    'standard-gamepad-axis.vala',
    'standard-gamepad-button.vala',
]

vala_args = [
    '--library=libgamepad-1.0',
    '--shared-library=libgamepad',
    '--vapi=libgamepad.vapi',
    '--header=libgamepad.h',
    '--gir=libgamepad-1.0.gir'
]

vala_deps = [glib, gobject, gio]

# Linux

vala_sources += [
    'drivers/linux/guid-helpers.vala',
    'drivers/linux/raw-gamepad.vala',
    'drivers/linux/raw-gamepad-monitor.vala',
]

vala_args += [
    '--pkg=posix',
    '--pkg=linux',
    '--vapidir=' + meson.current_source_dir() + '/drivers/linux/vapis/'
]

gudev = dependency('gudev-1.0')
libevdev = dependency('libevdev')

vala_deps += [gudev, libevdev]


# Main library

library = shared_library('libgamepad',
                         vala_sources,
                         vala_args: vala_args,
                         install: true,
                         dependencies : vala_deps)

install_headers(meson.current_build_dir() + '/../libgamepad.h')
install_data('libgamepad.deps', install_dir: 'share/vala/vapi')

pkg_mod = import('pkgconfig')
pkg_mod.generate(requires: 'gio-2.0',
                 libraries : library,
                 version : meson.project_version(),
                 name : 'LibGamepad',
                 filebase : 'libgamepad',
                 description : 'A simple library to handle gamepads.')

# library_dep = declare_dependency(include_directories: include_directories('.'),
#                                  link_with: library)
#
# subdir('test')
