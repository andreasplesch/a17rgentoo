# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 python3_{4,5} )
PYTHON_REQ_USE="xml"

inherit python-single-r1

DESCRIPTION="Translation tool for XML documents that uses gettext files and ITS rules"
HOMEPAGE="http://itstool.org/"
SRC_URI="http://files.itstool.org/itstool/${P}.tar.bz2"

# files in /usr/share/itstool/its are HPND/as-is || GPL-3
LICENSE="GPL-3+ || ( HPND GPL-3+ )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~arm-linux ~x86-linux"
IUSE=""

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}
	dev-libs/libxml2[python,${PYTHON_USEDEP}]"
RDEPEND="${DEPEND}"

DOCS=( ChangeLog NEWS ) # AUTHORS, README are empty

PATCHES=(
	"${FILESDIR}/${P}"-utf8.patch
	"${FILESDIR}/${P}"-py3.patch
	"${FILESDIR}/${P}"-fix-merging-translations.patch
)

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	python_fix_shebang .
}
