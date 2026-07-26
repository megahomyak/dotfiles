#!/bin/bash
set -euo pipefail
echo 'Run this with `sudo` if it doesnt work'
for file in /usr/share/applications/krita_*.desktop /usr/share/applications/org.kde.krita.desktop; do
    echo "Patching $file"
    sed -i 's/^Exec=/Exec=env QT_XCB_TABLET_LEGACY_COORDINATES=1 /' "$file"
done
