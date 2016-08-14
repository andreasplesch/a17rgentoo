# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

MY_PV="${PV/_}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="Amiga emulator based on WinUAE emulation code"
HOMEPAGE="https://fs-uae.net/"
SRC_URI="https://fs-uae.net/fs-uae/stable/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	media-libs/libsdl2[joystick,opengl,X]
	media-libs/openal
	media-libs/libpng:0=
	dev-libs/glib:2
	sys-libs/zlib
	media-libs/freetype:2
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"