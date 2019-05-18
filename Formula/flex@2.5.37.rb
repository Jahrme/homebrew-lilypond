class FlexAT2537 < Formula
  desc "Fast Lexical Analyzer, generates Scanners (tokenizers)"
  homepage "https://github.com/westes/flex"
  url "https://github.com/westes/flex/archive/flex-2.5.37.tar.gz"
  sha256 "36fae15f7b62212ecbd8f0d8724ab83b14f3ae27d4a36cdf7f161e4bf960236a"

  keg_only :provided_by_macos, "some formulae require a newer version of flex"

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  depends_on "gettext"
  depends_on "texinfo"
  depends_on "gnu-sed"

  def install
    # "I couldn't get texi2dvi to successfully process the documentation
    # (it made the build process choke and die) so I deke out that part of the
    # build. I also skip building the test directory." Source: 
    # https://danieljohnson.name/blog/installing-lilypond-on-macos
    system "gsed -i -e '/doc \\/d' -e '/tests/d' -e 's/tools \\/tools/' Makefile.am"
    system "gsed -i -e '/doc\/Makefile/d' -e '/tests\/Makefile/d' -e '/tests\/.*\/Makefile/d' configure.in"
    # Release did not run autotools, so we have to.
    system "./autogen.sh"
    args = [
      "--disable-dependency-tracking",
      "--prefix=#{prefix}",
    ]
    system "./configure", *args
    system "make", "all"
    system "make", "install"
  end
end
