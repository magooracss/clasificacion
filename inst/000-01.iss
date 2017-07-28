#define MyAppName "Clasificacion"
#define MyAppVersion "0.1"
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
OutputBaseFilename=clasificadorSetup
Compression=lzma
SolidCompression=yes

[Languages]
Name: "spanish"; MessagesFile: "compiler:Languages\Spanish.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; 
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "C:\magoo\job\clasificacion\inst\entrada\clasificador.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\magoo\job\clasificacion\inst\entrada\programa.cfg"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\magoo\job\clasificacion\inst\entrada\configurador.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\magoo\job\clasificacion\inst\entrada\upddb.exe"; DestDir: "{app}\bin"; Flags: ignoreversion
Source: "C:\magoo\job\clasificacion\inst\entrada\clasificador.fdb"; DestDir: "{app}\db"; Flags: ignoreversion


[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"
Name: "{group}\{cm:ProgramOnTheWeb,{#MyAppName}}"; Filename: "{#MyAppURL}"
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\bin\{#MyAppExeName}"; Flags: nowait postinstall skipifsilent; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"
            