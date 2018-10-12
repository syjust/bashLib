#!/bin/bash
c=43                     # table name max lenth
n=11                     # count rows max lenth
orderBy="-r -k 2 -n -t:" # rows count reverse

U=""
P=""
H=""

DATABASES=""
ACTION="size"
DEBUG=0

function quit() {
  echo -e "$@"
  exit
}

while [ ! -z "$1" ] ; do
  case $1 in
    -d)      DEBUG="1"                   ;; # DEBUG MODE (dry-run)
    -S)      ACTION="size"               ;; # show table size default behavior
    -C)      ACTION="count"              ;; # show row count instead table size
    -rc|-cr) orderBy="-r -k 2 -n -t:"    ;; # rows count reverse
    -c)      orderBy="-k 2 -n -t:"       ;; # rows count
    -tr|-rt) orderBy="-r -k 1 -d -t:"    ;; # table name reverse
    -t)      orderBy="-k 1 -d -t:"       ;; # table name order
    -u)      U=$2 ; shift                ;; # DB_USER
    -p*)     P=${1/-p}                   ;; # DB_PASS
    -h)      H=$2 ; shift                ;; # DB_HOST
    -D)      DATABASES="$DATABASES $2"      # DB_NAME [...DB_NAME] with multiple -D call
             shift                       ;;
    *)       quit "'$1' : bad arguments" ;;
  esac
  shift
done

[ -z "$U" -o -z "$P" -o -z "$H" ] && quit "set -u, -p, -h & -D please (like with standard mysql cmd) !"



t=$(($c+$n+3))
x=0
BAR=""
while [ $x -ne $t ] ; do
  BAR="$BAR="
  let x++ 
done


for database in $DATABASES ; do
  if [ ! -e "${database}.lst" ] ; then
    if [ $DEBUG -eq 1 ] ; then
        echo "mysql -u $U -p$P -h $H -D $database -e \"SHOW TABLES\";"
        echo DEBUG > ${database}.lst
    else
        mysql -u $U -p$P -h $H -D $database -e "SHOW TABLES;" \
            | grep -vE "^Tables_in_$database" > ${database}.lst 2>/dev/null \
            || quit "show tables in $database failed"
    fi
  fi  
 
  [ -e "${database}.lst" ] && TABLES="`cat ${database}.lst`" || quit "${database}.lst not found"
  echo $BAR
  echo $database
  echo $BAR
  for table in $TABLES ; do
    case $ACTION in
      size)
        query='
            SELECT
                table_name AS `Table`,
                round(((data_length + index_length) / 1024 / 1024), 2) `Size in MB`
            FROM information_schema.TABLES
            WHERE table_schema = "'$database'"
                AND table_name = "'$table'";
            ORDER BY (data_length + index_length) DESC
        '
      ;;
      count)
        query="SELECT count(*) AS '$table' FROM $table;"
      ;;
      *) quit "WTF action :'$ACTION' ???"
    esac
    if [ $DEBUG -eq 1 ] ; then
        echo "mysql -u $U -p$P -h $H -D $database -e \"$query\""
    else
        mysql -u $U -p$P -h $H -D $database -e "$query" 2>/dev/null \
            | xargs printf "%-${c}s : %'${n}.f\n" \
            || quit "mysql '$ACTION' : $database.$table error"
    fi
  done | sort $orderBy
done
