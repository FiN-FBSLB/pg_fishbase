CREATE OR REPLACE FUNCTION admin.grant_access() RETURNS void AS
$body$
DECLARE
  sname TEXT;                         
BEGIN
  for sname in select ns.nspname::text
                 from pg_user u
                 join pg_namespace ns on (ns.nspowner = u.usesysid)
                where u.usename = 'fishbase'
  loop
    execute format('grant usage on schema %s to web_fb', sname);
    execute format('grant select,references on all tables in schema %s to web_fb', sname);
    execute format('grant usage,select on all sequences in schema %s to web_fb', sname);
    execute format('grant execute on all functions in schema %s to web_fb', sname);
  end loop;
END
$body$
LANGUAGE plpgsql
SECURITY DEFINER;

SELECT admin.grant_access();
