class TexliveLy < Formula
  desc "Dependencies for LilyPond from TeXLive"
  homepage "http://lilypond.org"
  url "file:///dev/null"
  version "1.0"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    bin.mkpath
    texbin = "/Library/TeX/texbin"
    programs = [
      "kpsewhich",
      "mf",
      "mf-nowin",
      "mpost",
    ]
    programs.each do |prog|
      ln_sf "#{texbin}/#{prog}", "#{bin}/#{prog}"
    end
  end

  def caveats; <<-EOS
    Lilypond requires updated components from texlive provided by MacTex.
    MacTeX can be installed using homebrew:

      brew cask install mactex-no-gui

    After installation, the texlive componens must be updated:

      sudo tlmgr update --self && sudo tlmgr update --all

    Some components of MacTeX depend on X11 which is available through homebrew:

      brew cask install xquartz
  EOS
  end

  test do
    system "#{bin}/kpsewhich", "--version"
    system "#{bin}/mf", "--version"
    system "#{bin}/mf-nowin", "--version"
    system "#{bin}/mpost", "--version"
  end
end
