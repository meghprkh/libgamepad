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

if get_option('enable_docs')
    libgamepad_docs = run_command('valadoc',
                                  '--pkg=gio-2.0',
                                  '--directory=docs',
                                  '--package-name=libgamepad',
                                  '--package-version=1.0',
                                  '--force',
                                  meson.current_build_dir() + '/src/libgamepad.vapi')
endif
