read -p "This is really fucking dangerous. Do you really wish to proceed? (y/n): " yn

if [ "$yn" == "y" ]; then
sudo bash << EOF
mv /usr/lib/firefox/firefox-bin /usr/lib/firefox/true-firefox-bin
cat > /usr/lib/firefox/firefox-bin << EOF2
#!/bin/bash
export MOZ_USE_XINPUT2=1
exec /usr/lib/firefox/true-firefox-bin "\\\$@"
EOF2
chmod +x /usr/lib/firefox/firefox-bin
EOF
fi
