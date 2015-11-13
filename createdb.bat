@ECHO OFF
SET CurrentDir=%~dp0
PUSHD %CurrentDir%

SET DATABASE_NAME=fishbase
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: Process command line parameter(s)
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
SET DbHost=%1
SET DbPort=%2
SET RestoreThreadCount=%3

IF /i "%DbHost%"=="" SET DbHost=localhost
IF /i "%DbPort%"=="" SET DbPort=5432
IF /i "%RestoreThreadCount%"=="" SET RestoreThreadCount=8

:::::::::::::::::::::::::
:: Deleting any previous log files
:::::::::::::::::::::::::
IF EXIST log GOTO LogDirExists
mkdir log

:LogDirExists
IF EXIST log\*.log del /Q .\log\*.log

SET SQLINPUTFILE=create_user_and_db
psql -h %DbHost% -p %DbPort% -U postgres -f %SQLINPUTFILE%.sql -L .\log\%SQLINPUTFILE%.log
IF ERRORLEVEL 1 GOTO ErrorLabel
               
SET SQLINPUTFILE=set_users_search_path
psql -h %DbHost% -p %DbPort% -U postgres -f %SQLINPUTFILE%.sql -L .\log\%SQLINPUTFILE%.log
IF ERRORLEVEL 1 GOTO ErrorLabel
               
SET SQLINPUTFILE=initialize
psql -h %DbHost% -p %DbPort% -d %DATABASE_NAME% -U postgres -f %SQLINPUTFILE%.sql -L .\log\%SQLINPUTFILE%.log
IF ERRORLEVEL 1 GOTO ErrorLabel

:: Check if we are creating a database in an RDS environment, then reconfigure the postgis package appropriately for user access
FOR /F "tokens=1 delims=| " %%A IN ('"psql -h %DbHost% -p %DbPort% -U postgres -A -t -c "select usename from pg_user""') DO (
  IF /i "%%A"=="rdsadmin" GOTO ConfigureForRDS
)                                               
GOTO InitializeMainSchema

:ConfigureForRDS
REM ECHO Amazon RDS environment detected. Re-configuring postgis environment appropriately...
REM SET SQLINPUTFILE=rds_postgis_setup
REM psql -h %DbHost% -p %DbPort% -d %DATABASE_NAME% -U postgres -f %SQLINPUTFILE%.sql -L .\log\%SQLINPUTFILE%.log
REM IF ERRORLEVEL 1 GOTO ErrorLabel

:InitializeMainSchema
IF NOT EXIST data_dump/fbapp.schema GOTO WrapUp
ECHO Restoring fbapp schema. Please enter password for user fishbase
pg_restore -h %DbHost% -p %DbPort% -d %DATABASE_NAME% -Fc -a -j %RestoreThreadCount% -U fishbase data_dump/fbapp.schema
IF ERRORLEVEL 1 GOTO ErrorLabel

:WrapUp
:: Clear previous content or create anew
ECHO vacuum analyze; > rmv.sql

:: Adding foreign keys
type index_admin.sql >> rmv.sql
type foreign_key_admin.sql >> rmv.sql
                                              
:: Adding commands to refresh materialized views 
psql -h %DbHost% -p %DbPort% -d %DATABASE_NAME% -U fishbase -t -f refresh_mv.sql >> rmv.sql 
IF ERRORLEVEL 1 GOTO ErrorLabel

psql -h %DbHost% -p %DbPort% -d %DATABASE_NAME% -U fishbase -f rmv.sql
IF ERRORLEVEL 1 GOTO ErrorLabel

GOTO Success

:Success
ECHO.
CD %CurrentDir%
ECHO #####
ECHO Successfully created %DATABASE_NAME% database
ECHO #####
GOTO End

:ErrorLabel
CD %CurrentDir%
ECHO "######"
ECHO Error encountered trying to create %DATABASE_NAME% db.
ECHO See .\log\%SQLINPUTFILE%.log for more details...
ECHO #####
GOTO End

:End
SET DbHost=
SET DbPort=
POPD
GOTO:EOF
         