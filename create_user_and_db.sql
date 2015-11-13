\echo
\echo Creating Fishbase/Sealifebase Databases...
\echo

DROP DATABASE IF EXISTS fishbase;
CREATE DATABASE fishbase;

DROP USER IF EXISTS fishbase;
CREATE USER fishbase WITH PASSWORD 'fishbase';
DROP USER IF EXISTS web_fb;
CREATE USER web_fb WITH PASSWORD 'web_fb' NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOREPLICATION;

ALTER DATABASE fishbase OWNER TO fishbase;

GRANT postgres TO fishbase;
