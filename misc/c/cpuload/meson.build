project('cpuload', 'c', version : '0.1', license : 'LGPL')

cc = meson.get_compiler('c')

thread_dep = dependency('threads')

executable('cpuload', 'cpuload.c', dependencies : [thread_dep])
