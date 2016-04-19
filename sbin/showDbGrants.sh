#!/bin/bash
u="root"
p=""
d="mysql"
h="localhost"
db_name=""

function quit() {
  echo -e "$@"
  exit 1
}

echo "Give me password for root please"
read -s p
dbs="`mysql -u $u -p$p -h $h $d -e "SHOW databases;" | grep -v "Database"`" || quit "bad SQL output"
select db_name in $dbs ; do
  echo "db_name:$db_name"
  break
done

BAR="================================================================================"

COLUMNS=`tput cols`
if [ $COLUMNS -le 129 ] ; then
  tables_names="Select_priv as S, Insert_priv as I, Update_priv as U, Delete_priv as D, Create_priv as C, Drop_priv as D, Grant_priv as G, References_priv as R, Index_priv as I, Alter_priv as A, Create_tmp_table_priv as C, Lock_tables_priv as L, Create_view_priv as C, Show_view_priv as S, Create_routine_priv as C, 
Alter_routine_priv as A, Execute_priv as E, Event_priv as E, Trigger_priv as T"
  req="SELECT user,host,$tables_names FROM db WHERE db = '$db_name';"
elif [ $COLUMNS -le 149 ] ; then
  tables_names="Select_priv as S_, Insert_priv as I_, Update_priv as U_, Delete_priv as D_, Create_priv as C_, Drop_priv as Dr, Grant_priv as G_, References_priv as R_, Index_priv as Id, Alter_priv as A_, Create_tmp_table_priv as Ct, Lock_tables_priv as L_, Create_view_priv as Cv, Show_view_priv as Sh, Create_routi
ne_priv as Cr, Alter_routine_priv as Ar, Execute_priv as Ex, Event_priv as Ev, Trigger_priv as T_"
  req="SELECT user,host,$tables_names FROM db WHERE db = '$db_name';"
else
  tables_names="Select_priv as S_, Insert_priv as I_, Update_priv as U_, Delete_priv as D_, Create_priv as C_, Drop_priv as Dr, Grant_priv as G_, References_priv as R_, Index_priv as Id, Alter_priv as A_, Create_tmp_table_priv as Ct, Lock_tables_priv as L_, Create_view_priv as Cv, Show_view_priv as Sh, Create_routi
ne_priv as Cr, Alter_routine_priv as Ar, Execute_priv as Ex, Event_priv as Ev, Trigger_priv as T_"
  req="SELECT db,user,host,$tables_names FROM db WHERE db LIKE '%$db_name%';"
fi


echo "col:$COLUMNS"
echo -e "${BAR}\ngrants are :\n${BAR}"
echo -e "${tables_names//, /\n}" | sed 's/ as//g' | xargs printf "%-22s => %s\n"
echo $BAR
echo -en "\nR U OK ?"
read resp
echo
echo -e "${BAR}\ndb\n${BAR}"

mysql -u $u -p$p -h $h $d -e "$req" || quit "bad SQL output"

for table in tables_priv columns_priv procs_priv ; do
  echo -e "${BAR}\n$table\n${BAR}"
  mysql -u $u -p$p -h $h $d -e "SELECT user,host FROM $table WHERE db='$db_name';" || quit "bad SQL output"
done

