#!/bin/bash

version="0.7.0"
release="1"

rm -rf build/
mkdir -p build/
git clone https://github.com/pynag/pynag.git build/pynag-${version}
cd build/pynag-${version}
git checkout pynag-${version}-${release}

cp -r ../../debian .

# Prepare source for RPM
#cd ..
#tar czf pynag-${version}+kaji.tar.gz pynag-${version}
#cd -
# Prepare source for DEB
patch -p1 < ../../kaji/pynag.spec.patch
python setup.py build
rm -rf build/
cd ..

tar czf pynag_${version}+kaji.orig.tar.gz pynag-${version}
cd pynag-${version}

dpkg-buildpackage -tc -us -uc


# copy patches
#cp debian/patches/*.patch ../../../opensusebuildservice/home\:sfl-monitoring/shinken
# copy deb files
cd ..
cp pynag*.changes pynag*.dsc pynag*.tar.xz pynag*.tar.gz ../
cp ../kaji/add_shinken_compat.patch ../
