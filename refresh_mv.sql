with views(name) as (
  select ns.nspname || '.' || (view_v(ns.nspname)).table_name
    from pg_user u
    join pg_namespace ns on (ns.nspowner = u.usesysid)
   where u.usename = 'fishbase'
)
select 'refresh materialized view ' || v.name || ';' 
  from views v 
 where v.name not like '%TOTALS:%';
