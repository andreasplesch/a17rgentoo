# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils toolchain-funcs

DESCRIPTION="Simple Desktop Display Manager"
HOMEPAGE="https://github.com/sddm/sddm"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://github.com/sddm/sddm.git"
	inherit git-2
	SRC_URI=""
else
	SRC_URI="http://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
fi

LICENSE="GPL-2+ MIT CC-BY-3.0 public-domain"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+qt4 qt5"
REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND="sys-libs/pam
	sys-power/upower
	x11-libs/libxcb
	qt4? ( dev-qt/qtdeclarative:4 )
	qt5? ( dev-qt/qtdeclarative:5 )"
DEPEND="${RDEPEND}
	>=sys-devel/gcc-4.7.0"

pkg_pretend() {
	[[ $(gcc-version) < 4.7 ]] && \
		die 'The active compiler needs to be gcc 4.7 (or newer)'
}

src_prepare() {
	# respect our cflags
	sed -e 's|-Wall -march=native||' \
		-e 's|-O2||' \
		-i CMakeLists.txt || die 'sed failed'
	# use our location
	sed -e 's|AuthDir=/var/run/xauth|AuthDir=/run/sddm|' \
		-i data/sddm.conf.in
	# Replace XSession file with lxdm version
	cp -a "${FILESDIR}"/Xsession data/scripts
}

src_configure() {
	local mycmakeargs=( $(cmake-utils_use_use qt5 QT5) )
	cmake-utils_src_configure
}
