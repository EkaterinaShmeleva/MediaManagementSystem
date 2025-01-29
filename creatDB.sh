#!/bin/bash

pwd=$1

mysql -p${pwd} -B mmsDB < CreateTables.sql
mysql -p${pwd} -B mmsDB < Withdrawals.sql
mysql -p${pwd} -B mmsDB < moreViews.sql
mysql -p${pwd} -B mmsDB < InsertProcedures.sql
mysql -p${pwd} -B mmsDB < InsertData.sql
mysql -p${pwd} -B mmsDB < LocationsData.sql
mysql -p${pwd} -B mmsDB < MasterView.sql
