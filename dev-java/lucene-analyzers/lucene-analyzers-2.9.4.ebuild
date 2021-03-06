# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

JAVA_PKG_IUSE="source"
inherit java-pkg-2 java-ant-2 java-osgi

MY_PN="${PN/lucene-}"
MY_P="${P/-${MY_PN}}"

DESCRIPTION="Lucene Analyzers additions"
HOMEPAGE="http://lucene.apache.org/java"
SRC_URI="mirror://apache/lucene/java/${MY_P}-src.tar.gz"
LICENSE="Apache-2.0"
SLOT="2.9"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~x86-linux ~amd64-linux"
IUSE=""
DEPEND=">=virtual/jdk-1.7"
RDEPEND=">=virtual/jre-1.7"

S="${WORKDIR}/${MY_P}/contrib/${MY_PN}/common"

src_install() {
	java-osgi_newjar-fromfile "${WORKDIR}/${MY_P}/build/contrib/${MY_PN}/common/${P}-dev.jar" \
			"${FILESDIR}/manifest" "Apache Lucene Analysis"

	use source && java-pkg_dosrc "${S}/src/java/org"
}
