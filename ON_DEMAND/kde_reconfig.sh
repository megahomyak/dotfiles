#!/bin/bash
set -euo pipefail
kwriteconfig5 --file kdeglobals --group KScreen --key ScaleFactor 1.5
kwriteconfig5 --file kwalletrc --group Wallet --key Enabled false
