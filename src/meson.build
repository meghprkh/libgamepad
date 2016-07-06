vala_sources = [
    'drivers/interface/raw-gamepad-monitor-interface.vala',
    'drivers/interface/raw-gamepad-interface.vala',
    'drivers/linux/guid-helpers.vala',
    'drivers/linux/raw-gamepad-monitor.vala',
    'drivers/linux/raw-gamepad.vala',
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
]

gudev = dependency('gudev-1.0')

library = shared_library('libgamepad',
                         vala_sources,
                         vala_args: ['--verbose', '--pkg=posix', '--pkg=linux', '--vapidir=../src/drivers/linux/vapis/', '--pkg=libevdev'],
                         dependencies : [glib, gobject, gio, gudev])
