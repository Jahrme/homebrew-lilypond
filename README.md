# Homebrew LilyPond

This is a tap enabling the installation of [LilyPond](http://lilypond.org)
using [Homebrew](https://brew.sh). This comes with some caveats including the
issue that Homebrew has chosen to distance themselves from anything related to
LaTeX which includes several dependencies of LilyPond.

## Instructions

To install LilyPond, run the following commands after installing Homebrew:

```console
foo@bar:~$ brew cask install xquartz mactex-no-gui
foo@bar:~$ sudo tlmgr update --self && sudo tlmgr update --all
foo@bar:~$ brew tap jahrme/lilypond
foo@bar:~$ brew install lilypond
```

For instructions on installing Homebrew, see [their website](https://brew.sh).

## Notes

Following the above instructions will install the entirety of
[MacTeX](https://www.tug.org/mactex/) (minus the GUI applications) which is
a multi-gigabyte download. If you want the GUI applications to be installed,
replace `mactex-no-gui` with `mactex` in the above commands. On the other hand,
if you would like to install a smaller collection of packages you may replace
`mactex-no-gui` with `basictex`, however this may require you to use `tlmgr` to
install programs that are not provided by `basictex`.

## Further Work

Currently this tap is successful in installing the stable release of LilyPond
(2.18.2), however the development version (2.19.83) fails to compile due to an
issue with `clang` vs `gcc`. Any assistance in remedying this issue is welcome.
