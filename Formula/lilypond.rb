class Lilypond < Formula
  desc "GNU Music Engraving Program"
  homepage "http://lilypond.org"
  url "http://lilypond.org/download/source/v2.18/lilypond-2.18.2.tar.gz"
  sha256 "329d733765b0ba7be1878ae3f457dbbb875cc2840d2b75af4afc48c9454fba07"

  devel do
    url "http://lilypond.org/download/source/v2.19/lilypond-2.19.83.tar.gz"
    sha256 "96ba4f4b342d21057ad74d85d647aea7e47a5c24f895127c2b3553a252738fb3"
  end

  # Dependencies for LilyPond
  depends_on "flex@2.5.37" => :build
  depends_on "pkg-config" => :build

  depends_on "docbook"
  depends_on "fondu"
  depends_on "fontforge"
  depends_on "gettext"
  depends_on "ghostscript"
  depends_on "guile@1.8"
  depends_on "imagemagick"
  depends_on "mftrace"
  depends_on "netpbm"
  depends_on "pango"
  depends_on "texi2html"
  depends_on "texinfo"
  depends_on "texlive-ly"

  resource "texgyre" do
    url "http://www.gust.org.pl/projects/e-foundry/tex-gyre/whole/tg2_501otf.zip"
    sha256 "d7f8be5317bec4e644cf16c5abf876abeeb83c43dbec0ccb4eee4516b73b1bbe"
  end

  def install
    texgyre_dir = (share/"fonts/opentype/texgyre")
    resource("texgyre").stage do
      texgyre_files = [
        "texgyreadventor-bold.otf",
        "texgyreadventor-bolditalic.otf",
        "texgyreadventor-italic.otf",
        "texgyreadventor-regular.otf",
        "texgyrebonum-bold.otf",
        "texgyrebonum-bolditalic.otf",
        "texgyrebonum-italic.otf",
        "texgyrebonum-regular.otf",
        "texgyrechorus-mediumitalic.otf",
        "texgyrecursor-bold.otf",
        "texgyrecursor-bolditalic.otf",
        "texgyrecursor-italic.otf",
        "texgyrecursor-regular.otf",
        "texgyreheros-bold.otf",
        "texgyreheros-bolditalic.otf",
        "texgyreheros-italic.otf",
        "texgyreheros-regular.otf",
        "texgyreheroscn-bold.otf",
        "texgyreheroscn-bolditalic.otf",
        "texgyreheroscn-italic.otf",
        "texgyreheroscn-regular.otf",
        "texgyrepagella-bold.otf",
        "texgyrepagella-bolditalic.otf",
        "texgyrepagella-italic.otf",
        "texgyrepagella-regular.otf",
        "texgyreschola-bold.otf",
        "texgyreschola-bolditalic.otf",
        "texgyreschola-italic.otf",
        "texgyreschola-regular.otf",
        "texgyretermes-bold.otf",
        "texgyretermes-bolditalic.otf",
        "texgyretermes-italic.otf",
        "texgyretermes-regular.otf",
      ]
      mkdir_p texgyre_dir
      texgyre_dir.install *texgyre_files
    end

    args = [
      "--prefix=#{prefix}",
      "--enable-rpath",
      "--disable-documentation",
    ]

    args_stable = [
      "--with-ncsb-dir=#{Formula["ghostscript"].share}/ghostscript/fonts/",
    ]

    args_devel = [
      "--with-texgyre-dir=#{texgyre_dir}",
    ]

    args += args_stable if build.stable?
    args += args_devel if build.devel?

    system "./configure", *args
    system "make", "all"
    system "make", "install"
  end

  test do
    (testpath/"test.ly").write <<-EOS.undent
      \\header { title = "Do-Re-Mi" }
      { c' d' e' }
    EOS
    system "#{bin}/lilypond", "test.ly"
  end
end
