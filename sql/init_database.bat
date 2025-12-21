@echo off
REM =====================================================
REM Script d'initialisation de la base de données VoyageConnect
REM =====================================================

echo ========================================
echo Initialisation VoyageConnect Database
echo ========================================
echo.

REM Paramètres MySQL (à adapter selon votre configuration)
set MYSQL_USER=root
set MYSQL_PASSWORD=root
set MYSQL_HOST=localhost
set MYSQL_PORT=3306
set DB_NAME=voyageconnect

echo [1/3] Création de l'utilisateur de test...
mysql -u%MYSQL_USER% -p%MYSQL_PASSWORD% -h%MYSQL_HOST% -P%MYSQL_PORT% %DB_NAME% < create_test_user.sql
if %ERRORLEVEL% NEQ 0 (
    echo ERREUR: Echec création utilisateur
    pause
    exit /b 1
)
echo ✓ Utilisateur test créé (test@voyage.com / test123)
echo.

echo [2/3] Insertion des données de test...
mysql -u%MYSQL_USER% -p%MYSQL_PASSWORD% -h%MYSQL_HOST% -P%MYSQL_PORT% %DB_NAME% < insert_test_data.sql
if %ERRORLEVEL% NEQ 0 (
    echo ERREUR: Echec insertion données
    pause
    exit /b 1
)
echo ✓ Données insérées (6 destinations, 10 vols, 10 hôtels, 6 circuits, 5 promotions)
echo.

echo [3/3] Vérification...
mysql -u%MYSQL_USER% -p%MYSQL_PASSWORD% -h%MYSQL_HOST% -P%MYSQL_PORT% %DB_NAME% -e "SELECT 'Destinations' as Type, COUNT(*) as Total FROM destinations UNION ALL SELECT 'Vols', COUNT(*) FROM flights UNION ALL SELECT 'Hotels', COUNT(*) FROM hotels UNION ALL SELECT 'Circuits', COUNT(*) FROM circuits UNION ALL SELECT 'Promotions', COUNT(*) FROM promotions;"
echo.

echo ========================================
echo ✓ INITIALISATION TERMINÉE
echo ========================================
echo.
echo Vous pouvez maintenant vous connecter avec:
echo   Email: test@voyage.com
echo   Mot de passe: test123
echo.
pause
