vala_sources += [
    'guid-helpers.vala',
    'raw-gamepad.vala',
    'raw-gamepad-monitor.vala',
]

vala_args += [
    '--pkg=posix',
    '--pkg=linux',
    '--vapidir=' + meson.current_source_dir() + '/vapis/'
]

gudev = dependency('gudev-1.0')
libevdev = dependency('libevdev')

vala_deps += [gudev, libevdev]
