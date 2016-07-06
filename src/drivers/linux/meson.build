driver_vala_sources = [
    'guid-helpers.vala',
    'raw-gamepad.vala',
    'raw-gamepad-monitor.vala',
    '../../helpers.vala'
]

driver_vala_args = [
    '--pkg=posix',
    '--pkg=linux',
    '--vapidir=' + meson.current_source_dir() + '/vapis/'
]

gudev = dependency('gudev-1.0')
libevdev = dependency('libevdev')

driver_lib = library('driver',
                     driver_vala_sources,
                     vala_args: driver_vala_args,
                     dependencies: vala_deps + [gudev, libevdev, driver_interface])

driver = declare_dependency(include_directories: include_directories('.'),
                            link_with: driver_lib)
