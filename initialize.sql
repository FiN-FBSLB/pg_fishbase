\echo
\echo Adding usefull extensions...
\echo
-- fishbase public (global) schema objects

--These extensions are not supported by RDS
--CREATE EXTENSION adminpack;
--CREATE EXTENSION xml2;
--CREATE EXTENSION file_fdw;

DROP EXTENSION IF EXISTS dblink CASCADE;
DROP EXTENSION IF EXISTS hstore CASCADE;
DROP EXTENSION IF EXISTS intarray CASCADE;
DROP EXTENSION IF EXISTS tablefunc CASCADE;
DROP EXTENSION IF EXISTS "uuid-ossp" CASCADE;
DROP EXTENSION IF EXISTS fuzzystrmatch CASCADE;
DROP EXTENSION IF EXISTS postgis CASCADE;
DROP EXTENSION IF EXISTS postgres_fdw;

CREATE EXTENSION dblink;
CREATE EXTENSION hstore;
CREATE EXTENSION intarray;
CREATE EXTENSION tablefunc;
CREATE EXTENSION "uuid-ossp";
CREATE EXTENSION fuzzystrmatch;
CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;
CREATE EXTENSION postgis_tiger_geocoder;
CREATE EXTENSION postgres_fdw;

\i set_users_search_path.sql
\i aggregate.sql
\i view.sql
\cd util
\i initialize.sql
\cd ..

\echo
\echo Creating Admin DB Objects...
\echo
\c fbapp fishbase
--- Create a project schema (namespace) for ease of maintenance (backup)
DROP SCHEMA IF EXISTS main CASCADE;
CREATE SCHEMA main;

\echo
\echo Creating Main DB Objects...
\echo
--\i table_main.sql
--\i function_main.sql
--\i mat_view_main.sql
--\i view_main.sql
--\i populate_main.sql

\i grant.sql
