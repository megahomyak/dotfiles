#!/bin/bash
set -euo pipefail
printf '%s\n' 'XKBOPTIONS="caps:swapescape"' | sudo tee -a /etc/default/keyboard
