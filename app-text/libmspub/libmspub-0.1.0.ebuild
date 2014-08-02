# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/libmspub/libmspub-9999.ebuild,v 1.6 2013/07/09 06:15:44 scarabeus Exp $

EAPI=5

EGIT_REPO_URI="git://anongit.freedesktop.org/git/libreoffice/${PN}/"
inherit base eutils
[[ ${PV} == 9999 ]] && inherit autotools git-2

DESCRIPTION="Library parsing the Microsoft Publisher documents"
HOMEPAGE="https://wiki.documentfoundation.org/DLP/Libraries/libmspub"
[[ ${PV} == 9999 ]] || SRC_URI="http://dev-www.libreoffice.org/src/${PN}/${P}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="0"

# Don't move KEYWORDS on the previous line or ekeyword won't work # 399061
[[ ${PV} == 9999 ]] || \
KEYWORDS="~amd64 ~arm ~ppc ~x86"

IUSE="doc static-libs"

RDEPEND="
	app-text/libwpd:0.9
	app-text/libwpg:0.2
	dev-libs/icu:=
	dev-libs/librevenge
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	dev-libs/boost
	sys-devel/libtool
	doc? ( app-doc/doxygen )
"

src_prepare() {
	base_src_prepare
	[[ -d m4 ]] || mkdir "m4"
	[[ ${PV} == 9999 ]] && eautoreconf
}

src_configure() {
	econf \
		--docdir="${EPREFIX}/usr/share/doc/${PF}" \
		$(use_enable static-libs static) \
		--disable-werror \
		$(use_with doc docs)
}

src_install() {
	default
	prune_libtool_files --all
}
