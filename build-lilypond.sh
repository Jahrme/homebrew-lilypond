#!/usr/bin/env sh
set -ev
cwd=$(pwd)

# VERSION
LILY_MAJOR=2
LILY_MINOR=19
LILY_PATCH=83

# Directory / Archive / URL
LILY_DIR="lilypond-$LILY_MAJOR.$LILY_MINOR.$LILY_PATCH"
LILY_SRC_URL="http://lilypond.org/download/source"
LILY_URL="$LILY_SRC_URL/v$LILY_MAJOR.$LILY_MINOR/$LILY_DIR.tar.gz"

LILY_ABS_DIR="$cwd/$LILY_DIR"
LILY_BUILD_DIR="$cwd/lily-build"
LILY_PREFIX_DIR="$cwd/lily-prefix"

# Download and Expand
curl "$LILY_URL" | tar xz
mkdir "$LILY_BUILD_DIR"
mkdir "$LILY_PREFIX_DIR"

# Build Settings
tex_bin_dir="/Library/TeX/texbin"
tex_gyre_dir="/usr/local/texlive/2019/texmf-dist/fonts/opentype/texgyre"

export PATH="$tex_bin_dir:$PATH"
export CPPFLAGS="-I/usr/local/include"
export LDFLAGS="-L/usr/local/lib"

# Configure
cd "$LILY_BUILD_DIR" && \
CC=/usr/local/bin/gcc-7 \
CXX=/usr/local/bin/g++-7 \
CPP=/usr/local/bin/cpp-7 \
sh "$LILY_ABS_DIR/configure" \
	--disable-debugging \
	--disable-documentation \
	--disable-guile2 \
	--disable-optimising \
	--disable-pipe \
	--disable-profiling \
	--with-texgyre-dir="$tex_gyre_dir" \
	--prefix="$LILY_PREFIX_DIR"

# Build and Package
make --debug=v --directory="$LILY_BUILD_DIR" all && \
make --debug=v --directory="$LILY_BUILD_DIR" install
