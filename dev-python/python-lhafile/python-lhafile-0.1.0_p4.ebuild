# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit distutils-r1

MY_P="${P/_p/fs}"

DESCRIPTION="LHA Archive Support for Python"
HOMEPAGE="http://fengestad.no/python-lhafile/"
SRC_URI="http://fengestad.no/python-lhafile/${MY_P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"
