#!/bin/bash
# TODO: retrieve available best voice for the choosen SAY_LANG
# TODO: check the system OS to verify that say is the best voice reader (only works on MacOS today)
SAY="$(which say)"

# {{{ function quit
# #
quit() {
    echo "$1"
    exit 1
}
export -f quit
# }}}
# {{{ function usage
# #
usage() {
    echo
    echo "Takes a few minutes break, then say break is off"
    echo "USAGE: $0 [OPTIONS]"
    echo
    echo "Where availables OPTIONS are:"
    echo
    echo " \-e|--english          Say it in English"
    echo " \-f|--french           Say it in French (default)"
    echo " \-t|--time  {TIME}     Override TIME in minutes (default is 5 minutes)"
    echo " \-v|--voice {VOICE}    Override default VOICE for the choosen language (assume that this voice is installed on your computer)"
    echo " \-h|--help             Prints this message and exit without error."
    echo
}
export -f usage
# }}}

[[ -z "$SAY" ]] && quit "say not found"
[[ ! -x "$SAY" ]] && quit "say is not executable"

# defaults
BREAK_TIME="5"
SAY_LANG="en"
SAY_VOICE=""

while [[ ! -z "$1" ]] ; do
    case $1 in
        -e|--english) SAY_LANG="en" ;;
        -f|--french) SAY_LANG="fr" ;;
        -v|--voice) SAY_VOICE="$2" ; shift ;;
        -t|--time) BREAK_TIME="$2" ; shift ;;
        -h|--help) usage ; exit 0 ;;
        *)
    esac
    shift
done

case $SAY_LANG in
    fr)
        voice="Audrey"
        start_message="Vous pouvez prendre une pause de $BREAK_TIME minutes."
        end_message="C'est l'heure !"
        ;;
    en)
        voice="Allison"
        start_message="You can take a $BREAK_TIME minutes break."
        end_message="It's time !"
        ;;
esac
if [[ ! -z "$SAY_VOICE" ]] ; then
    voice="$SAY_VOICE"
fi

echo "$start_message"
say -v "$voice" "$start_message" || quit "Something went wrong"
seconds="$(($BREAK_TIME*60))"
while [[ "$seconds" -gt 0 ]] ; do
    sleep 1
    let seconds--
    if [[ $(($seconds % 10)) -eq 0 ]] ; then
        echo -n "#"
    else
        echo -n "."
    fi
    if [[ $(($seconds % 60)) -eq 0 ]] ; then
        echo
    fi
done
echo "$end_message"
say -v "$voice" "$end_message"
