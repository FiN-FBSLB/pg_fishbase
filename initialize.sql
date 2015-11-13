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

\c fishbase fishbase
\echo
\echo Creating Schemas...
\echo
--- Create a project schema (namespace) for ease of maintenance (backup)
DROP SCHEMA IF EXISTS admin CASCADE;
CREATE SCHEMA admin;

DROP SCHEMA IF EXISTS fbapp CASCADE;
CREATE SCHEMA fbapp;
DROP SCHEMA IF EXISTS slbapp CASCADE;
CREATE SCHEMA slbapp;

DROP SCHEMA IF EXISTS ecomodel CASCADE;
CREATE SCHEMA ecomodel;
DROP SCHEMA IF EXISTS expeditions CASCADE;
CREATE SCHEMA expeditions;
DROP SCHEMA IF EXISTS fbapp_americas CASCADE;
CREATE SCHEMA fbapp_americas;
DROP SCHEMA IF EXISTS fbapp_qry CASCADE;
CREATE SCHEMA fbapp_qry;
DROP SCHEMA IF EXISTS fbmedia CASCADE;
CREATE SCHEMA fbmedia;
DROP SCHEMA IF EXISTS fbquiz CASCADE;
CREATE SCHEMA fbquiz;
DROP SCHEMA IF EXISTS fbquizsounds CASCADE;
CREATE SCHEMA fbquizsounds;
DROP SCHEMA IF EXISTS fbquizv2 CASCADE;
CREATE SCHEMA fbquizv2;
DROP SCHEMA IF EXISTS fbwebwrite CASCADE;
CREATE SCHEMA fbwebwrite;
DROP SCHEMA IF EXISTS fbwebwritev3 CASCADE;
CREATE SCHEMA fbwebwritev3;
DROP SCHEMA IF EXISTS fbwebwritev4 CASCADE;
CREATE SCHEMA fbwebwritev4;
DROP SCHEMA IF EXISTS fishwatcher CASCADE;
CREATE SCHEMA fishwatcher;
DROP SCHEMA IF EXISTS trophwebwrite CASCADE;
CREATE SCHEMA trophwebwrite;
DROP SCHEMA IF EXISTS top100 CASCADE;
CREATE SCHEMA top100;

\echo
\echo Creating Admin DB Objects...
\echo
--\i table_admin.sql
--\i function_admin.sql
--\i mat_view_admin.sql
--\i view_admin.sql
--\i populate_admin.sql

\i grant.sql
