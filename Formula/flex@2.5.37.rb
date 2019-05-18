class FlexAT2537 < Formula
  desc "Fast Lexical Analyzer, generates Scanners (tokenizers)"
  homepage "https://github.com/westes/flex"
  url "https://github.com/westes/flex/archive/flex-2.5.37.tar.gz"
  sha256 "36fae15f7b62212ecbd8f0d8724ab83b14f3ae27d4a36cdf7f161e4bf960236a"

  keg_only :provided_by_macos, "some formulae require a newer version of flex"

  depends_on "gettext"

  def install
    args = [
      "--disable-dependency-tracking",
      "--prefix=#{prefix}",
    ]
    system "./configure", *args
    system "make", "all"
    system "make", "install"
  end
end
