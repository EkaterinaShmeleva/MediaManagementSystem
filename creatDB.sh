#!/bin/bash

mysql -pP4ssw0rt -B mmsDB < CreateTables.sql
mysql -pP4ssw0rt -B mmsDB < Withdrawals.sql
mysql -pP4ssw0rt -B mmsDB < moreViews.sql
mysql -pP4ssw0rt -B mmsDB < InsertProcedures.sql
mysql -pP4ssw0rt -B mmsDB < InsertData.sql
