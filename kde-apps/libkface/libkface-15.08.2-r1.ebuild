# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit kde4-base

DESCRIPTION="Qt/C++ wrapper around LibFace to perform face recognition and detection"
HOMEPAGE="http://api.kde.org/4.x-api/kdegraphics-apidocs/libs/libkface/libkface/html/index.html"

LICENSE="GPL-2"
IUSE=""

KEYWORDS="~amd64 ~x86"

DEPEND=">=media-libs/opencv-3.0.0[contrib]"
RDEPEND="${DEPEND}
	!media-libs/libkface"

PATCHES=( "${FILESDIR}/${PN}-15.08.2-opencv3.patch" )

src_configure() {
	local mycmakeargs=(
		-DENABLE_OPENCV3=ON
	)

	kde5_src_configure
}
