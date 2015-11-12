select 'refresh materialized view main.' || table_name || ';' from view_v('main') where table_name not like 'TOTALS%';
