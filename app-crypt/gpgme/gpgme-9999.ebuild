# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

EGIT_REPO_URI="git://git.gnupg.org/gpgme.git"
PYTHON_COMPAT=( python2_7 python3_{4,5} )
DISTUTILS_OPTIONAL=1

inherit autotools distutils-r1 eutils git-r3 qmake-utils

DESCRIPTION="GnuPG Made Easy is a library for making GnuPG easier to use"
HOMEPAGE="http://www.gnupg.org/related_software/gpgme"
[[ ${PV} = 9999 ]] || SRC_URI="mirror://gnupg/gpgme/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2.1"
SLOT="1/11" # subslot = soname major version
[[ ${PV} = 9999 ]] || \
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x64-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="common-lisp static-libs cxx python qt5"

COMMON_DEPEND="app-crypt/gnupg
	>=dev-libs/libassuan-2.0.2
	>=dev-libs/libgpg-error-1.11
	python? ( ${PYTHON_DEPS} )
	qt5? ( dev-qt/qtcore:5 )
"
DEPEND="${COMMON_DEPEND}
	python? ( dev-lang/swig )
	qt5? ( dev-qt/qttest:5 )
"
	#doc? ( app-doc/doxygen[dot] )
RDEPEND="${COMMON_DEPEND}
	cxx? (
		!kde-apps/gpgmepp
		!kde-apps/kdepimlibs:4
	)
"

REQUIRED_USE="qt5? ( cxx )"

PATCHES=( "${FILESDIR}"/${PN}-1.1.8-et_EE.patch )

do_python() {
	if use python; then
		pushd lang/python > /dev/null || die
		distutils-r1_src_${EBUILD_PHASE}
		popd > /dev/null
	fi
}

src_unpack() {
	git-r3_src_unpack
}

src_prepare() {
	default
	eautoreconf
	do_python
}

src_configure() {
	local languages=()
	use common-lisp && languages+=( "cl" )
	use cxx && languages+=( "cpp" )
	if use qt5; then
		languages+=( "qt" )
		#use doc ||
		export DOXYGEN=true
		export MOC="$(qt5_get_bindir)/moc"
	fi

	econf \
		--enable-languages="${languages[*]}" \
		$(use_enable static-libs static)

	use python && make -C lang/python prepare

	do_python
}

src_compile() {
	default
	do_python
}

src_install() {
	default
	do_python
	prune_libtool_files
}
