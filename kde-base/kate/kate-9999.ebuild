# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KDE_HANDBOOK="true"
EGIT_BRANCH="frameworks"
KMNAME="kate"

inherit kde5

DESCRIPTION="Kate is an MDI texteditor."
HOMEPAGE="http://www.kde.org/applications/utilities/kate http://kate-editor.org"

KEYWORDS=""
IUSE=""

DEPEND="
	$(add_frameworks_dep attica)
	$(add_kdebase_dep baloo)
	$(add_kdebase_dep baloo-widgets)
	$(add_frameworks_dep kactivities)
	$(add_frameworks_dep karchive)
	$(add_frameworks_dep kbookmarks)
	$(add_frameworks_dep kcmutils)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep kdelibs4support)
	$(add_frameworks_dep kdesu)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep knewstuff)
	$(add_frameworks_dep kparts)
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtscript:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	sys-libs/zlib"
RDEPEND="${DEPEND}
	!kde-base/kate:4"

KMEXTRA="
        addons/kate
        addons/plasma
"
src_configure() {
	kde5_src_configure
}