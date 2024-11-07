for file in /usr/share/applications/krita_*.desktop /usr/share/applications/org.kde.krita.desktop; do
    sed -i 's/^Exec=/Exec=env QT_XCB_TABLET_LEGACY_COORDINATES=1 /' $file
done
