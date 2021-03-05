=== Using virtme===

As virtme allows to run a kernel with a virtual machine (qemu), it can be interesting to have on the host this virtme dedicated to test plugins such as v4l2src and kmssink.

Here is a [blog](https://www.collabora.com/news-and-blog/blog/2018/09/18/virtme-the-kernel-developers-best-friend/) I got inspiration to setup this virtme.

Download and setup virtme with the following:

```
$ git clone https://github.com/ezequielgarcia/virtme.git
$ cd virtme
$ sudo ./setup.py install
```

Download the kernel.
```
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
```

Configure the kernel:

```
$ cd linux
$ virtme-configkernel --defconfig
```
Replace `.config` by the file {F271678} and run:

```
$ make -j4
```

And then run the qemu/virtme with:

```
$ virtme-run --kdir . --graphics --net --script-dir ../../scripts --qemu-opts -vga virtio
```

As you can see there is a `--script-dir` argument which can be removed but I advised to use it to initalize the keyboad layout by example.

Then you should be able to run a pipeline with the libs from your system. As the rootfs is mounted readonly, its recommended to use a small script to use your artifacts from a previous build.

```
$ gst-launch-1.0 videotestsrc num-buffers=10 ! kmssink driver-name=virtio_gpu force-modesetting=1
```

We can use the [vivid driver](https://www.kernel.org/doc/html/v5.5/media/v4l-drivers/vivid.html) to test capture pipelines:
```
# gst-launch-1.0 v4l2src device=/dev/video3 ! fakevideosink -v
```

We can also use interlace alternate capture by switching to the `TV 0` channel:
```
# v4l2-ctl -d /dev/video3 -n
# Check the input number for TV 0 (1 here)
# v4l2-ctl -d /dev/video3 -i 1
# gst-launch-1.0 v4l2src device=/dev/video3 ! video/x-raw\(format:Interlaced\) ! fakevideosink -v
```

