project('LibGamepad', ['vala', 'c'],
        version: '1.0.0',
        license: 'LGPL',
        meson_version: '>=0.31')

glib = dependency('glib-2.0', version: '>=2.32')
gobject = dependency('gobject-2.0', version: '>=2.32')
gio = dependency('gio-2.0', version: '>=2.32')


subdir('data')
subdir('src')

if get_option('enable_test')
    subdir('libgamepadtest')
endif

meson.add_install_script('install.sh')
