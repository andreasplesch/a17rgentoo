# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_PN="Caledonia-KSplash"
MY_PV=${PV}
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="This is the Caledonia KSplash theme"
HOMEPAGE="http://caledonia.sourceforge.net/get.html"
SRC_URI="mirror://sourceforge/caledonia/Caledonia%20KSplash/${MY_P}.tar.gz"

LICENSE="CC-BY-SA-3.0"
KEYWORDS="~amd64 ~x86"
SLOT="0"

RDEPEND="kde-base/ksplash"

S="${WORKDIR}/${MY_PN}"

DOCS="INSTALL LICENSE"

src_install() {
	rm GET\ MORE\ CALEDONIA\ STUFF || die

	dodoc ${DOCS}
	rm ${DOCS} || die

	# Important: Install folder must have original theme name
	local my_d="/usr/share/apps/ksplash/Themes/${MY_PN}"
	mkdir -p "${D}/${my_d}" || die "Install failed!"
	cp -R "${S}/"* "${D}/${my_d}" || die "Install failed!"
}
