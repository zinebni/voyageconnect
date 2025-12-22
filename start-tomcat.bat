@echo off
setlocal

set "CATALINA_HOME=C:\tomcat2\apache-tomcat-9.0.113"
set "CATALINA_BASE=C:\tomcat2\apache-tomcat-9.0.113"

echo Demarrage de Tomcat...
echo CATALINA_HOME: %CATALINA_HOME%

cd /d "%CATALINA_HOME%\bin"

call startup.bat

echo.
echo Tomcat demarre en arriere-plan
echo Ouvrir http://localhost:8080/VoyageConnect dans 10 secondes...
timeout /t 10

start http://localhost:8080/VoyageConnect

endlocal
