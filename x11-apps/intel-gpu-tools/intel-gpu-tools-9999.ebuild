# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-apps/intel-gpu-tools/intel-gpu-tools-1.3.ebuild,v 1.5 2012/11/18 12:07:31 ago Exp $

EAPI=4
inherit xorg-2

DESCRIPTION="Intel GPU userland tools"
KEYWORDS="~amd64 ~x86"
IUSE="doc video_cards_nouveau"
RESTRICT="test"

DEPEND="dev-libs/glib:2
	>=x11-libs/cairo-1.12.0
	>=x11-libs/libdrm-2.4.47[video_cards_intel,video_cards_nouveau?]
	>=x11-libs/libpciaccess-0.10
	doc? ( dev-util/gtk-doc )"
RDEPEND="${DEPEND}"

src_prepare() {
	# automake expects gtk-doc.make, but file is in .gitignore
	# replicate autogen.sh output
	use doc || echo "EXTRA_DIST =" > ./gtk-doc.make
	use doc || echo "CLEANFILES =" >> ./gtk-doc.make
	xorg-2_src_prepare
}

src_configure() {
	XORG_CONFIGURE_OPTIONS=(
		$(use_enable doc gtk-doc)
		$(use_enable video_cards_nouveau nouveau)
	)
	xorg-2_src_configure
}
