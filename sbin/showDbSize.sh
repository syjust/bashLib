#!/bin/bash
c=43                     # table name max lenth
n=11                     # count rows max lenth
orderBy="-r -k 2 -n -t:" # rows count reverse

U=""
P=""
H=""

DATABASES=""

function quit() {
  echo -e "$@"
  exit
}

while [ ! -z "$1" ] ; do
  case $1 in
    -rc|-cr) orderBy="-r -k 2 -n -t:"   ;; # rows count reverse
    -c)      orderBy="-k 2 -n -t:"      ;; # rows count
    -tr|-rt) orderBy="-r -k 1 -d -t:"   ;; # table name reverse
    -t)      orderBy="-k 1 -d -t:"      ;; # table name
    -u)      U=$2 ; shift               ;;  
    -p)      P=$2 ; shift               ;;  
    -h)      H=$2 ; shift               ;;  
    -d)      DATABASES="$DATABASES $2"
             shift                      ;;  
    *)       quit "'$1' is not allowed" ;;
  esac
  shift
done

[ -z "$U" -o -z "$P" -o -z "$H" ] && quit "set -u, -p, -h & -d please !"



t=$(($c+$n+3))
x=0
BAR=""
while [ $x -ne $t ] ; do
  BAR="$BAR="
  let x++ 
done


for database in $DATABASES ; do
  if [ ! -e "${database}.lst" ] ; then
    mysql -u $U -p$P -h $H $database -e "SHOW TABLES;" | grep -vE "^Tables_in_$database" > ${database}.lst 2>/dev/null \
     || quit "show tables in $database failed"
  fi  
 
  [ -e "${database}.lst" ] && TABLES="`cat ${database}.lst`" || quit "${database}.lst not found"
  echo $BAR
  echo $database
  echo $BAR
  for table in $TABLES ; do
    mysql -u $U -p$P -h $H $database -e "SELECT count(*) AS '$table' FROM $table;" 2>/dev/null \
      | xargs printf "%-${c}s : %'${n}.f\n" \
    || quit "mysql $database $table error"
  done | sort $orderBy
done
