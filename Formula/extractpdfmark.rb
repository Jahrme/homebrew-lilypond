class Extractpdfmark < Formula
  desc "Extract page mode and named destinations as PDFmark from PDF"
  homepage "https://github.com/trueroad/extractpdfmark"
  version "1.1.0"
  url "https://github.com/trueroad/extractpdfmark/releases/download/v1.1.0/extractpdfmark-1.1.0.tar.gz"
  sha256 "0935045084211fcf68a9faaba2b65c037d0adfd7fa27224d2b6c7ae0fd7964cb"

  depends_on "pkg-config" => :build

  depends_on "libiconv"
  depends_on "poppler"

  def install
    args = [
      "--disable-codecvt",
      "--prefix=#{prefix}",
    ]
    system "./configure", *args
    system "make", "all"
    system "make", "install"
  end
end
