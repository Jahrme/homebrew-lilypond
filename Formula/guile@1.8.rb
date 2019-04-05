class GuileAT18 < Formula
  desc "GNU Ubiquitous Intelligent Language for Extensions"
  homepage "https://www.gnu.org/software/guile/"
  url "https://ftp.gnu.org/gnu/guile/guile-1.8.8.tar.gz"
  mirror "https://ftpmirror.gnu.org/gnu/guile/guile-1.8.8.tar.gz"
  sha256 "c3471fed2e72e5b04ad133bbaaf16369e8360283679bcf19800bc1b381024050"

  depends_on "bdw-gc"
  depends_on "gmp"
  depends_on "libffi"
  depends_on "libtool"
  depends_on "libunistring"
  depends_on "pkg-config"
  depends_on "readline"

  def install
    args = [
      "--disable-dependency-tracking",
      "--prefix=#{prefix}",
      "--with-libgmp-prefix=#{Formula["gmp"].opt_prefix}",
      "--with-libreadline-prefix=#{Formula["readline"].prefix}",
    ]
    system "./configure", *args
    system "make", "all"
    system "make", "install"

    # A really messed up workaround required on OS X --mkhl
    lib.cd { Dir["*.dylib"].each { |p| ln_sf p, File.basename(p, ".dylib")+".so" } }
  end

  test do
    hello = testpath/"hello.scm"
    hello.write <<~EOS
      (display "Hello World")
      (newline)
    EOS

    system bin/"guile", hello
  end
end
