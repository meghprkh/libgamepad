driver_interface_vala_sources = [
    'raw-gamepad.vala',
    'raw-gamepad-monitor.vala',
]

driver_interface_lib = library('driver_interface',
                               driver_interface_vala_sources,
                               dependencies: [vala_deps])

driver_interface = declare_dependency(include_directories: include_directories('.'),
                                      link_with: driver_interface_lib)
