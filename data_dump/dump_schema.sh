#!/bin/sh

if [ -z "$2" ]; then
  DbHost=localhost
else
  DbHost=$2
fi

if [ -z "$3" ]; then
  DbPort=5432
else
  DbPort=$3
fi
echo Password for user fishbase
pg_dump -h $DbHost -p $DbPort -f $1.schema -Fc -a -E UTF8 -U fishbase -n $1 $4 $5 $6 $7 $8 $9 fishbase
