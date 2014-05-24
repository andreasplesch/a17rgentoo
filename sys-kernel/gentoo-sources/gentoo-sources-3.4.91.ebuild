# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-kernel/gentoo-sources/gentoo-sources-3.4.86.ebuild,v 1.1 2014/04/04 00:33:39 mpagano Exp $

EAPI="5"
ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="71"
K_DEBLOB_AVAILABLE="1"
inherit kernel-2
detect_version
detect_arch

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
HOMEPAGE="http://dev.gentoo.org/~mpagano/genpatches"
IUSE="deblob"

DESCRIPTION="Full sources including the Gentoo patchset for the ${KV_MAJOR}.${KV_MINOR} kernel tree"
SRC_URI="${KERNEL_URI} ${GENPATCHES_URI} ${ARCH_URI}"

src_prepare() {
	epatch "${FILESDIR}/3.4.83-backport_direct_firmware_loading.patch"

	# backport introduction of SO_REUSEPORT to fix avahi compatibility
	epatch "${FILESDIR}"/3.4.89-backport-01-named-constants-for-sk_reuse.patch \
		"${FILESDIR}"/3.4.89-backport-02-merge-branch-soreuseport.patch \
		"${FILESDIR}"/3.4.89-backport-03-remove-leftover-endif.patch
}

pkg_postinst() {
	kernel-2_pkg_postinst
	einfo "For more info on this patchset, and how to report problems, see:"
	einfo "${HOMEPAGE}"
}

pkg_postrm() {
	kernel-2_pkg_postrm
}
