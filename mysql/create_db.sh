#!/bin/sh

if [ -z "$1" ]; then
  DbHost=localhost
else
  DbHost=$2
fi

mysqladmin -h $DbHost -u root -p create fbapp
mysqladmin -h $DbHost -u root -p create slbapp