@echo off
:: Solicitar ao usuário o disco de instalação
echo Qual disco deseja usar para instalar o servidor? (exemplo: C, D, E)
set /p INSTALL_DRIVE="Digite a letra do disco (sem dois pontos): "

:: Validar a entrada do usuário
if "%INSTALL_DRIVE%"=="" (
    echo Nenhuma entrada detectada. Saindo...
    pause
    exit /b
)

:: Verificar se o disco existe
if not exist %INSTALL_DRIVE%:\ (
    echo O disco %INSTALL_DRIVE%:\ nao existe. Saindo...
    pause
    exit /b
)

:: Diretórios de instalação
set STEAMCMD_DIR=%INSTALL_DRIVE%:\steamcmd
set SQUAD_SERVER_DIR=%INSTALL_DRIVE%:\squad_server

:: URLs para download das dependências
set VCREDIST2013_URL=https://download.microsoft.com/download/1/2/2/122AD78B-2173-4CD9-8358-429DF4DA4B6C/vcredist_x64.exe
set VCREDIST2015_URL=https://aka.ms/vs/17/release/vc_redist.x64.exe
set DIRECTX_URL=https://download.microsoft.com/download/8/1/3/813E47B8-A5E3-4A94-8B71-310C7E22636A/directx_Jun2010_redist.exe
set STEAMCMD_URL=https://steamcdn-a.akamaihd.net/client/installer/steamcmd.zip

:: Instalação de dependências
echo Downloading Visual C++ Redistributables and DirectX...
mkdir %TEMP%\squad_setup
curl -L -o %TEMP%\squad_setup\vcredist2013.exe %VCREDIST2013_URL%
curl -L -o %TEMP%\squad_setup\vcredist2015.exe %VCREDIST2015_URL%
curl -L -o %TEMP%\squad_setup\directx.exe %DIRECTX_URL%

echo Installing Visual C++ Redistributables and DirectX...
start /wait %TEMP%\squad_setup\vcredist2013.exe /quiet /norestart
start /wait %TEMP%\squad_setup\vcredist2015.exe /quiet /norestart
start /wait %TEMP%\squad_setup\directx.exe /Q

:: Baixando SteamCMD
echo Downloading SteamCMD...
mkdir %STEAMCMD_DIR%
curl -L -o %TEMP%\squad_setup\steamcmd.zip %STEAMCMD_URL%
tar -xf %TEMP%\squad_setup\steamcmd.zip -C %STEAMCMD_DIR%

:: Configurando e atualizando o servidor Squad
echo Setting up Squad server...
mkdir %SQUAD_SERVER_DIR%
echo @ShutdownOnFailedCommand 1 > %STEAMCMD_DIR%\update_squad.txt
echo @NoPromptForPassword 1 >> %STEAMCMD_DIR%\update_squad.txt
echo force_install_dir %SQUAD_SERVER_DIR% >> %STEAMCMD_DIR%\update_squad.txt
echo login anonymous >> %STEAMCMD_DIR%\update_squad.txt
echo app_update 403240 validate >> %STEAMCMD_DIR%\update_squad.txt
echo quit >> %STEAMCMD_DIR%\update_squad.txt

%STEAMCMD_DIR%\steamcmd.exe +runscript %STEAMCMD_DIR%\update_squad.txt

:: Criando script de inicialização
echo Creating start_server.bat...
echo @echo off > %SQUAD_SERVER_DIR%\start_server.bat
echo "%SQUAD_SERVER_DIR%\SquadGame\Binaries\Win64\SquadGameServer.exe" Port=7787 QueryPort=27165 FIXEDMAXPLAYERS=80 beaconport=15000 RANDOM=NONE -log >> %SQUAD_SERVER_DIR%\start_server.bat

:: Limpeza de arquivos temporários
echo Cleaning up...
rmdir /S /Q %TEMP%\squad_setup

echo Squad server installation complete. Run start_server.bat in %SQUAD_SERVER_DIR% to start the server.
pause
