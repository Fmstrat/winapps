# WinApps for Linux

Run Windows apps such as Microsoft Office/Adobe in Linux (Ubuntu/Fedora) and GNOME/KDE as if they were a part of the native OS, including Nautilus integration for right clicking on files of specific mime types to open them.

<img src="demo/demo.gif" width=1000>

***Proud to have made the top spot on [r/linux](https://www.reddit.com/r/linux) on launch day.***

## How it works
WinApps was created as an easy, one command way to include apps running inside a VM (or on any RDP server) directly into GNOME as if they were native applications. WinApps works by:
- Running a Windows RDP server in a background VM container
- Checking the RDP server for installed applications such as Microsoft Office
- If those programs are installed, it creates shortcuts leveraging FreeRDP for both the CLI and the GNOME tray
- Files in your home directory are accessible via the `\\tsclient\home` mount inside the VM
- You can right click on any files in your home directory to open with an application, too

## Currently supported applications
### WinApps supports ***ANY*** installed application on your system.

It does this by:
1. Scanning your system for offically configured applications (below)
2. Scanning your system for any other EXE files with install records in the Windows Registry

Any officially configured applications will have support for high-resolution icons and mime types for automatically detecting what files can be opened by each application. Any other detected executable files will leverage the icons pulled from the EXE.

Note: The officially configured application list below is fueled by the community, and therefore some apps may be untested by the WinApps team.

<table cellpadding="10" cellspacing="0" border="0">
  <tr>
    <td><img src="apps/acrobat-x-pro/icon.svg" width="100"></td><td>Adobe Acrobat Pro<br>(X)</td>
    <td><img src="apps/acrobat-reader-dc/icon.svg" width="100"></td><td>Adobe Acrobat Reader<br>(DC)</td>
  </tr>
  <tr>
    <td><img src="apps/aftereffects-cc/icon.svg" width="100"></td><td>Adobe After Effects<br>(CC)</td>
    <td><img src="apps/audition-cc/icon.svg" width="100"></td><td>Adobe Audition<br>(CC)</td>
  </tr>
  <tr>
    <td><img src="apps/bridge-cs6/icon.svg" width="100"></td><td>Adobe Bridge<br>(CS6, CC)</td>
    <td><img src="apps/adobe-cc/icon.svg" width="100"></td><td>Adobe Creative Cloud<br>(CC)</td>
  </tr>
  <tr>
    <td><img src="apps/illustrator-cc/icon.svg" width="100"></td><td>Adobe Illustrator<br>(CC)</td>
    <td><img src="apps/indesign-cc/icon.svg" width="100"></td><td>Adobe InDesign<br>(CC)</td>
  </tr>
  <tr>
    <td><img src="apps/lightroom-cc/icon.svg" width="100"></td><td>Adobe Lightroom<br>(CC)</td>
    <td><img src="apps/photoshop-cc/icon.svg" width="100"></td><td>Adobe Photoshop<br>(CS6, CC)</td>
  </tr>
  <tr>
    <td><img src="apps/premiere-pro-cc/icon.svg" width="100"></td><td>Adobe Premiere Pro<br>(CC)</td>
    <td><img src="apps/authy/icon.svg" width="100"></td><td>Authy</td>
  </tr>
  <tr>
    <td><img src="apps/cmd/icon.svg" width="100"></td><td>Command Prompt<br>(cmd.exe)</td>
    <td><img src="apps/explorer/icon.svg" width="100"></td><td>Explorer<br>(File Manager)</td>
  </tr>
  <tr>
    <td><img src="apps/iexplorer/icon.svg" width="100"></td><td>Internet Explorer<br>(11)</td>
    <td><img src="apps/access/icon.svg" width="100"></td><td>Microsoft Access<br>(2016, 2019, o365)</td>
  </tr>
  <tr>
    <td><img src="apps/excel/icon.svg" width="100"></td><td>Microsoft Excel<br>(2016, 2019, o365)</td>
    <td><img src="apps/word/icon.svg" width="100"></td><td>Microsoft Word<br>(2016, 2019, o365)</td>
  </tr>
  <tr>
    <td><img src="apps/onenote/icon.svg" width="100"></td><td>Microsoft OneNote<br>(2016, 2019, o365)</td>
    <td><img src="apps/outlook/icon.svg" width="100"></td><td>Microsoft Outlook<br>(2016, 2019, o365)</td>
  </tr>
  <tr>
    <td><img src="apps/powerpoint/icon.svg" width="100"></td><td>Microsoft PowerPoint<br>(2016, 2019, o365)</td>
    <td><img src="apps/project/icon.svg" width="100"></td><td>Microsoft Project<br>(2016, 2019, o365)</td>
  </tr>
  <tr>
    <td><img src="apps/publisher/icon.svg" width="100"></td><td>Microsoft Publisher<br>(2016, 2019, o365)</td>
    <td><img src="apps/powershell/icon.svg" width="100"></td><td>Powershell<br>(Standard, Core)</td>
  </tr>
  <tr>
    <td><img src="apps/vs-enterprise-2019/icon.svg" width="100"></td><td>Visual Studio<br>(2019 - Ent|Pro|Com)</td>
    <td><img src="icons/windows.svg" width="100"></td><td>Windows<br>(Full RDP session)</td>
  </tr>
</table>

## Documentation

Latest documentation available at: [https://nowsci.com/winapps/](https://nowsci.com/winapps/)

