require 'formula'

class GstLibav < Formula
  homepage 'http://gstreamer.freedesktop.org'
  url 'http://gstreamer.freedesktop.org/src/gst-libav/gst-libav-1.2.1.tar.xz'
  mirror 'http://ftp.osuosl.org/pub/blfs/svn/g/gst-libav-1.2.1.tar.xz'
  sha256 'fd152b7aec56ae76ad58b9759913a8bfe1792bdf64f260d0acaba75b75076676'

  head do
    url 'git://anongit.freedesktop.org/gstreamer/gst-libav'

    depends_on :automake
    depends_on :libtool
    depends_on "gettext"
  end

  depends_on "pkg-config" => :build
  depends_on "yasm" => :build
  depends_on "gst-plugins-base"

  def install
    args = %W[
      --prefix=#{prefix}
      --disable-debug
      --disable-dependency-tracking
    ]

    if build.head?
      ENV["NOCONFIGURE"]="yes"
      system "./autogen.sh"
    end

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system "#{Formula.factory("gstreamer").opt_prefix}/bin/gst-inspect-1.0", "libav"
  end
end
