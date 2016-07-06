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
]

vala_args = []
vala_deps = [glib, gobject, gio]

subdir('drivers')

library = shared_library('libgamepad',
                         vala_sources,
                         vala_args: vala_args,
                         dependencies : vala_deps)
