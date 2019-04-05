class TexliveLy < Formula
  desc "Dependencies for LilyPond from TeXLive"
  homepage "http://lilypond.org"
  url "file:///dev/null"
  version "1.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on :x11

  programs = [
    "kpsewhich",
    "mf",
    "mf-nowin",
    "mpost",
    "bibtex",
    "pdflatex",
    "pdfetex",
    "pdftex",
    "etex",
  ]

  def install
    bin.mkpath
    texbin = "/Library/TeX/texbin"
    programs.each do |prog|
      ln_sf "#{texbin}/#{prog}", "#{bin}/#{prog}"
    end
  end

  def caveats; <<-EOS
    Lilypond requires updated components from texlive provided by MacTex.
    Some components of MacTeX depend on X11 which is provided by XQuartz.

    MacTeX (and XQuartz) can be installed using homebrew cask:

      brew cask install xquartz mactex-no-gui

    After installation, the texlive components must be updated:

      sudo tlmgr update --self && sudo tlmgr update --all
  EOS
  end

  test do
    programs.each do |prog|
      system "#{bin}/#{prog}", "--version"
    end
  end
end
