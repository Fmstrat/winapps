#!/usr/bin/env bash

if [[ $EUID -ne 0 ]]; then
  echo "Please run as sudo."
  exit 1
fi

sudo ls > /dev/null

echo "Installing..."

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
. "${DIR}/bin/winapps" install

# Check for installed apps
echo -n "  Checking for installed apps in RDP machine..."
rm -f ${HOME}/.winapps.installed.bat
rm -f ${HOME}/.winapps.installed
for F in $(ls "${DIR}/apps"); do
	. "${DIR}/apps/${F}/info"
	echo "IF EXIST \"${WIN_EXECUTABLE}\" ECHO ${F} >> \\\\tsclient\\home\\.winapps.installed" >> ${HOME}/.winapps.installed.bat
done;
touch ${HOME}/.winapps.installed
LAST_RAN=$(stat -t -c %Y ${HOME}/.winapps.installed)
sleep 6
xfreerdp /u:"${RDP_USER}" /p:"${RDP_PASS}" /v:${RDP_IP} +auto-reconnect +home-drive -wallpaper /span /wm-class:"RDPInstaller" /app:"C:\Windows\System32\cmd.exe" /app-icon:"${DIR}/../icons/windows.svg" /app-cmd:"/C \\\\tsclient\\home\\.winapps.installed.bat" 1> /dev/null 2>&1 &
sleep 6
THIS_RUN=$(stat -t -c %Y ${HOME}/.winapps.installed)
while (( $THIS_RUN - $LAST_RAN < 5 )); do
	sleep 5
	THIS_RUN=$(stat -t -c %Y ${HOME}/.winapps.installed)
done
echo ""

# Install apps
for F in $(cat "${HOME}/.winapps.installed" |sed 's/\r/\n/g'); do
	. "${DIR}/apps/${F}/info"
	echo -n "  Configuring ${NAME}..."
	sudo rm -f "/usr/share/applications/${F}.desktop"
	echo "[Desktop Entry]
Name=${NAME}
Exec=${DIR}/bin/winapps ${F} %F
Terminal=false
Type=Application
Icon=${DIR}/apps/${F}/icon.svg
StartupWMClass=${FULL_NAME}
Comment=${FULL_NAME}
Categories=${CATEGORIES}
MimeType=${MIME_TYPES}
" |sudo tee "/usr/share/applications/${F}.desktop" > /dev/null
	sudo rm -f "/usr/local/bin/${F}"
	echo "#!/usr/bin/env bash
${DIR}/bin/winapps ${F} $@
" |sudo tee "/usr/local/bin/${F}" > /dev/null
	sudo chmod a+x "/usr/local/bin/${F}"
	echo " Finished."
done
rm -f "${HOME}/.winapps.installed"
rm -f "${HOME}/.winapps.installed.bat"

# Install windows
echo -n "  Configuring Windows..."
sudo rm -f "/usr/share/applications/windows.desktop"
echo "[Desktop Entry]
Name=Windows
Exec=${DIR}/bin/winapps windows %F
Terminal=false
Type=Application
Icon=${DIR}/icons/windows.svg
StartupWMClass=Micorosoft Windows
Comment=Micorosoft Windows
Categories=Windows
" |sudo tee "/usr/share/applications/windows.desktop" > /dev/null
sudo rm -f "/usr/local/bin/windows"
echo "#!/usr/bin/env bash
${DIR}/bin/winapps windows
" |sudo tee "/usr/local/bin/windows" > /dev/null
sudo chmod a+x "/usr/local/bin/windows"
echo " Finished."

echo "Installation complete."
