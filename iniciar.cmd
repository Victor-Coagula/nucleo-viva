@echo off
rem ============================================================
rem  Inicia o site Nucleo Viva (Java + frontend HTML/CSS/JavaScript).
rem  Se necessario, baixa um JDK 25 e o Maven para a pasta .mvn.
rem ============================================================
setlocal
cd /d "%~dp0"

if not exist "config\application.properties" (
  echo.
  echo Falta config\application.properties. Copie o arquivo de exemplo e defina a senha do administrador.
  pause
  exit /b 1
)

set "JAVA_VERSAO=25"
set "JDK_RAIZ=%~dp0.mvn\jdk-%JAVA_VERSAO%"
set "JAVA_HOME="
set "JAVA_OK=0"

rem Reutiliza um JDK local ja baixado.
for /d %%D in ("%JDK_RAIZ%\jdk-*") do if exist "%%~fD\bin\java.exe" set "JAVA_HOME=%%~fD"
if defined JAVA_HOME set "JAVA_OK=1"

rem Usa o Java do sistema se for compativel; caso contrario prepara um JDK local.
if "%JAVA_OK%"=="0" (
  where java >nul 2>nul
  if not errorlevel 1 (
    where javac >nul 2>nul
    if not errorlevel 1 (
      powershell -NoProfile -ExecutionPolicy Bypass -Command "$v = (& java -version 2>&1 | Select-String -Pattern 'version.+?([0-9]+)' | Select-Object -First 1); if ($v -and [int]$v.Matches[0].Groups[1].Value -ge %JAVA_VERSAO%) { exit 0 } else { exit 1 }"
      if not errorlevel 1 (
        set "JAVA_OK=1"
      )
    )
  )
)

if "%JAVA_OK%"=="0" (
  echo.
  echo JDK %JAVA_VERSAO% nao encontrado. Baixando o Eclipse Temurin para este projeto...
  if not exist "%JDK_RAIZ%" mkdir "%JDK_RAIZ%"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $zip=Join-Path '%JDK_RAIZ%' 'jdk.zip'; Invoke-WebRequest -UseBasicParsing -Uri 'https://api.adoptium.net/v3/binary/latest/%JAVA_VERSAO%/ga/windows/x64/jdk/hotspot/normal/eclipse' -OutFile $zip; Expand-Archive -Force $zip '%JDK_RAIZ%'; Remove-Item $zip; $java=Get-ChildItem '%JDK_RAIZ%' -Filter java.exe -Recurse | Where-Object { $_.FullName -match '\\\\bin\\\\java\.exe$' } | Select-Object -First 1; if (-not $java) { throw 'java.exe nao encontrado no JDK baixado' }"
  if errorlevel 1 (
    echo Nao foi possivel baixar o Java. Verifique a conexao com a internet e tente novamente.
    pause
    exit /b 1
  )
  for /d %%D in ("%JDK_RAIZ%\jdk-*") do if exist "%%~fD\bin\java.exe" set "JAVA_HOME=%%~fD"
)

if defined JAVA_HOME (
  set "PATH=%JAVA_HOME%\bin;%PATH%"
)

set "MAVEN_VERSAO=3.9.9"
set "MAVEN_DIR=%~dp0.mvn\apache-maven-%MAVEN_VERSAO%"
if not exist "%MAVEN_DIR%\bin\mvn.cmd" (
  echo.
  echo Baixando o Maven %MAVEN_VERSAO% ^(somente na primeira vez^)...
  if not exist ".mvn" mkdir ".mvn"
  powershell -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $zip='.mvn\maven.zip'; Invoke-WebRequest -UseBasicParsing -Uri 'https://archive.apache.org/dist/maven/maven-3/%MAVEN_VERSAO%/binaries/apache-maven-%MAVEN_VERSAO%-bin.zip' -OutFile $zip; Expand-Archive -Force $zip '.mvn'; Remove-Item $zip"
  if errorlevel 1 (
    echo Nao foi possivel baixar o Maven. Verifique a conexao com a internet e tente novamente.
    pause
    exit /b 1
  )
)

echo.
echo Iniciando o site. Abra http://localhost:3000 no navegador.
echo Para parar o site, pressione Ctrl+C nesta janela.
echo.
start "" powershell.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0abrir-site.ps1"
call "%MAVEN_DIR%\bin\mvn.cmd" -q spring-boot:run
pause
