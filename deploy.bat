@echo off
echo ========================================
echo   DEPLOIEMENT VOYAGECONNECT
echo ========================================
echo.

set TOMCAT_HOME=C:\tomcat2\apache-tomcat-9.0.113
set PROJECT_DIR=%~dp0
set WAR_FILE=%PROJECT_DIR%target\VoyageConnect.war
set APP_NAME=VoyageConnect

echo [1/5] Arret de Tomcat...
call "%TOMCAT_HOME%\bin\shutdown.bat" 2>nul
timeout /t 3 /nobreak >nul

echo [2/5] Nettoyage des anciens fichiers...
if exist "%TOMCAT_HOME%\webapps\%APP_NAME%" (
    rd /s /q "%TOMCAT_HOME%\webapps\%APP_NAME%"
    echo   - Dossier %APP_NAME% supprime
)
if exist "%TOMCAT_HOME%\webapps\%APP_NAME%.war" (
    del /q "%TOMCAT_HOME%\webapps\%APP_NAME%.war"
    echo   - WAR ancien supprime
)
if exist "%TOMCAT_HOME%\work\Catalina\localhost\%APP_NAME%" (
    rd /s /q "%TOMCAT_HOME%\work\Catalina\localhost\%APP_NAME%"
    echo   - Cache JSP supprime
)

echo [3/5] Copie du nouveau WAR...
if not exist "%WAR_FILE%" (
    echo ERREUR: WAR non trouve dans target\
    echo Executez d'abord: mvn clean package
    pause
    exit /b 1
)
copy /y "%WAR_FILE%" "%TOMCAT_HOME%\webapps\" >nul
echo   - WAR copie vers Tomcat

echo [4/5] Demarrage de Tomcat...
start "" "%TOMCAT_HOME%\bin\startup.bat"
echo   - Tomcat demarre

echo [5/5] Attente du deploiement (15 secondes)...
timeout /t 15 /nobreak >nul

echo.
echo ========================================
echo   DEPLOIEMENT TERMINE !
echo ========================================
echo.
echo URL de l'application:
echo   http://localhost:8080/%APP_NAME%
echo.
echo Logs Tomcat:
echo   %TOMCAT_HOME%\logs\catalina.out
echo.
echo Ouvrir dans le navigateur ? (O/N)
set /p OPEN="Votre choix: "
if /i "%OPEN%"=="O" (
    start http://localhost:8080/%APP_NAME%
)

echo.
pause
