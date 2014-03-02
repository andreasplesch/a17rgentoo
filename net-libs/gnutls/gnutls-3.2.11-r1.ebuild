# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnutls/gnutls-3.2.11.ebuild,v 1.4 2014/02/17 09:35:44 alonbl Exp $

EAPI=5

inherit autotools-multilib libtool eutils versionator

DESCRIPTION="A TLS 1.2 and SSL 3.0 implementation for the GNU project"
HOMEPAGE="http://www.gnutls.org/"
SRC_URI="ftp://ftp.gnutls.org/gcrypt/gnutls/v$(get_version_component_range 1-2)/${P}.tar.xz"

# LGPL-3 for libgnutls library and GPL-3 for libgnutls-extra library.
# soon to be relicensed as LGPL-2.1 unless heartbeat extension enabled.
LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE_LINGUAS=" en cs de fi fr it ms nl pl sv uk vi zh_CN"
IUSE="+cxx +crywrap dane doc examples guile nls pkcs11 static-libs test zlib ${IUSE_LINGUAS// / linguas_}"
# heartbeat support is not disabled until re-licensing happens fullyf

# NOTICE: sys-devel/autogen is required at runtime as we
# use system libopts
RDEPEND=">=dev-libs/libtasn1-3.2[${MULTILIB_USEDEP}]
	>=dev-libs/nettle-2.7[gmp,${MULTILIB_USEDEP}]
	dev-libs/gmp[${MULTILIB_USEDEP}]
	sys-devel/autogen[${MULTILIB_USEDEP}]
	crywrap? ( net-dns/libidn )
	dane? ( net-dns/unbound[${MULTILIB_USEDEP}] )
	guile? ( >=dev-scheme/guile-1.8[networking] )
	nls? ( virtual/libintl[${MULTILIB_USEDEP}] )
	pkcs11? ( >=app-crypt/p11-kit-0.11[${MULTILIB_USEDEP}] )
	zlib? ( >=sys-libs/zlib-1.2.3.1[${MULTILIB_USEDEP}] )
	abi_x86_32? (
		!<=app-emulation/emul-linux-x86-baselibs-20131008-r9
		!app-emulation/emul-linux-x86-baselibs[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}
	>=sys-devel/automake-1.11.6
	virtual/pkgconfig
	doc? ( dev-util/gtk-doc )
	nls? ( sys-devel/gettext )
	test? ( app-misc/datefudge )"

DOCS=( AUTHORS ChangeLog NEWS README THANKS doc/TODO )

use_enable_binaries() {
	if false && multilib_build_binaries; then
		use_enable "$@"
	else
		local flag="$1"
		local name="${2:-${flag}}"
		echo "--disable-${name}"
	fi
}

src_prepare() {
	# tests/suite directory is not distributed
	sed -i \
		-e ':AC_CONFIG_FILES(\[tests/suite/Makefile\]):d' \
		-e '/^AM_INIT_AUTOMAKE/s/-Werror//' \
		configure.ac || die

	sed -i \
		-e 's/imagesdir = $(infodir)/imagesdir = $(htmldir)/' \
		doc/Makefile.am || die

	# force regeneration of autogen-ed files
	local file
	for file in $(grep -l AutoGen-ed src/*.c) ; do
		rm src/$(basename ${file} .c).{c,h} || die
	done

	# support user patches
	epatch_user

	eautoreconf

	# Use sane .so versioning on FreeBSD.
	elibtoolize

	# bug 497472
	use cxx || epunt_cxx

	multilib_copy_sources
}

multilib_src_configure() {
	LINGUAS="${LINGUAS//en/en@boldquot en@quot}"

	# TPM needs to be tested before being enabled
	# hardware-accell is disabled on OSX because the asm files force
	#   GNU-stack (as doesn't support that) and when that's removed ld
	#   complains about duplicate symbols
	ECONF_SOURCE="${S}" econf \
		--htmldir="${EPREFIX}/usr/share/doc/${PF}/html" \
		--disable-valgrind-tests \
		--enable-heartbeat-support \
		$(use_enable cxx) \
		$(use_enable dane libdane) \
		$(use_enable_binaries doc gtk-doc) \
		$(use_enable_binaries doc gtk-doc-pdf) \
		$(multilib_is_native_abi \
			&& use_enable guile guile "${EPREFIX}/usr/$(get_libdir)" \
			|| echo --disable-guile) \
		$(use_enable crywrap) \
		$(use_enable nls) \
		$(use_enable static-libs static) \
		$(use_with pkcs11 p11-kit) \
		$(use_with zlib) \
		--without-tpm \
		$([[ ${CHOST} == *-darwin* ]] && echo --disable-hardware-acceleration)
}

multilib_src_test() {
	# parallel testing often fails
	emake -j1 check
}

multilib_src_install_all() {
	prune_libtool_files

	dodoc doc/certtool.cfg

	if use doc; then
		dodoc doc/gnutls.pdf
		dohtml doc/gnutls.html
	fi

	if use examples; then
		docinto examples
		dodoc doc/examples/*.c
	fi
}
