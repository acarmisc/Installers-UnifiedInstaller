#!/bin/sh

# script to build a UI tarball; requires a ~/nobackup/work directory.
# packages should already be updated; particularly the
# build-cache tarball.

WORK_DIR=~/nobackup/work

NEWVER=4.1.2

SDIR=`pwd`

cd $WORK_DIR
rm -r Plone-${NEWVER}-UnifiedInstaller Plone-${NEWVER}-UnifiedInstaller.tgz

cd $SDIR
svn export . $WORK_DIR/Plone-${NEWVER}-UnifiedInstaller
rm $WORK_DIR/Plone-${NEWVER}-UnifiedInstaller/buildme.sh
rm $WORK_DIR/Plone-${NEWVER}-UnifiedInstaller/*.ac
rm $WORK_DIR/Plone-${NEWVER}-UnifiedInstaller/update_packages.py
rm $WORK_DIR/Plone-${NEWVER}-UnifiedInstaller/to-do.txt
cp -r packages $WORK_DIR/Plone-${NEWVER}-UnifiedInstaller/packages

cd $WORK_DIR/Plone-${NEWVER}-UnifiedInstaller

echo "Getting docs"
wget http://pypi.python.org/packages/source/P/Plone/Plone-${NEWVER}.tar.gz
tar xf Plone-${NEWVER}.tar.gz
rm Plone-${NEWVER}.tar.gz
mv Plone-${NEWVER}/docs Plone-docs
rm -r Plone-${NEWVER}

find . -name "._*" -exec rm {} \;
find . -name ".DS_Store" -exec rm {} \;
find . -type f -exec chmod 644 {} \;
chmod 755 install.sh base_skeleton/bin/*
find . -type d -exec chmod 755 {} \;


cd $WORK_DIR
gnutar --owner 0 --group 0 -zcf Plone-${NEWVER}-UnifiedInstaller.tgz Plone-${NEWVER}-UnifiedInstaller
rm -r Plone-${NEWVER}-UnifiedInstaller
tar zxf Plone-${NEWVER}-UnifiedInstaller.tgz
cd Plone-${NEWVER}-UnifiedInstaller
