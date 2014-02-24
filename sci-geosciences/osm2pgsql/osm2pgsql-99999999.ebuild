# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/osm2pgsql/osm2pgsql-99999999.ebuild,v 1.9 2014/01/29 00:06:26 titanofold Exp $

EAPI=5

inherit autotools subversion

ESVN_REPO_URI="http://svn.openstreetmap.org/applications/utils/export/${PN}/"
ESVN_PROJECT="${PN}"

DESCRIPTION="Converts OSM planet.osm data to a PostgreSQL/PostGIS database"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Osm2pgsql"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+lua +pbf"

DEPEND="
	app-arch/bzip2
	dev-db/postgresql-base
	dev-libs/libxml2:2
	sci-libs/geos
	sci-libs/proj
	sys-libs/zlib
	lua? ( dev-lang/lua )
	pbf? ( dev-libs/protobuf-c )
"
RDEPEND="${DEPEND}"

DOCS=( README 900913.sql )
