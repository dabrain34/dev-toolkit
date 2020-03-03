project('XEventTest', 'c', version : '0.1', license : 'LGPL')

cc = meson.get_compiler('c')

x11_dep = dependency('x11', required: false)
executable('XEventTest', 'main.c', dependencies : [x11_dep])
