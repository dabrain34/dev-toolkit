project('thread_sched', 'c', version : '0.1', license : 'LGPL')

cc = meson.get_compiler('c')

thread_dep = dependency('threads')

executable('thread_sched', 'thread_sched.c', dependencies : [thread_dep])
