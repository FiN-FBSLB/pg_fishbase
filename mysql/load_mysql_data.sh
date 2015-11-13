#!/bin/sh

if [ -z "$1" ]; then
  echo -n "Enter destination db name: "
  read DbName
else
  DbName=$1
fi

if [ -z "$2" ]; then
  echo -n "Enter mysql data dump file name: "
  read DataDump
else
  DataDump=$2
fi

if [ -z "$3" ]; then
  DbHost=localhost
else
  DbHost=$3
fi

mysql -h $DbHost -u root -p $DbName < $DataDump