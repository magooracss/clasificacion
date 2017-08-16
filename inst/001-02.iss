#define MyAppName "Clasificacion"
#define MyAppVersion "1.2"
#define MyAppPublisher "RACSS Programacion"
#define MyAppURL "http://www.racss.com.ar/clasificacion"
#define MyAppExeName "clasificador.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{7B2D4402-1AE6-4B7F-B928-DB4451C751EA}}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName=C:\RACSS\{#MyAppName}
DisableDirPage=yes
DefaultGroupName={#MyAppName}
AllowNoIcons=yes
OutputDir=C:\magoo\job\clasificacion\inst\salida
OutputBaseFilename=clasificadorUpd1-2
Compression=lzma
SolidCompression=yes
InfoBeforeFile=C:\magoo\job\clasificacion\doc\changes.txt

[Languages]
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; 
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "C:\magoo\job\clasificacion\inst\entrada\clasificador.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\magoo\job\clasificacion\doc\changes.txt"; DestDir: "{app}"; Flags: ignoreversion


[Run]
Filename: "{app}\bin\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"