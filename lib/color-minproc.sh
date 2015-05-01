#!/bin/bash
# color.sh lib 'minproc' version without loop and eval (procedural)

bblack () 
{ 
    printColor "\033[01;30m";
    printAndClear "$@"
}
declare -fx bblack
bblack_black () 
{ 
    printColor "\033[40;01;30m";
    printAndClear "$@"
}
declare -fx bblack_black
bblack_blackn () 
{ 
    bblack_black "$@";
    echo
}
declare -fx bblack_blackn
bblack_blue () 
{ 
    printColor "\033[40;01;34m";
    printAndClear "$@"
}
declare -fx bblack_blue
bblack_bluen () 
{ 
    bblack_blue "$@";
    echo
}
declare -fx bblack_bluen
bblack_cyan () 
{ 
    printColor "\033[40;01;36m";
    printAndClear "$@"
}
declare -fx bblack_cyan
bblack_cyann () 
{ 
    bblack_cyan "$@";
    echo
}
declare -fx bblack_cyann
bblack_green () 
{ 
    printColor "\033[40;01;32m";
    printAndClear "$@"
}
declare -fx bblack_green
bblack_greenn () 
{ 
    bblack_green "$@";
    echo
}
declare -fx bblack_greenn
bblack_magenta () 
{ 
    printColor "\033[40;01;35m";
    printAndClear "$@"
}
declare -fx bblack_magenta
bblack_magentan () 
{ 
    bblack_magenta "$@";
    echo
}
declare -fx bblack_magentan
bblack_red () 
{ 
    printColor "\033[40;01;31m";
    printAndClear "$@"
}
declare -fx bblack_red
bblack_redn () 
{ 
    bblack_red "$@";
    echo
}
declare -fx bblack_redn
bblack_white () 
{ 
    printColor "\033[40;01;37m";
    printAndClear "$@"
}
declare -fx bblack_white
bblack_whiten () 
{ 
    bblack_white "$@";
    echo
}
declare -fx bblack_whiten
bblack_yellow () 
{ 
    printColor "\033[40;01;33m";
    printAndClear "$@"
}
declare -fx bblack_yellow
bblack_yellown () 
{ 
    bblack_yellow "$@";
    echo
}
declare -fx bblack_yellown
bblackn () 
{ 
    bblack "$@";
    echo
}
declare -fx bblackn
bblue () 
{ 
    printColor "\033[01;34m";
    printAndClear "$@"
}
declare -fx bblue
bblue_black () 
{ 
    printColor "\033[44;01;30m";
    printAndClear "$@"
}
declare -fx bblue_black
bblue_blackn () 
{ 
    bblue_black "$@";
    echo
}
declare -fx bblue_blackn
bblue_blue () 
{ 
    printColor "\033[44;01;34m";
    printAndClear "$@"
}
declare -fx bblue_blue
bblue_bluen () 
{ 
    bblue_blue "$@";
    echo
}
declare -fx bblue_bluen
bblue_cyan () 
{ 
    printColor "\033[44;01;36m";
    printAndClear "$@"
}
declare -fx bblue_cyan
bblue_cyann () 
{ 
    bblue_cyan "$@";
    echo
}
declare -fx bblue_cyann
bblue_green () 
{ 
    printColor "\033[44;01;32m";
    printAndClear "$@"
}
declare -fx bblue_green
bblue_greenn () 
{ 
    bblue_green "$@";
    echo
}
declare -fx bblue_greenn
bblue_magenta () 
{ 
    printColor "\033[44;01;35m";
    printAndClear "$@"
}
declare -fx bblue_magenta
bblue_magentan () 
{ 
    bblue_magenta "$@";
    echo
}
declare -fx bblue_magentan
bblue_red () 
{ 
    printColor "\033[44;01;31m";
    printAndClear "$@"
}
declare -fx bblue_red
bblue_redn () 
{ 
    bblue_red "$@";
    echo
}
declare -fx bblue_redn
bblue_white () 
{ 
    printColor "\033[44;01;37m";
    printAndClear "$@"
}
declare -fx bblue_white
bblue_whiten () 
{ 
    bblue_white "$@";
    echo
}
declare -fx bblue_whiten
bblue_yellow () 
{ 
    printColor "\033[44;01;33m";
    printAndClear "$@"
}
declare -fx bblue_yellow
bblue_yellown () 
{ 
    bblue_yellow "$@";
    echo
}
declare -fx bblue_yellown
bbluen () 
{ 
    bblue "$@";
    echo
}
declare -fx bbluen
bcyan () 
{ 
    printColor "\033[01;36m";
    printAndClear "$@"
}
declare -fx bcyan
bcyan_black () 
{ 
    printColor "\033[46;01;30m";
    printAndClear "$@"
}
declare -fx bcyan_black
bcyan_blackn () 
{ 
    bcyan_black "$@";
    echo
}
declare -fx bcyan_blackn
bcyan_blue () 
{ 
    printColor "\033[46;01;34m";
    printAndClear "$@"
}
declare -fx bcyan_blue
bcyan_bluen () 
{ 
    bcyan_blue "$@";
    echo
}
declare -fx bcyan_bluen
bcyan_cyan () 
{ 
    printColor "\033[46;01;36m";
    printAndClear "$@"
}
declare -fx bcyan_cyan
bcyan_cyann () 
{ 
    bcyan_cyan "$@";
    echo
}
declare -fx bcyan_cyann
bcyan_green () 
{ 
    printColor "\033[46;01;32m";
    printAndClear "$@"
}
declare -fx bcyan_green
bcyan_greenn () 
{ 
    bcyan_green "$@";
    echo
}
declare -fx bcyan_greenn
bcyan_magenta () 
{ 
    printColor "\033[46;01;35m";
    printAndClear "$@"
}
declare -fx bcyan_magenta
bcyan_magentan () 
{ 
    bcyan_magenta "$@";
    echo
}
declare -fx bcyan_magentan
bcyan_red () 
{ 
    printColor "\033[46;01;31m";
    printAndClear "$@"
}
declare -fx bcyan_red
bcyan_redn () 
{ 
    bcyan_red "$@";
    echo
}
declare -fx bcyan_redn
bcyan_white () 
{ 
    printColor "\033[46;01;37m";
    printAndClear "$@"
}
declare -fx bcyan_white
bcyan_whiten () 
{ 
    bcyan_white "$@";
    echo
}
declare -fx bcyan_whiten
bcyan_yellow () 
{ 
    printColor "\033[46;01;33m";
    printAndClear "$@"
}
declare -fx bcyan_yellow
bcyan_yellown () 
{ 
    bcyan_yellow "$@";
    echo
}
declare -fx bcyan_yellown
bcyann () 
{ 
    bcyan "$@";
    echo
}
declare -fx bcyann
bgreen () 
{ 
    printColor "\033[01;32m";
    printAndClear "$@"
}
declare -fx bgreen
bgreen_black () 
{ 
    printColor "\033[42;01;30m";
    printAndClear "$@"
}
declare -fx bgreen_black
bgreen_blackn () 
{ 
    bgreen_black "$@";
    echo
}
declare -fx bgreen_blackn
bgreen_blue () 
{ 
    printColor "\033[42;01;34m";
    printAndClear "$@"
}
declare -fx bgreen_blue
bgreen_bluen () 
{ 
    bgreen_blue "$@";
    echo
}
declare -fx bgreen_bluen
bgreen_cyan () 
{ 
    printColor "\033[42;01;36m";
    printAndClear "$@"
}
declare -fx bgreen_cyan
bgreen_cyann () 
{ 
    bgreen_cyan "$@";
    echo
}
declare -fx bgreen_cyann
bgreen_green () 
{ 
    printColor "\033[42;01;32m";
    printAndClear "$@"
}
declare -fx bgreen_green
bgreen_greenn () 
{ 
    bgreen_green "$@";
    echo
}
declare -fx bgreen_greenn
bgreen_magenta () 
{ 
    printColor "\033[42;01;35m";
    printAndClear "$@"
}
declare -fx bgreen_magenta
bgreen_magentan () 
{ 
    bgreen_magenta "$@";
    echo
}
declare -fx bgreen_magentan
bgreen_red () 
{ 
    printColor "\033[42;01;31m";
    printAndClear "$@"
}
declare -fx bgreen_red
bgreen_redn () 
{ 
    bgreen_red "$@";
    echo
}
declare -fx bgreen_redn
bgreen_white () 
{ 
    printColor "\033[42;01;37m";
    printAndClear "$@"
}
declare -fx bgreen_white
bgreen_whiten () 
{ 
    bgreen_white "$@";
    echo
}
declare -fx bgreen_whiten
bgreen_yellow () 
{ 
    printColor "\033[42;01;33m";
    printAndClear "$@"
}
declare -fx bgreen_yellow
bgreen_yellown () 
{ 
    bgreen_yellow "$@";
    echo
}
declare -fx bgreen_yellown
bgreenn () 
{ 
    bgreen "$@";
    echo
}
declare -fx bgreenn
black () 
{ 
    printColor "\033[30m";
    printAndClear "$@"
}
declare -fx black
black_black () 
{ 
    printColor "\033[40;30m";
    printAndClear "$@"
}
declare -fx black_black
black_blackn () 
{ 
    black_black "$@";
    echo
}
declare -fx black_blackn
black_blue () 
{ 
    printColor "\033[40;34m";
    printAndClear "$@"
}
declare -fx black_blue
black_bluen () 
{ 
    black_blue "$@";
    echo
}
declare -fx black_bluen
black_cyan () 
{ 
    printColor "\033[40;36m";
    printAndClear "$@"
}
declare -fx black_cyan
black_cyann () 
{ 
    black_cyan "$@";
    echo
}
declare -fx black_cyann
black_green () 
{ 
    printColor "\033[40;32m";
    printAndClear "$@"
}
declare -fx black_green
black_greenn () 
{ 
    black_green "$@";
    echo
}
declare -fx black_greenn
black_magenta () 
{ 
    printColor "\033[40;35m";
    printAndClear "$@"
}
declare -fx black_magenta
black_magentan () 
{ 
    black_magenta "$@";
    echo
}
declare -fx black_magentan
black_red () 
{ 
    printColor "\033[40;31m";
    printAndClear "$@"
}
declare -fx black_red
black_redn () 
{ 
    black_red "$@";
    echo
}
declare -fx black_redn
black_white () 
{ 
    printColor "\033[40;37m";
    printAndClear "$@"
}
declare -fx black_white
black_whiten () 
{ 
    black_white "$@";
    echo
}
declare -fx black_whiten
black_yellow () 
{ 
    printColor "\033[40;33m";
    printAndClear "$@"
}
declare -fx black_yellow
black_yellown () 
{ 
    black_yellow "$@";
    echo
}
declare -fx black_yellown
blackn () 
{ 
    black "$@";
    echo
}
declare -fx blackn
blblack () 
{ 
    printColor "\033[05;30m";
    printAndClear "$@"
}
declare -fx blblack
blblack_black () 
{ 
    printColor "\033[40;05;30m";
    printAndClear "$@"
}
declare -fx blblack_black
blblack_blackn () 
{ 
    blblack_black "$@";
    echo
}
declare -fx blblack_blackn
blblack_blue () 
{ 
    printColor "\033[40;05;34m";
    printAndClear "$@"
}
declare -fx blblack_blue
blblack_bluen () 
{ 
    blblack_blue "$@";
    echo
}
declare -fx blblack_bluen
blblack_cyan () 
{ 
    printColor "\033[40;05;36m";
    printAndClear "$@"
}
declare -fx blblack_cyan
blblack_cyann () 
{ 
    blblack_cyan "$@";
    echo
}
declare -fx blblack_cyann
blblack_green () 
{ 
    printColor "\033[40;05;32m";
    printAndClear "$@"
}
declare -fx blblack_green
blblack_greenn () 
{ 
    blblack_green "$@";
    echo
}
declare -fx blblack_greenn
blblack_magenta () 
{ 
    printColor "\033[40;05;35m";
    printAndClear "$@"
}
declare -fx blblack_magenta
blblack_magentan () 
{ 
    blblack_magenta "$@";
    echo
}
declare -fx blblack_magentan
blblack_red () 
{ 
    printColor "\033[40;05;31m";
    printAndClear "$@"
}
declare -fx blblack_red
blblack_redn () 
{ 
    blblack_red "$@";
    echo
}
declare -fx blblack_redn
blblack_white () 
{ 
    printColor "\033[40;05;37m";
    printAndClear "$@"
}
declare -fx blblack_white
blblack_whiten () 
{ 
    blblack_white "$@";
    echo
}
declare -fx blblack_whiten
blblack_yellow () 
{ 
    printColor "\033[40;05;33m";
    printAndClear "$@"
}
declare -fx blblack_yellow
blblack_yellown () 
{ 
    blblack_yellow "$@";
    echo
}
declare -fx blblack_yellown
blblackn () 
{ 
    blblack "$@";
    echo
}
declare -fx blblackn
blblue () 
{ 
    printColor "\033[05;34m";
    printAndClear "$@"
}
declare -fx blblue
blblue_black () 
{ 
    printColor "\033[44;05;30m";
    printAndClear "$@"
}
declare -fx blblue_black
blblue_blackn () 
{ 
    blblue_black "$@";
    echo
}
declare -fx blblue_blackn
blblue_blue () 
{ 
    printColor "\033[44;05;34m";
    printAndClear "$@"
}
declare -fx blblue_blue
blblue_bluen () 
{ 
    blblue_blue "$@";
    echo
}
declare -fx blblue_bluen
blblue_cyan () 
{ 
    printColor "\033[44;05;36m";
    printAndClear "$@"
}
declare -fx blblue_cyan
blblue_cyann () 
{ 
    blblue_cyan "$@";
    echo
}
declare -fx blblue_cyann
blblue_green () 
{ 
    printColor "\033[44;05;32m";
    printAndClear "$@"
}
declare -fx blblue_green
blblue_greenn () 
{ 
    blblue_green "$@";
    echo
}
declare -fx blblue_greenn
blblue_magenta () 
{ 
    printColor "\033[44;05;35m";
    printAndClear "$@"
}
declare -fx blblue_magenta
blblue_magentan () 
{ 
    blblue_magenta "$@";
    echo
}
declare -fx blblue_magentan
blblue_red () 
{ 
    printColor "\033[44;05;31m";
    printAndClear "$@"
}
declare -fx blblue_red
blblue_redn () 
{ 
    blblue_red "$@";
    echo
}
declare -fx blblue_redn
blblue_white () 
{ 
    printColor "\033[44;05;37m";
    printAndClear "$@"
}
declare -fx blblue_white
blblue_whiten () 
{ 
    blblue_white "$@";
    echo
}
declare -fx blblue_whiten
blblue_yellow () 
{ 
    printColor "\033[44;05;33m";
    printAndClear "$@"
}
declare -fx blblue_yellow
blblue_yellown () 
{ 
    blblue_yellow "$@";
    echo
}
declare -fx blblue_yellown
blbluen () 
{ 
    blblue "$@";
    echo
}
declare -fx blbluen
blcyan () 
{ 
    printColor "\033[05;36m";
    printAndClear "$@"
}
declare -fx blcyan
blcyan_black () 
{ 
    printColor "\033[46;05;30m";
    printAndClear "$@"
}
declare -fx blcyan_black
blcyan_blackn () 
{ 
    blcyan_black "$@";
    echo
}
declare -fx blcyan_blackn
blcyan_blue () 
{ 
    printColor "\033[46;05;34m";
    printAndClear "$@"
}
declare -fx blcyan_blue
blcyan_bluen () 
{ 
    blcyan_blue "$@";
    echo
}
declare -fx blcyan_bluen
blcyan_cyan () 
{ 
    printColor "\033[46;05;36m";
    printAndClear "$@"
}
declare -fx blcyan_cyan
blcyan_cyann () 
{ 
    blcyan_cyan "$@";
    echo
}
declare -fx blcyan_cyann
blcyan_green () 
{ 
    printColor "\033[46;05;32m";
    printAndClear "$@"
}
declare -fx blcyan_green
blcyan_greenn () 
{ 
    blcyan_green "$@";
    echo
}
declare -fx blcyan_greenn
blcyan_magenta () 
{ 
    printColor "\033[46;05;35m";
    printAndClear "$@"
}
declare -fx blcyan_magenta
blcyan_magentan () 
{ 
    blcyan_magenta "$@";
    echo
}
declare -fx blcyan_magentan
blcyan_red () 
{ 
    printColor "\033[46;05;31m";
    printAndClear "$@"
}
declare -fx blcyan_red
blcyan_redn () 
{ 
    blcyan_red "$@";
    echo
}
declare -fx blcyan_redn
blcyan_white () 
{ 
    printColor "\033[46;05;37m";
    printAndClear "$@"
}
declare -fx blcyan_white
blcyan_whiten () 
{ 
    blcyan_white "$@";
    echo
}
declare -fx blcyan_whiten
blcyan_yellow () 
{ 
    printColor "\033[46;05;33m";
    printAndClear "$@"
}
declare -fx blcyan_yellow
blcyan_yellown () 
{ 
    blcyan_yellow "$@";
    echo
}
declare -fx blcyan_yellown
blcyann () 
{ 
    blcyan "$@";
    echo
}
declare -fx blcyann
blgreen () 
{ 
    printColor "\033[05;32m";
    printAndClear "$@"
}
declare -fx blgreen
blgreen_black () 
{ 
    printColor "\033[42;05;30m";
    printAndClear "$@"
}
declare -fx blgreen_black
blgreen_blackn () 
{ 
    blgreen_black "$@";
    echo
}
declare -fx blgreen_blackn
blgreen_blue () 
{ 
    printColor "\033[42;05;34m";
    printAndClear "$@"
}
declare -fx blgreen_blue
blgreen_bluen () 
{ 
    blgreen_blue "$@";
    echo
}
declare -fx blgreen_bluen
blgreen_cyan () 
{ 
    printColor "\033[42;05;36m";
    printAndClear "$@"
}
declare -fx blgreen_cyan
blgreen_cyann () 
{ 
    blgreen_cyan "$@";
    echo
}
declare -fx blgreen_cyann
blgreen_green () 
{ 
    printColor "\033[42;05;32m";
    printAndClear "$@"
}
declare -fx blgreen_green
blgreen_greenn () 
{ 
    blgreen_green "$@";
    echo
}
declare -fx blgreen_greenn
blgreen_magenta () 
{ 
    printColor "\033[42;05;35m";
    printAndClear "$@"
}
declare -fx blgreen_magenta
blgreen_magentan () 
{ 
    blgreen_magenta "$@";
    echo
}
declare -fx blgreen_magentan
blgreen_red () 
{ 
    printColor "\033[42;05;31m";
    printAndClear "$@"
}
declare -fx blgreen_red
blgreen_redn () 
{ 
    blgreen_red "$@";
    echo
}
declare -fx blgreen_redn
blgreen_white () 
{ 
    printColor "\033[42;05;37m";
    printAndClear "$@"
}
declare -fx blgreen_white
blgreen_whiten () 
{ 
    blgreen_white "$@";
    echo
}
declare -fx blgreen_whiten
blgreen_yellow () 
{ 
    printColor "\033[42;05;33m";
    printAndClear "$@"
}
declare -fx blgreen_yellow
blgreen_yellown () 
{ 
    blgreen_yellow "$@";
    echo
}
declare -fx blgreen_yellown
blgreenn () 
{ 
    blgreen "$@";
    echo
}
declare -fx blgreenn
blink () 
{ 
    printColor "\033[05m";
    printAndClear "$@"
}
declare -fx blink
blinkn () 
{ 
    blink "$@";
    echo
}
declare -fx blinkn
blmagenta () 
{ 
    printColor "\033[05;35m";
    printAndClear "$@"
}
declare -fx blmagenta
blmagenta_black () 
{ 
    printColor "\033[45;05;30m";
    printAndClear "$@"
}
declare -fx blmagenta_black
blmagenta_blackn () 
{ 
    blmagenta_black "$@";
    echo
}
declare -fx blmagenta_blackn
blmagenta_blue () 
{ 
    printColor "\033[45;05;34m";
    printAndClear "$@"
}
declare -fx blmagenta_blue
blmagenta_bluen () 
{ 
    blmagenta_blue "$@";
    echo
}
declare -fx blmagenta_bluen
blmagenta_cyan () 
{ 
    printColor "\033[45;05;36m";
    printAndClear "$@"
}
declare -fx blmagenta_cyan
blmagenta_cyann () 
{ 
    blmagenta_cyan "$@";
    echo
}
declare -fx blmagenta_cyann
blmagenta_green () 
{ 
    printColor "\033[45;05;32m";
    printAndClear "$@"
}
declare -fx blmagenta_green
blmagenta_greenn () 
{ 
    blmagenta_green "$@";
    echo
}
declare -fx blmagenta_greenn
blmagenta_magenta () 
{ 
    printColor "\033[45;05;35m";
    printAndClear "$@"
}
declare -fx blmagenta_magenta
blmagenta_magentan () 
{ 
    blmagenta_magenta "$@";
    echo
}
declare -fx blmagenta_magentan
blmagenta_red () 
{ 
    printColor "\033[45;05;31m";
    printAndClear "$@"
}
declare -fx blmagenta_red
blmagenta_redn () 
{ 
    blmagenta_red "$@";
    echo
}
declare -fx blmagenta_redn
blmagenta_white () 
{ 
    printColor "\033[45;05;37m";
    printAndClear "$@"
}
declare -fx blmagenta_white
blmagenta_whiten () 
{ 
    blmagenta_white "$@";
    echo
}
declare -fx blmagenta_whiten
blmagenta_yellow () 
{ 
    printColor "\033[45;05;33m";
    printAndClear "$@"
}
declare -fx blmagenta_yellow
blmagenta_yellown () 
{ 
    blmagenta_yellow "$@";
    echo
}
declare -fx blmagenta_yellown
blmagentan () 
{ 
    blmagenta "$@";
    echo
}
declare -fx blmagentan
blred () 
{ 
    printColor "\033[05;31m";
    printAndClear "$@"
}
declare -fx blred
blred_black () 
{ 
    printColor "\033[41;05;30m";
    printAndClear "$@"
}
declare -fx blred_black
blred_blackn () 
{ 
    blred_black "$@";
    echo
}
declare -fx blred_blackn
blred_blue () 
{ 
    printColor "\033[41;05;34m";
    printAndClear "$@"
}
declare -fx blred_blue
blred_bluen () 
{ 
    blred_blue "$@";
    echo
}
declare -fx blred_bluen
blred_cyan () 
{ 
    printColor "\033[41;05;36m";
    printAndClear "$@"
}
declare -fx blred_cyan
blred_cyann () 
{ 
    blred_cyan "$@";
    echo
}
declare -fx blred_cyann
blred_green () 
{ 
    printColor "\033[41;05;32m";
    printAndClear "$@"
}
declare -fx blred_green
blred_greenn () 
{ 
    blred_green "$@";
    echo
}
declare -fx blred_greenn
blred_magenta () 
{ 
    printColor "\033[41;05;35m";
    printAndClear "$@"
}
declare -fx blred_magenta
blred_magentan () 
{ 
    blred_magenta "$@";
    echo
}
declare -fx blred_magentan
blred_red () 
{ 
    printColor "\033[41;05;31m";
    printAndClear "$@"
}
declare -fx blred_red
blred_redn () 
{ 
    blred_red "$@";
    echo
}
declare -fx blred_redn
blred_white () 
{ 
    printColor "\033[41;05;37m";
    printAndClear "$@"
}
declare -fx blred_white
blred_whiten () 
{ 
    blred_white "$@";
    echo
}
declare -fx blred_whiten
blred_yellow () 
{ 
    printColor "\033[41;05;33m";
    printAndClear "$@"
}
declare -fx blred_yellow
blred_yellown () 
{ 
    blred_yellow "$@";
    echo
}
declare -fx blred_yellown
blredn () 
{ 
    blred "$@";
    echo
}
declare -fx blredn
blue () 
{ 
    printColor "\033[34m";
    printAndClear "$@"
}
declare -fx blue
blue_black () 
{ 
    printColor "\033[44;30m";
    printAndClear "$@"
}
declare -fx blue_black
blue_blackn () 
{ 
    blue_black "$@";
    echo
}
declare -fx blue_blackn
blue_blue () 
{ 
    printColor "\033[44;34m";
    printAndClear "$@"
}
declare -fx blue_blue
blue_bluen () 
{ 
    blue_blue "$@";
    echo
}
declare -fx blue_bluen
blue_cyan () 
{ 
    printColor "\033[44;36m";
    printAndClear "$@"
}
declare -fx blue_cyan
blue_cyann () 
{ 
    blue_cyan "$@";
    echo
}
declare -fx blue_cyann
blue_green () 
{ 
    printColor "\033[44;32m";
    printAndClear "$@"
}
declare -fx blue_green
blue_greenn () 
{ 
    blue_green "$@";
    echo
}
declare -fx blue_greenn
blue_magenta () 
{ 
    printColor "\033[44;35m";
    printAndClear "$@"
}
declare -fx blue_magenta
blue_magentan () 
{ 
    blue_magenta "$@";
    echo
}
declare -fx blue_magentan
blue_red () 
{ 
    printColor "\033[44;31m";
    printAndClear "$@"
}
declare -fx blue_red
blue_redn () 
{ 
    blue_red "$@";
    echo
}
declare -fx blue_redn
blue_white () 
{ 
    printColor "\033[44;37m";
    printAndClear "$@"
}
declare -fx blue_white
blue_whiten () 
{ 
    blue_white "$@";
    echo
}
declare -fx blue_whiten
blue_yellow () 
{ 
    printColor "\033[44;33m";
    printAndClear "$@"
}
declare -fx blue_yellow
blue_yellown () 
{ 
    blue_yellow "$@";
    echo
}
declare -fx blue_yellown
bluen () 
{ 
    blue "$@";
    echo
}
declare -fx bluen
blwhite () 
{ 
    printColor "\033[05;37m";
    printAndClear "$@"
}
declare -fx blwhite
blwhite_black () 
{ 
    printColor "\033[47;05;30m";
    printAndClear "$@"
}
declare -fx blwhite_black
blwhite_blackn () 
{ 
    blwhite_black "$@";
    echo
}
declare -fx blwhite_blackn
blwhite_blue () 
{ 
    printColor "\033[47;05;34m";
    printAndClear "$@"
}
declare -fx blwhite_blue
blwhite_bluen () 
{ 
    blwhite_blue "$@";
    echo
}
declare -fx blwhite_bluen
blwhite_cyan () 
{ 
    printColor "\033[47;05;36m";
    printAndClear "$@"
}
declare -fx blwhite_cyan
blwhite_cyann () 
{ 
    blwhite_cyan "$@";
    echo
}
declare -fx blwhite_cyann
blwhite_green () 
{ 
    printColor "\033[47;05;32m";
    printAndClear "$@"
}
declare -fx blwhite_green
blwhite_greenn () 
{ 
    blwhite_green "$@";
    echo
}
declare -fx blwhite_greenn
blwhite_magenta () 
{ 
    printColor "\033[47;05;35m";
    printAndClear "$@"
}
declare -fx blwhite_magenta
blwhite_magentan () 
{ 
    blwhite_magenta "$@";
    echo
}
declare -fx blwhite_magentan
blwhite_red () 
{ 
    printColor "\033[47;05;31m";
    printAndClear "$@"
}
declare -fx blwhite_red
blwhite_redn () 
{ 
    blwhite_red "$@";
    echo
}
declare -fx blwhite_redn
blwhite_white () 
{ 
    printColor "\033[47;05;37m";
    printAndClear "$@"
}
declare -fx blwhite_white
blwhite_whiten () 
{ 
    blwhite_white "$@";
    echo
}
declare -fx blwhite_whiten
blwhite_yellow () 
{ 
    printColor "\033[47;05;33m";
    printAndClear "$@"
}
declare -fx blwhite_yellow
blwhite_yellown () 
{ 
    blwhite_yellow "$@";
    echo
}
declare -fx blwhite_yellown
blwhiten () 
{ 
    blwhite "$@";
    echo
}
declare -fx blwhiten
blyellow () 
{ 
    printColor "\033[05;33m";
    printAndClear "$@"
}
declare -fx blyellow
blyellow_black () 
{ 
    printColor "\033[43;05;30m";
    printAndClear "$@"
}
declare -fx blyellow_black
blyellow_blackn () 
{ 
    blyellow_black "$@";
    echo
}
declare -fx blyellow_blackn
blyellow_blue () 
{ 
    printColor "\033[43;05;34m";
    printAndClear "$@"
}
declare -fx blyellow_blue
blyellow_bluen () 
{ 
    blyellow_blue "$@";
    echo
}
declare -fx blyellow_bluen
blyellow_cyan () 
{ 
    printColor "\033[43;05;36m";
    printAndClear "$@"
}
declare -fx blyellow_cyan
blyellow_cyann () 
{ 
    blyellow_cyan "$@";
    echo
}
declare -fx blyellow_cyann
blyellow_green () 
{ 
    printColor "\033[43;05;32m";
    printAndClear "$@"
}
declare -fx blyellow_green
blyellow_greenn () 
{ 
    blyellow_green "$@";
    echo
}
declare -fx blyellow_greenn
blyellow_magenta () 
{ 
    printColor "\033[43;05;35m";
    printAndClear "$@"
}
declare -fx blyellow_magenta
blyellow_magentan () 
{ 
    blyellow_magenta "$@";
    echo
}
declare -fx blyellow_magentan
blyellow_red () 
{ 
    printColor "\033[43;05;31m";
    printAndClear "$@"
}
declare -fx blyellow_red
blyellow_redn () 
{ 
    blyellow_red "$@";
    echo
}
declare -fx blyellow_redn
blyellow_white () 
{ 
    printColor "\033[43;05;37m";
    printAndClear "$@"
}
declare -fx blyellow_white
blyellow_whiten () 
{ 
    blyellow_white "$@";
    echo
}
declare -fx blyellow_whiten
blyellow_yellow () 
{ 
    printColor "\033[43;05;33m";
    printAndClear "$@"
}
declare -fx blyellow_yellow
blyellow_yellown () 
{ 
    blyellow_yellow "$@";
    echo
}
declare -fx blyellow_yellown
blyellown () 
{ 
    blyellow "$@";
    echo
}
declare -fx blyellown
bmagenta () 
{ 
    printColor "\033[01;35m";
    printAndClear "$@"
}
declare -fx bmagenta
bmagenta_black () 
{ 
    printColor "\033[45;01;30m";
    printAndClear "$@"
}
declare -fx bmagenta_black
bmagenta_blackn () 
{ 
    bmagenta_black "$@";
    echo
}
declare -fx bmagenta_blackn
bmagenta_blue () 
{ 
    printColor "\033[45;01;34m";
    printAndClear "$@"
}
declare -fx bmagenta_blue
bmagenta_bluen () 
{ 
    bmagenta_blue "$@";
    echo
}
declare -fx bmagenta_bluen
bmagenta_cyan () 
{ 
    printColor "\033[45;01;36m";
    printAndClear "$@"
}
declare -fx bmagenta_cyan
bmagenta_cyann () 
{ 
    bmagenta_cyan "$@";
    echo
}
declare -fx bmagenta_cyann
bmagenta_green () 
{ 
    printColor "\033[45;01;32m";
    printAndClear "$@"
}
declare -fx bmagenta_green
bmagenta_greenn () 
{ 
    bmagenta_green "$@";
    echo
}
declare -fx bmagenta_greenn
bmagenta_magenta () 
{ 
    printColor "\033[45;01;35m";
    printAndClear "$@"
}
declare -fx bmagenta_magenta
bmagenta_magentan () 
{ 
    bmagenta_magenta "$@";
    echo
}
declare -fx bmagenta_magentan
bmagenta_red () 
{ 
    printColor "\033[45;01;31m";
    printAndClear "$@"
}
declare -fx bmagenta_red
bmagenta_redn () 
{ 
    bmagenta_red "$@";
    echo
}
declare -fx bmagenta_redn
bmagenta_white () 
{ 
    printColor "\033[45;01;37m";
    printAndClear "$@"
}
declare -fx bmagenta_white
bmagenta_whiten () 
{ 
    bmagenta_white "$@";
    echo
}
declare -fx bmagenta_whiten
bmagenta_yellow () 
{ 
    printColor "\033[45;01;33m";
    printAndClear "$@"
}
declare -fx bmagenta_yellow
bmagenta_yellown () 
{ 
    bmagenta_yellow "$@";
    echo
}
declare -fx bmagenta_yellown
bmagentan () 
{ 
    bmagenta "$@";
    echo
}
declare -fx bmagentan
bold () 
{ 
    printColor "\033[01m";
    printAndClear "$@"
}
declare -fx bold
boldn () 
{ 
    bold "$@";
    echo
}
declare -fx boldn
bred () 
{ 
    printColor "\033[01;31m";
    printAndClear "$@"
}
declare -fx bred
bred_black () 
{ 
    printColor "\033[41;01;30m";
    printAndClear "$@"
}
declare -fx bred_black
bred_blackn () 
{ 
    bred_black "$@";
    echo
}
declare -fx bred_blackn
bred_blue () 
{ 
    printColor "\033[41;01;34m";
    printAndClear "$@"
}
declare -fx bred_blue
bred_bluen () 
{ 
    bred_blue "$@";
    echo
}
declare -fx bred_bluen
bred_cyan () 
{ 
    printColor "\033[41;01;36m";
    printAndClear "$@"
}
declare -fx bred_cyan
bred_cyann () 
{ 
    bred_cyan "$@";
    echo
}
declare -fx bred_cyann
bred_green () 
{ 
    printColor "\033[41;01;32m";
    printAndClear "$@"
}
declare -fx bred_green
bred_greenn () 
{ 
    bred_green "$@";
    echo
}
declare -fx bred_greenn
bred_magenta () 
{ 
    printColor "\033[41;01;35m";
    printAndClear "$@"
}
declare -fx bred_magenta
bred_magentan () 
{ 
    bred_magenta "$@";
    echo
}
declare -fx bred_magentan
bred_red () 
{ 
    printColor "\033[41;01;31m";
    printAndClear "$@"
}
declare -fx bred_red
bred_redn () 
{ 
    bred_red "$@";
    echo
}
declare -fx bred_redn
bred_white () 
{ 
    printColor "\033[41;01;37m";
    printAndClear "$@"
}
declare -fx bred_white
bred_whiten () 
{ 
    bred_white "$@";
    echo
}
declare -fx bred_whiten
bred_yellow () 
{ 
    printColor "\033[41;01;33m";
    printAndClear "$@"
}
declare -fx bred_yellow
bred_yellown () 
{ 
    bred_yellow "$@";
    echo
}
declare -fx bred_yellown
bredn () 
{ 
    bred "$@";
    echo
}
declare -fx bredn
bwhite () 
{ 
    printColor "\033[01;37m";
    printAndClear "$@"
}
declare -fx bwhite
bwhite_black () 
{ 
    printColor "\033[47;01;30m";
    printAndClear "$@"
}
declare -fx bwhite_black
bwhite_blackn () 
{ 
    bwhite_black "$@";
    echo
}
declare -fx bwhite_blackn
bwhite_blue () 
{ 
    printColor "\033[47;01;34m";
    printAndClear "$@"
}
declare -fx bwhite_blue
bwhite_bluen () 
{ 
    bwhite_blue "$@";
    echo
}
declare -fx bwhite_bluen
bwhite_cyan () 
{ 
    printColor "\033[47;01;36m";
    printAndClear "$@"
}
declare -fx bwhite_cyan
bwhite_cyann () 
{ 
    bwhite_cyan "$@";
    echo
}
declare -fx bwhite_cyann
bwhite_green () 
{ 
    printColor "\033[47;01;32m";
    printAndClear "$@"
}
declare -fx bwhite_green
bwhite_greenn () 
{ 
    bwhite_green "$@";
    echo
}
declare -fx bwhite_greenn
bwhite_magenta () 
{ 
    printColor "\033[47;01;35m";
    printAndClear "$@"
}
declare -fx bwhite_magenta
bwhite_magentan () 
{ 
    bwhite_magenta "$@";
    echo
}
declare -fx bwhite_magentan
bwhite_red () 
{ 
    printColor "\033[47;01;31m";
    printAndClear "$@"
}
declare -fx bwhite_red
bwhite_redn () 
{ 
    bwhite_red "$@";
    echo
}
declare -fx bwhite_redn
bwhite_white () 
{ 
    printColor "\033[47;01;37m";
    printAndClear "$@"
}
declare -fx bwhite_white
bwhite_whiten () 
{ 
    bwhite_white "$@";
    echo
}
declare -fx bwhite_whiten
bwhite_yellow () 
{ 
    printColor "\033[47;01;33m";
    printAndClear "$@"
}
declare -fx bwhite_yellow
bwhite_yellown () 
{ 
    bwhite_yellow "$@";
    echo
}
declare -fx bwhite_yellown
bwhiten () 
{ 
    bwhite "$@";
    echo
}
declare -fx bwhiten
byellow () 
{ 
    printColor "\033[01;33m";
    printAndClear "$@"
}
declare -fx byellow
byellow_black () 
{ 
    printColor "\033[43;01;30m";
    printAndClear "$@"
}
declare -fx byellow_black
byellow_blackn () 
{ 
    byellow_black "$@";
    echo
}
declare -fx byellow_blackn
byellow_blue () 
{ 
    printColor "\033[43;01;34m";
    printAndClear "$@"
}
declare -fx byellow_blue
byellow_bluen () 
{ 
    byellow_blue "$@";
    echo
}
declare -fx byellow_bluen
byellow_cyan () 
{ 
    printColor "\033[43;01;36m";
    printAndClear "$@"
}
declare -fx byellow_cyan
byellow_cyann () 
{ 
    byellow_cyan "$@";
    echo
}
declare -fx byellow_cyann
byellow_green () 
{ 
    printColor "\033[43;01;32m";
    printAndClear "$@"
}
declare -fx byellow_green
byellow_greenn () 
{ 
    byellow_green "$@";
    echo
}
declare -fx byellow_greenn
byellow_magenta () 
{ 
    printColor "\033[43;01;35m";
    printAndClear "$@"
}
declare -fx byellow_magenta
byellow_magentan () 
{ 
    byellow_magenta "$@";
    echo
}
declare -fx byellow_magentan
byellow_red () 
{ 
    printColor "\033[43;01;31m";
    printAndClear "$@"
}
declare -fx byellow_red
byellow_redn () 
{ 
    byellow_red "$@";
    echo
}
declare -fx byellow_redn
byellow_white () 
{ 
    printColor "\033[43;01;37m";
    printAndClear "$@"
}
declare -fx byellow_white
byellow_whiten () 
{ 
    byellow_white "$@";
    echo
}
declare -fx byellow_whiten
byellow_yellow () 
{ 
    printColor "\033[43;01;33m";
    printAndClear "$@"
}
declare -fx byellow_yellow
byellow_yellown () 
{ 
    byellow_yellow "$@";
    echo
}
declare -fx byellow_yellown
byellown () 
{ 
    byellow "$@";
    echo
}
declare -fx byellown
cancel () 
{ 
    printColor "\033[08m";
    printAndClear "$@"
}
declare -fx cancel
canceln () 
{ 
    cancel "$@";
    echo
}
declare -fx canceln
cblack () 
{ 
    printColor "\033[08;30m";
    printAndClear "$@"
}
declare -fx cblack
cblack_black () 
{ 
    printColor "\033[40;08;30m";
    printAndClear "$@"
}
declare -fx cblack_black
cblack_blackn () 
{ 
    cblack_black "$@";
    echo
}
declare -fx cblack_blackn
cblack_blue () 
{ 
    printColor "\033[40;08;34m";
    printAndClear "$@"
}
declare -fx cblack_blue
cblack_bluen () 
{ 
    cblack_blue "$@";
    echo
}
declare -fx cblack_bluen
cblack_cyan () 
{ 
    printColor "\033[40;08;36m";
    printAndClear "$@"
}
declare -fx cblack_cyan
cblack_cyann () 
{ 
    cblack_cyan "$@";
    echo
}
declare -fx cblack_cyann
cblack_green () 
{ 
    printColor "\033[40;08;32m";
    printAndClear "$@"
}
declare -fx cblack_green
cblack_greenn () 
{ 
    cblack_green "$@";
    echo
}
declare -fx cblack_greenn
cblack_magenta () 
{ 
    printColor "\033[40;08;35m";
    printAndClear "$@"
}
declare -fx cblack_magenta
cblack_magentan () 
{ 
    cblack_magenta "$@";
    echo
}
declare -fx cblack_magentan
cblack_red () 
{ 
    printColor "\033[40;08;31m";
    printAndClear "$@"
}
declare -fx cblack_red
cblack_redn () 
{ 
    cblack_red "$@";
    echo
}
declare -fx cblack_redn
cblack_white () 
{ 
    printColor "\033[40;08;37m";
    printAndClear "$@"
}
declare -fx cblack_white
cblack_whiten () 
{ 
    cblack_white "$@";
    echo
}
declare -fx cblack_whiten
cblack_yellow () 
{ 
    printColor "\033[40;08;33m";
    printAndClear "$@"
}
declare -fx cblack_yellow
cblack_yellown () 
{ 
    cblack_yellow "$@";
    echo
}
declare -fx cblack_yellown
cblackn () 
{ 
    cblack "$@";
    echo
}
declare -fx cblackn
cblue () 
{ 
    printColor "\033[08;34m";
    printAndClear "$@"
}
declare -fx cblue
cblue_black () 
{ 
    printColor "\033[44;08;30m";
    printAndClear "$@"
}
declare -fx cblue_black
cblue_blackn () 
{ 
    cblue_black "$@";
    echo
}
declare -fx cblue_blackn
cblue_blue () 
{ 
    printColor "\033[44;08;34m";
    printAndClear "$@"
}
declare -fx cblue_blue
cblue_bluen () 
{ 
    cblue_blue "$@";
    echo
}
declare -fx cblue_bluen
cblue_cyan () 
{ 
    printColor "\033[44;08;36m";
    printAndClear "$@"
}
declare -fx cblue_cyan
cblue_cyann () 
{ 
    cblue_cyan "$@";
    echo
}
declare -fx cblue_cyann
cblue_green () 
{ 
    printColor "\033[44;08;32m";
    printAndClear "$@"
}
declare -fx cblue_green
cblue_greenn () 
{ 
    cblue_green "$@";
    echo
}
declare -fx cblue_greenn
cblue_magenta () 
{ 
    printColor "\033[44;08;35m";
    printAndClear "$@"
}
declare -fx cblue_magenta
cblue_magentan () 
{ 
    cblue_magenta "$@";
    echo
}
declare -fx cblue_magentan
cblue_red () 
{ 
    printColor "\033[44;08;31m";
    printAndClear "$@"
}
declare -fx cblue_red
cblue_redn () 
{ 
    cblue_red "$@";
    echo
}
declare -fx cblue_redn
cblue_white () 
{ 
    printColor "\033[44;08;37m";
    printAndClear "$@"
}
declare -fx cblue_white
cblue_whiten () 
{ 
    cblue_white "$@";
    echo
}
declare -fx cblue_whiten
cblue_yellow () 
{ 
    printColor "\033[44;08;33m";
    printAndClear "$@"
}
declare -fx cblue_yellow
cblue_yellown () 
{ 
    cblue_yellow "$@";
    echo
}
declare -fx cblue_yellown
cbluen () 
{ 
    cblue "$@";
    echo
}
declare -fx cbluen
ccyan () 
{ 
    printColor "\033[08;36m";
    printAndClear "$@"
}
declare -fx ccyan
ccyan_black () 
{ 
    printColor "\033[46;08;30m";
    printAndClear "$@"
}
declare -fx ccyan_black
ccyan_blackn () 
{ 
    ccyan_black "$@";
    echo
}
declare -fx ccyan_blackn
ccyan_blue () 
{ 
    printColor "\033[46;08;34m";
    printAndClear "$@"
}
declare -fx ccyan_blue
ccyan_bluen () 
{ 
    ccyan_blue "$@";
    echo
}
declare -fx ccyan_bluen
ccyan_cyan () 
{ 
    printColor "\033[46;08;36m";
    printAndClear "$@"
}
declare -fx ccyan_cyan
ccyan_cyann () 
{ 
    ccyan_cyan "$@";
    echo
}
declare -fx ccyan_cyann
ccyan_green () 
{ 
    printColor "\033[46;08;32m";
    printAndClear "$@"
}
declare -fx ccyan_green
ccyan_greenn () 
{ 
    ccyan_green "$@";
    echo
}
declare -fx ccyan_greenn
ccyan_magenta () 
{ 
    printColor "\033[46;08;35m";
    printAndClear "$@"
}
declare -fx ccyan_magenta
ccyan_magentan () 
{ 
    ccyan_magenta "$@";
    echo
}
declare -fx ccyan_magentan
ccyan_red () 
{ 
    printColor "\033[46;08;31m";
    printAndClear "$@"
}
declare -fx ccyan_red
ccyan_redn () 
{ 
    ccyan_red "$@";
    echo
}
declare -fx ccyan_redn
ccyan_white () 
{ 
    printColor "\033[46;08;37m";
    printAndClear "$@"
}
declare -fx ccyan_white
ccyan_whiten () 
{ 
    ccyan_white "$@";
    echo
}
declare -fx ccyan_whiten
ccyan_yellow () 
{ 
    printColor "\033[46;08;33m";
    printAndClear "$@"
}
declare -fx ccyan_yellow
ccyan_yellown () 
{ 
    ccyan_yellow "$@";
    echo
}
declare -fx ccyan_yellown
ccyann () 
{ 
    ccyan "$@";
    echo
}
declare -fx ccyann
cgreen () 
{ 
    printColor "\033[08;32m";
    printAndClear "$@"
}
declare -fx cgreen
cgreen_black () 
{ 
    printColor "\033[42;08;30m";
    printAndClear "$@"
}
declare -fx cgreen_black
cgreen_blackn () 
{ 
    cgreen_black "$@";
    echo
}
declare -fx cgreen_blackn
cgreen_blue () 
{ 
    printColor "\033[42;08;34m";
    printAndClear "$@"
}
declare -fx cgreen_blue
cgreen_bluen () 
{ 
    cgreen_blue "$@";
    echo
}
declare -fx cgreen_bluen
cgreen_cyan () 
{ 
    printColor "\033[42;08;36m";
    printAndClear "$@"
}
declare -fx cgreen_cyan
cgreen_cyann () 
{ 
    cgreen_cyan "$@";
    echo
}
declare -fx cgreen_cyann
cgreen_green () 
{ 
    printColor "\033[42;08;32m";
    printAndClear "$@"
}
declare -fx cgreen_green
cgreen_greenn () 
{ 
    cgreen_green "$@";
    echo
}
declare -fx cgreen_greenn
cgreen_magenta () 
{ 
    printColor "\033[42;08;35m";
    printAndClear "$@"
}
declare -fx cgreen_magenta
cgreen_magentan () 
{ 
    cgreen_magenta "$@";
    echo
}
declare -fx cgreen_magentan
cgreen_red () 
{ 
    printColor "\033[42;08;31m";
    printAndClear "$@"
}
declare -fx cgreen_red
cgreen_redn () 
{ 
    cgreen_red "$@";
    echo
}
declare -fx cgreen_redn
cgreen_white () 
{ 
    printColor "\033[42;08;37m";
    printAndClear "$@"
}
declare -fx cgreen_white
cgreen_whiten () 
{ 
    cgreen_white "$@";
    echo
}
declare -fx cgreen_whiten
cgreen_yellow () 
{ 
    printColor "\033[42;08;33m";
    printAndClear "$@"
}
declare -fx cgreen_yellow
cgreen_yellown () 
{ 
    cgreen_yellow "$@";
    echo
}
declare -fx cgreen_yellown
cgreenn () 
{ 
    cgreen "$@";
    echo
}
declare -fx cgreenn
cmagenta () 
{ 
    printColor "\033[08;35m";
    printAndClear "$@"
}
declare -fx cmagenta
cmagenta_black () 
{ 
    printColor "\033[45;08;30m";
    printAndClear "$@"
}
declare -fx cmagenta_black
cmagenta_blackn () 
{ 
    cmagenta_black "$@";
    echo
}
declare -fx cmagenta_blackn
cmagenta_blue () 
{ 
    printColor "\033[45;08;34m";
    printAndClear "$@"
}
declare -fx cmagenta_blue
cmagenta_bluen () 
{ 
    cmagenta_blue "$@";
    echo
}
declare -fx cmagenta_bluen
cmagenta_cyan () 
{ 
    printColor "\033[45;08;36m";
    printAndClear "$@"
}
declare -fx cmagenta_cyan
cmagenta_cyann () 
{ 
    cmagenta_cyan "$@";
    echo
}
declare -fx cmagenta_cyann
cmagenta_green () 
{ 
    printColor "\033[45;08;32m";
    printAndClear "$@"
}
declare -fx cmagenta_green
cmagenta_greenn () 
{ 
    cmagenta_green "$@";
    echo
}
declare -fx cmagenta_greenn
cmagenta_magenta () 
{ 
    printColor "\033[45;08;35m";
    printAndClear "$@"
}
declare -fx cmagenta_magenta
cmagenta_magentan () 
{ 
    cmagenta_magenta "$@";
    echo
}
declare -fx cmagenta_magentan
cmagenta_red () 
{ 
    printColor "\033[45;08;31m";
    printAndClear "$@"
}
declare -fx cmagenta_red
cmagenta_redn () 
{ 
    cmagenta_red "$@";
    echo
}
declare -fx cmagenta_redn
cmagenta_white () 
{ 
    printColor "\033[45;08;37m";
    printAndClear "$@"
}
declare -fx cmagenta_white
cmagenta_whiten () 
{ 
    cmagenta_white "$@";
    echo
}
declare -fx cmagenta_whiten
cmagenta_yellow () 
{ 
    printColor "\033[45;08;33m";
    printAndClear "$@"
}
declare -fx cmagenta_yellow
cmagenta_yellown () 
{ 
    cmagenta_yellow "$@";
    echo
}
declare -fx cmagenta_yellown
cmagentan () 
{ 
    cmagenta "$@";
    echo
}
declare -fx cmagentan
cred () 
{ 
    printColor "\033[08;31m";
    printAndClear "$@"
}
declare -fx cred
cred_black () 
{ 
    printColor "\033[41;08;30m";
    printAndClear "$@"
}
declare -fx cred_black
cred_blackn () 
{ 
    cred_black "$@";
    echo
}
declare -fx cred_blackn
cred_blue () 
{ 
    printColor "\033[41;08;34m";
    printAndClear "$@"
}
declare -fx cred_blue
cred_bluen () 
{ 
    cred_blue "$@";
    echo
}
declare -fx cred_bluen
cred_cyan () 
{ 
    printColor "\033[41;08;36m";
    printAndClear "$@"
}
declare -fx cred_cyan
cred_cyann () 
{ 
    cred_cyan "$@";
    echo
}
declare -fx cred_cyann
cred_green () 
{ 
    printColor "\033[41;08;32m";
    printAndClear "$@"
}
declare -fx cred_green
cred_greenn () 
{ 
    cred_green "$@";
    echo
}
declare -fx cred_greenn
cred_magenta () 
{ 
    printColor "\033[41;08;35m";
    printAndClear "$@"
}
declare -fx cred_magenta
cred_magentan () 
{ 
    cred_magenta "$@";
    echo
}
declare -fx cred_magentan
cred_red () 
{ 
    printColor "\033[41;08;31m";
    printAndClear "$@"
}
declare -fx cred_red
cred_redn () 
{ 
    cred_red "$@";
    echo
}
declare -fx cred_redn
cred_white () 
{ 
    printColor "\033[41;08;37m";
    printAndClear "$@"
}
declare -fx cred_white
cred_whiten () 
{ 
    cred_white "$@";
    echo
}
declare -fx cred_whiten
cred_yellow () 
{ 
    printColor "\033[41;08;33m";
    printAndClear "$@"
}
declare -fx cred_yellow
cred_yellown () 
{ 
    cred_yellow "$@";
    echo
}
declare -fx cred_yellown
credn () 
{ 
    cred "$@";
    echo
}
declare -fx credn
cwhite () 
{ 
    printColor "\033[08;37m";
    printAndClear "$@"
}
declare -fx cwhite
cwhite_black () 
{ 
    printColor "\033[47;08;30m";
    printAndClear "$@"
}
declare -fx cwhite_black
cwhite_blackn () 
{ 
    cwhite_black "$@";
    echo
}
declare -fx cwhite_blackn
cwhite_blue () 
{ 
    printColor "\033[47;08;34m";
    printAndClear "$@"
}
declare -fx cwhite_blue
cwhite_bluen () 
{ 
    cwhite_blue "$@";
    echo
}
declare -fx cwhite_bluen
cwhite_cyan () 
{ 
    printColor "\033[47;08;36m";
    printAndClear "$@"
}
declare -fx cwhite_cyan
cwhite_cyann () 
{ 
    cwhite_cyan "$@";
    echo
}
declare -fx cwhite_cyann
cwhite_green () 
{ 
    printColor "\033[47;08;32m";
    printAndClear "$@"
}
declare -fx cwhite_green
cwhite_greenn () 
{ 
    cwhite_green "$@";
    echo
}
declare -fx cwhite_greenn
cwhite_magenta () 
{ 
    printColor "\033[47;08;35m";
    printAndClear "$@"
}
declare -fx cwhite_magenta
cwhite_magentan () 
{ 
    cwhite_magenta "$@";
    echo
}
declare -fx cwhite_magentan
cwhite_red () 
{ 
    printColor "\033[47;08;31m";
    printAndClear "$@"
}
declare -fx cwhite_red
cwhite_redn () 
{ 
    cwhite_red "$@";
    echo
}
declare -fx cwhite_redn
cwhite_white () 
{ 
    printColor "\033[47;08;37m";
    printAndClear "$@"
}
declare -fx cwhite_white
cwhite_whiten () 
{ 
    cwhite_white "$@";
    echo
}
declare -fx cwhite_whiten
cwhite_yellow () 
{ 
    printColor "\033[47;08;33m";
    printAndClear "$@"
}
declare -fx cwhite_yellow
cwhite_yellown () 
{ 
    cwhite_yellow "$@";
    echo
}
declare -fx cwhite_yellown
cwhiten () 
{ 
    cwhite "$@";
    echo
}
declare -fx cwhiten
cyan () 
{ 
    printColor "\033[36m";
    printAndClear "$@"
}
declare -fx cyan
cyan_black () 
{ 
    printColor "\033[46;30m";
    printAndClear "$@"
}
declare -fx cyan_black
cyan_blackn () 
{ 
    cyan_black "$@";
    echo
}
declare -fx cyan_blackn
cyan_blue () 
{ 
    printColor "\033[46;34m";
    printAndClear "$@"
}
declare -fx cyan_blue
cyan_bluen () 
{ 
    cyan_blue "$@";
    echo
}
declare -fx cyan_bluen
cyan_cyan () 
{ 
    printColor "\033[46;36m";
    printAndClear "$@"
}
declare -fx cyan_cyan
cyan_cyann () 
{ 
    cyan_cyan "$@";
    echo
}
declare -fx cyan_cyann
cyan_green () 
{ 
    printColor "\033[46;32m";
    printAndClear "$@"
}
declare -fx cyan_green
cyan_greenn () 
{ 
    cyan_green "$@";
    echo
}
declare -fx cyan_greenn
cyan_magenta () 
{ 
    printColor "\033[46;35m";
    printAndClear "$@"
}
declare -fx cyan_magenta
cyan_magentan () 
{ 
    cyan_magenta "$@";
    echo
}
declare -fx cyan_magentan
cyan_red () 
{ 
    printColor "\033[46;31m";
    printAndClear "$@"
}
declare -fx cyan_red
cyan_redn () 
{ 
    cyan_red "$@";
    echo
}
declare -fx cyan_redn
cyan_white () 
{ 
    printColor "\033[46;37m";
    printAndClear "$@"
}
declare -fx cyan_white
cyan_whiten () 
{ 
    cyan_white "$@";
    echo
}
declare -fx cyan_whiten
cyan_yellow () 
{ 
    printColor "\033[46;33m";
    printAndClear "$@"
}
declare -fx cyan_yellow
cyan_yellown () 
{ 
    cyan_yellow "$@";
    echo
}
declare -fx cyan_yellown
cyann () 
{ 
    cyan "$@";
    echo
}
declare -fx cyann
cyellow () 
{ 
    printColor "\033[08;33m";
    printAndClear "$@"
}
declare -fx cyellow
cyellow_black () 
{ 
    printColor "\033[43;08;30m";
    printAndClear "$@"
}
declare -fx cyellow_black
cyellow_blackn () 
{ 
    cyellow_black "$@";
    echo
}
declare -fx cyellow_blackn
cyellow_blue () 
{ 
    printColor "\033[43;08;34m";
    printAndClear "$@"
}
declare -fx cyellow_blue
cyellow_bluen () 
{ 
    cyellow_blue "$@";
    echo
}
declare -fx cyellow_bluen
cyellow_cyan () 
{ 
    printColor "\033[43;08;36m";
    printAndClear "$@"
}
declare -fx cyellow_cyan
cyellow_cyann () 
{ 
    cyellow_cyan "$@";
    echo
}
declare -fx cyellow_cyann
cyellow_green () 
{ 
    printColor "\033[43;08;32m";
    printAndClear "$@"
}
declare -fx cyellow_green
cyellow_greenn () 
{ 
    cyellow_green "$@";
    echo
}
declare -fx cyellow_greenn
cyellow_magenta () 
{ 
    printColor "\033[43;08;35m";
    printAndClear "$@"
}
declare -fx cyellow_magenta
cyellow_magentan () 
{ 
    cyellow_magenta "$@";
    echo
}
declare -fx cyellow_magentan
cyellow_red () 
{ 
    printColor "\033[43;08;31m";
    printAndClear "$@"
}
declare -fx cyellow_red
cyellow_redn () 
{ 
    cyellow_red "$@";
    echo
}
declare -fx cyellow_redn
cyellow_white () 
{ 
    printColor "\033[43;08;37m";
    printAndClear "$@"
}
declare -fx cyellow_white
cyellow_whiten () 
{ 
    cyellow_white "$@";
    echo
}
declare -fx cyellow_whiten
cyellow_yellow () 
{ 
    printColor "\033[43;08;33m";
    printAndClear "$@"
}
declare -fx cyellow_yellow
cyellow_yellown () 
{ 
    cyellow_yellow "$@";
    echo
}
declare -fx cyellow_yellown
cyellown () 
{ 
    cyellow "$@";
    echo
}
declare -fx cyellown
green () 
{ 
    printColor "\033[32m";
    printAndClear "$@"
}
declare -fx green
green_black () 
{ 
    printColor "\033[42;30m";
    printAndClear "$@"
}
declare -fx green_black
green_blackn () 
{ 
    green_black "$@";
    echo
}
declare -fx green_blackn
green_blue () 
{ 
    printColor "\033[42;34m";
    printAndClear "$@"
}
declare -fx green_blue
green_bluen () 
{ 
    green_blue "$@";
    echo
}
declare -fx green_bluen
green_cyan () 
{ 
    printColor "\033[42;36m";
    printAndClear "$@"
}
declare -fx green_cyan
green_cyann () 
{ 
    green_cyan "$@";
    echo
}
declare -fx green_cyann
green_green () 
{ 
    printColor "\033[42;32m";
    printAndClear "$@"
}
declare -fx green_green
green_greenn () 
{ 
    green_green "$@";
    echo
}
declare -fx green_greenn
green_magenta () 
{ 
    printColor "\033[42;35m";
    printAndClear "$@"
}
declare -fx green_magenta
green_magentan () 
{ 
    green_magenta "$@";
    echo
}
declare -fx green_magentan
green_red () 
{ 
    printColor "\033[42;31m";
    printAndClear "$@"
}
declare -fx green_red
green_redn () 
{ 
    green_red "$@";
    echo
}
declare -fx green_redn
green_white () 
{ 
    printColor "\033[42;37m";
    printAndClear "$@"
}
declare -fx green_white
green_whiten () 
{ 
    green_white "$@";
    echo
}
declare -fx green_whiten
green_yellow () 
{ 
    printColor "\033[42;33m";
    printAndClear "$@"
}
declare -fx green_yellow
green_yellown () 
{ 
    green_yellow "$@";
    echo
}
declare -fx green_yellown
greenn () 
{ 
    green "$@";
    echo
}
declare -fx greenn
html () 
{ 
    [ "x$COLORTYPE" == "xhtml" ]
}
declare -fx html
magenta () 
{ 
    printColor "\033[35m";
    printAndClear "$@"
}
declare -fx magenta
magenta_black () 
{ 
    printColor "\033[45;30m";
    printAndClear "$@"
}
declare -fx magenta_black
magenta_blackn () 
{ 
    magenta_black "$@";
    echo
}
declare -fx magenta_blackn
magenta_blue () 
{ 
    printColor "\033[45;34m";
    printAndClear "$@"
}
declare -fx magenta_blue
magenta_bluen () 
{ 
    magenta_blue "$@";
    echo
}
declare -fx magenta_bluen
magenta_cyan () 
{ 
    printColor "\033[45;36m";
    printAndClear "$@"
}
declare -fx magenta_cyan
magenta_cyann () 
{ 
    magenta_cyan "$@";
    echo
}
declare -fx magenta_cyann
magenta_green () 
{ 
    printColor "\033[45;32m";
    printAndClear "$@"
}
declare -fx magenta_green
magenta_greenn () 
{ 
    magenta_green "$@";
    echo
}
declare -fx magenta_greenn
magenta_magenta () 
{ 
    printColor "\033[45;35m";
    printAndClear "$@"
}
declare -fx magenta_magenta
magenta_magentan () 
{ 
    magenta_magenta "$@";
    echo
}
declare -fx magenta_magentan
magenta_red () 
{ 
    printColor "\033[45;31m";
    printAndClear "$@"
}
declare -fx magenta_red
magenta_redn () 
{ 
    magenta_red "$@";
    echo
}
declare -fx magenta_redn
magenta_white () 
{ 
    printColor "\033[45;37m";
    printAndClear "$@"
}
declare -fx magenta_white
magenta_whiten () 
{ 
    magenta_white "$@";
    echo
}
declare -fx magenta_whiten
magenta_yellow () 
{ 
    printColor "\033[45;33m";
    printAndClear "$@"
}
declare -fx magenta_yellow
magenta_yellown () 
{ 
    magenta_yellow "$@";
    echo
}
declare -fx magenta_yellown
magentan () 
{ 
    magenta "$@";
    echo
}
declare -fx magentan
printAndClear () 
{ 
    echo -en "$@";
    tput sgr0
}
declare -fx printAndClear
printColor () 
{ 
    echo -en "$@"
}
declare -fx printColor
printColorn () 
{ 
    echo -e "$@"
}
declare -fx printColorn
rblack () 
{ 
    printColor "\033[07;30m";
    printAndClear "$@"
}
declare -fx rblack
rblack_black () 
{ 
    printColor "\033[40;07;30m";
    printAndClear "$@"
}
declare -fx rblack_black
rblack_blackn () 
{ 
    rblack_black "$@";
    echo
}
declare -fx rblack_blackn
rblack_blue () 
{ 
    printColor "\033[40;07;34m";
    printAndClear "$@"
}
declare -fx rblack_blue
rblack_bluen () 
{ 
    rblack_blue "$@";
    echo
}
declare -fx rblack_bluen
rblack_cyan () 
{ 
    printColor "\033[40;07;36m";
    printAndClear "$@"
}
declare -fx rblack_cyan
rblack_cyann () 
{ 
    rblack_cyan "$@";
    echo
}
declare -fx rblack_cyann
rblack_green () 
{ 
    printColor "\033[40;07;32m";
    printAndClear "$@"
}
declare -fx rblack_green
rblack_greenn () 
{ 
    rblack_green "$@";
    echo
}
declare -fx rblack_greenn
rblack_magenta () 
{ 
    printColor "\033[40;07;35m";
    printAndClear "$@"
}
declare -fx rblack_magenta
rblack_magentan () 
{ 
    rblack_magenta "$@";
    echo
}
declare -fx rblack_magentan
rblack_red () 
{ 
    printColor "\033[40;07;31m";
    printAndClear "$@"
}
declare -fx rblack_red
rblack_redn () 
{ 
    rblack_red "$@";
    echo
}
declare -fx rblack_redn
rblack_white () 
{ 
    printColor "\033[40;07;37m";
    printAndClear "$@"
}
declare -fx rblack_white
rblack_whiten () 
{ 
    rblack_white "$@";
    echo
}
declare -fx rblack_whiten
rblack_yellow () 
{ 
    printColor "\033[40;07;33m";
    printAndClear "$@"
}
declare -fx rblack_yellow
rblack_yellown () 
{ 
    rblack_yellow "$@";
    echo
}
declare -fx rblack_yellown
rblackn () 
{ 
    rblack "$@";
    echo
}
declare -fx rblackn
rblue () 
{ 
    printColor "\033[07;34m";
    printAndClear "$@"
}
declare -fx rblue
rblue_black () 
{ 
    printColor "\033[44;07;30m";
    printAndClear "$@"
}
declare -fx rblue_black
rblue_blackn () 
{ 
    rblue_black "$@";
    echo
}
declare -fx rblue_blackn
rblue_blue () 
{ 
    printColor "\033[44;07;34m";
    printAndClear "$@"
}
declare -fx rblue_blue
rblue_bluen () 
{ 
    rblue_blue "$@";
    echo
}
declare -fx rblue_bluen
rblue_cyan () 
{ 
    printColor "\033[44;07;36m";
    printAndClear "$@"
}
declare -fx rblue_cyan
rblue_cyann () 
{ 
    rblue_cyan "$@";
    echo
}
declare -fx rblue_cyann
rblue_green () 
{ 
    printColor "\033[44;07;32m";
    printAndClear "$@"
}
declare -fx rblue_green
rblue_greenn () 
{ 
    rblue_green "$@";
    echo
}
declare -fx rblue_greenn
rblue_magenta () 
{ 
    printColor "\033[44;07;35m";
    printAndClear "$@"
}
declare -fx rblue_magenta
rblue_magentan () 
{ 
    rblue_magenta "$@";
    echo
}
declare -fx rblue_magentan
rblue_red () 
{ 
    printColor "\033[44;07;31m";
    printAndClear "$@"
}
declare -fx rblue_red
rblue_redn () 
{ 
    rblue_red "$@";
    echo
}
declare -fx rblue_redn
rblue_white () 
{ 
    printColor "\033[44;07;37m";
    printAndClear "$@"
}
declare -fx rblue_white
rblue_whiten () 
{ 
    rblue_white "$@";
    echo
}
declare -fx rblue_whiten
rblue_yellow () 
{ 
    printColor "\033[44;07;33m";
    printAndClear "$@"
}
declare -fx rblue_yellow
rblue_yellown () 
{ 
    rblue_yellow "$@";
    echo
}
declare -fx rblue_yellown
rbluen () 
{ 
    rblue "$@";
    echo
}
declare -fx rbluen
rcyan () 
{ 
    printColor "\033[07;36m";
    printAndClear "$@"
}
declare -fx rcyan
rcyan_black () 
{ 
    printColor "\033[46;07;30m";
    printAndClear "$@"
}
declare -fx rcyan_black
rcyan_blackn () 
{ 
    rcyan_black "$@";
    echo
}
declare -fx rcyan_blackn
rcyan_blue () 
{ 
    printColor "\033[46;07;34m";
    printAndClear "$@"
}
declare -fx rcyan_blue
rcyan_bluen () 
{ 
    rcyan_blue "$@";
    echo
}
declare -fx rcyan_bluen
rcyan_cyan () 
{ 
    printColor "\033[46;07;36m";
    printAndClear "$@"
}
declare -fx rcyan_cyan
rcyan_cyann () 
{ 
    rcyan_cyan "$@";
    echo
}
declare -fx rcyan_cyann
rcyan_green () 
{ 
    printColor "\033[46;07;32m";
    printAndClear "$@"
}
declare -fx rcyan_green
rcyan_greenn () 
{ 
    rcyan_green "$@";
    echo
}
declare -fx rcyan_greenn
rcyan_magenta () 
{ 
    printColor "\033[46;07;35m";
    printAndClear "$@"
}
declare -fx rcyan_magenta
rcyan_magentan () 
{ 
    rcyan_magenta "$@";
    echo
}
declare -fx rcyan_magentan
rcyan_red () 
{ 
    printColor "\033[46;07;31m";
    printAndClear "$@"
}
declare -fx rcyan_red
rcyan_redn () 
{ 
    rcyan_red "$@";
    echo
}
declare -fx rcyan_redn
rcyan_white () 
{ 
    printColor "\033[46;07;37m";
    printAndClear "$@"
}
declare -fx rcyan_white
rcyan_whiten () 
{ 
    rcyan_white "$@";
    echo
}
declare -fx rcyan_whiten
rcyan_yellow () 
{ 
    printColor "\033[46;07;33m";
    printAndClear "$@"
}
declare -fx rcyan_yellow
rcyan_yellown () 
{ 
    rcyan_yellow "$@";
    echo
}
declare -fx rcyan_yellown
rcyann () 
{ 
    rcyan "$@";
    echo
}
declare -fx rcyann
red () 
{ 
    printColor "\033[31m";
    printAndClear "$@"
}
declare -fx red
red_black () 
{ 
    printColor "\033[41;30m";
    printAndClear "$@"
}
declare -fx red_black
red_blackn () 
{ 
    red_black "$@";
    echo
}
declare -fx red_blackn
red_blue () 
{ 
    printColor "\033[41;34m";
    printAndClear "$@"
}
declare -fx red_blue
red_bluen () 
{ 
    red_blue "$@";
    echo
}
declare -fx red_bluen
red_cyan () 
{ 
    printColor "\033[41;36m";
    printAndClear "$@"
}
declare -fx red_cyan
red_cyann () 
{ 
    red_cyan "$@";
    echo
}
declare -fx red_cyann
red_green () 
{ 
    printColor "\033[41;32m";
    printAndClear "$@"
}
declare -fx red_green
red_greenn () 
{ 
    red_green "$@";
    echo
}
declare -fx red_greenn
red_magenta () 
{ 
    printColor "\033[41;35m";
    printAndClear "$@"
}
declare -fx red_magenta
red_magentan () 
{ 
    red_magenta "$@";
    echo
}
declare -fx red_magentan
red_red () 
{ 
    printColor "\033[41;31m";
    printAndClear "$@"
}
declare -fx red_red
red_redn () 
{ 
    red_red "$@";
    echo
}
declare -fx red_redn
red_white () 
{ 
    printColor "\033[41;37m";
    printAndClear "$@"
}
declare -fx red_white
red_whiten () 
{ 
    red_white "$@";
    echo
}
declare -fx red_whiten
red_yellow () 
{ 
    printColor "\033[41;33m";
    printAndClear "$@"
}
declare -fx red_yellow
red_yellown () 
{ 
    red_yellow "$@";
    echo
}
declare -fx red_yellown
redn () 
{ 
    red "$@";
    echo
}
declare -fx redn
reverse () 
{ 
    printColor "\033[07m";
    printAndClear "$@"
}
declare -fx reverse
reversen () 
{ 
    reverse "$@";
    echo
}
declare -fx reversen
rgreen () 
{ 
    printColor "\033[07;32m";
    printAndClear "$@"
}
declare -fx rgreen
rgreen_black () 
{ 
    printColor "\033[42;07;30m";
    printAndClear "$@"
}
declare -fx rgreen_black
rgreen_blackn () 
{ 
    rgreen_black "$@";
    echo
}
declare -fx rgreen_blackn
rgreen_blue () 
{ 
    printColor "\033[42;07;34m";
    printAndClear "$@"
}
declare -fx rgreen_blue
rgreen_bluen () 
{ 
    rgreen_blue "$@";
    echo
}
declare -fx rgreen_bluen
rgreen_cyan () 
{ 
    printColor "\033[42;07;36m";
    printAndClear "$@"
}
declare -fx rgreen_cyan
rgreen_cyann () 
{ 
    rgreen_cyan "$@";
    echo
}
declare -fx rgreen_cyann
rgreen_green () 
{ 
    printColor "\033[42;07;32m";
    printAndClear "$@"
}
declare -fx rgreen_green
rgreen_greenn () 
{ 
    rgreen_green "$@";
    echo
}
declare -fx rgreen_greenn
rgreen_magenta () 
{ 
    printColor "\033[42;07;35m";
    printAndClear "$@"
}
declare -fx rgreen_magenta
rgreen_magentan () 
{ 
    rgreen_magenta "$@";
    echo
}
declare -fx rgreen_magentan
rgreen_red () 
{ 
    printColor "\033[42;07;31m";
    printAndClear "$@"
}
declare -fx rgreen_red
rgreen_redn () 
{ 
    rgreen_red "$@";
    echo
}
declare -fx rgreen_redn
rgreen_white () 
{ 
    printColor "\033[42;07;37m";
    printAndClear "$@"
}
declare -fx rgreen_white
rgreen_whiten () 
{ 
    rgreen_white "$@";
    echo
}
declare -fx rgreen_whiten
rgreen_yellow () 
{ 
    printColor "\033[42;07;33m";
    printAndClear "$@"
}
declare -fx rgreen_yellow
rgreen_yellown () 
{ 
    rgreen_yellow "$@";
    echo
}
declare -fx rgreen_yellown
rgreenn () 
{ 
    rgreen "$@";
    echo
}
declare -fx rgreenn
rmagenta () 
{ 
    printColor "\033[07;35m";
    printAndClear "$@"
}
declare -fx rmagenta
rmagenta_black () 
{ 
    printColor "\033[45;07;30m";
    printAndClear "$@"
}
declare -fx rmagenta_black
rmagenta_blackn () 
{ 
    rmagenta_black "$@";
    echo
}
declare -fx rmagenta_blackn
rmagenta_blue () 
{ 
    printColor "\033[45;07;34m";
    printAndClear "$@"
}
declare -fx rmagenta_blue
rmagenta_bluen () 
{ 
    rmagenta_blue "$@";
    echo
}
declare -fx rmagenta_bluen
rmagenta_cyan () 
{ 
    printColor "\033[45;07;36m";
    printAndClear "$@"
}
declare -fx rmagenta_cyan
rmagenta_cyann () 
{ 
    rmagenta_cyan "$@";
    echo
}
declare -fx rmagenta_cyann
rmagenta_green () 
{ 
    printColor "\033[45;07;32m";
    printAndClear "$@"
}
declare -fx rmagenta_green
rmagenta_greenn () 
{ 
    rmagenta_green "$@";
    echo
}
declare -fx rmagenta_greenn
rmagenta_magenta () 
{ 
    printColor "\033[45;07;35m";
    printAndClear "$@"
}
declare -fx rmagenta_magenta
rmagenta_magentan () 
{ 
    rmagenta_magenta "$@";
    echo
}
declare -fx rmagenta_magentan
rmagenta_red () 
{ 
    printColor "\033[45;07;31m";
    printAndClear "$@"
}
declare -fx rmagenta_red
rmagenta_redn () 
{ 
    rmagenta_red "$@";
    echo
}
declare -fx rmagenta_redn
rmagenta_white () 
{ 
    printColor "\033[45;07;37m";
    printAndClear "$@"
}
declare -fx rmagenta_white
rmagenta_whiten () 
{ 
    rmagenta_white "$@";
    echo
}
declare -fx rmagenta_whiten
rmagenta_yellow () 
{ 
    printColor "\033[45;07;33m";
    printAndClear "$@"
}
declare -fx rmagenta_yellow
rmagenta_yellown () 
{ 
    rmagenta_yellow "$@";
    echo
}
declare -fx rmagenta_yellown
rmagentan () 
{ 
    rmagenta "$@";
    echo
}
declare -fx rmagentan
rred () 
{ 
    printColor "\033[07;31m";
    printAndClear "$@"
}
declare -fx rred
rred_black () 
{ 
    printColor "\033[41;07;30m";
    printAndClear "$@"
}
declare -fx rred_black
rred_blackn () 
{ 
    rred_black "$@";
    echo
}
declare -fx rred_blackn
rred_blue () 
{ 
    printColor "\033[41;07;34m";
    printAndClear "$@"
}
declare -fx rred_blue
rred_bluen () 
{ 
    rred_blue "$@";
    echo
}
declare -fx rred_bluen
rred_cyan () 
{ 
    printColor "\033[41;07;36m";
    printAndClear "$@"
}
declare -fx rred_cyan
rred_cyann () 
{ 
    rred_cyan "$@";
    echo
}
declare -fx rred_cyann
rred_green () 
{ 
    printColor "\033[41;07;32m";
    printAndClear "$@"
}
declare -fx rred_green
rred_greenn () 
{ 
    rred_green "$@";
    echo
}
declare -fx rred_greenn
rred_magenta () 
{ 
    printColor "\033[41;07;35m";
    printAndClear "$@"
}
declare -fx rred_magenta
rred_magentan () 
{ 
    rred_magenta "$@";
    echo
}
declare -fx rred_magentan
rred_red () 
{ 
    printColor "\033[41;07;31m";
    printAndClear "$@"
}
declare -fx rred_red
rred_redn () 
{ 
    rred_red "$@";
    echo
}
declare -fx rred_redn
rred_white () 
{ 
    printColor "\033[41;07;37m";
    printAndClear "$@"
}
declare -fx rred_white
rred_whiten () 
{ 
    rred_white "$@";
    echo
}
declare -fx rred_whiten
rred_yellow () 
{ 
    printColor "\033[41;07;33m";
    printAndClear "$@"
}
declare -fx rred_yellow
rred_yellown () 
{ 
    rred_yellow "$@";
    echo
}
declare -fx rred_yellown
rredn () 
{ 
    rred "$@";
    echo
}
declare -fx rredn
rwhite () 
{ 
    printColor "\033[07;37m";
    printAndClear "$@"
}
declare -fx rwhite
rwhite_black () 
{ 
    printColor "\033[47;07;30m";
    printAndClear "$@"
}
declare -fx rwhite_black
rwhite_blackn () 
{ 
    rwhite_black "$@";
    echo
}
declare -fx rwhite_blackn
rwhite_blue () 
{ 
    printColor "\033[47;07;34m";
    printAndClear "$@"
}
declare -fx rwhite_blue
rwhite_bluen () 
{ 
    rwhite_blue "$@";
    echo
}
declare -fx rwhite_bluen
rwhite_cyan () 
{ 
    printColor "\033[47;07;36m";
    printAndClear "$@"
}
declare -fx rwhite_cyan
rwhite_cyann () 
{ 
    rwhite_cyan "$@";
    echo
}
declare -fx rwhite_cyann
rwhite_green () 
{ 
    printColor "\033[47;07;32m";
    printAndClear "$@"
}
declare -fx rwhite_green
rwhite_greenn () 
{ 
    rwhite_green "$@";
    echo
}
declare -fx rwhite_greenn
rwhite_magenta () 
{ 
    printColor "\033[47;07;35m";
    printAndClear "$@"
}
declare -fx rwhite_magenta
rwhite_magentan () 
{ 
    rwhite_magenta "$@";
    echo
}
declare -fx rwhite_magentan
rwhite_red () 
{ 
    printColor "\033[47;07;31m";
    printAndClear "$@"
}
declare -fx rwhite_red
rwhite_redn () 
{ 
    rwhite_red "$@";
    echo
}
declare -fx rwhite_redn
rwhite_white () 
{ 
    printColor "\033[47;07;37m";
    printAndClear "$@"
}
declare -fx rwhite_white
rwhite_whiten () 
{ 
    rwhite_white "$@";
    echo
}
declare -fx rwhite_whiten
rwhite_yellow () 
{ 
    printColor "\033[47;07;33m";
    printAndClear "$@"
}
declare -fx rwhite_yellow
rwhite_yellown () 
{ 
    rwhite_yellow "$@";
    echo
}
declare -fx rwhite_yellown
rwhiten () 
{ 
    rwhite "$@";
    echo
}
declare -fx rwhiten
ryellow () 
{ 
    printColor "\033[07;33m";
    printAndClear "$@"
}
declare -fx ryellow
ryellow_black () 
{ 
    printColor "\033[43;07;30m";
    printAndClear "$@"
}
declare -fx ryellow_black
ryellow_blackn () 
{ 
    ryellow_black "$@";
    echo
}
declare -fx ryellow_blackn
ryellow_blue () 
{ 
    printColor "\033[43;07;34m";
    printAndClear "$@"
}
declare -fx ryellow_blue
ryellow_bluen () 
{ 
    ryellow_blue "$@";
    echo
}
declare -fx ryellow_bluen
ryellow_cyan () 
{ 
    printColor "\033[43;07;36m";
    printAndClear "$@"
}
declare -fx ryellow_cyan
ryellow_cyann () 
{ 
    ryellow_cyan "$@";
    echo
}
declare -fx ryellow_cyann
ryellow_green () 
{ 
    printColor "\033[43;07;32m";
    printAndClear "$@"
}
declare -fx ryellow_green
ryellow_greenn () 
{ 
    ryellow_green "$@";
    echo
}
declare -fx ryellow_greenn
ryellow_magenta () 
{ 
    printColor "\033[43;07;35m";
    printAndClear "$@"
}
declare -fx ryellow_magenta
ryellow_magentan () 
{ 
    ryellow_magenta "$@";
    echo
}
declare -fx ryellow_magentan
ryellow_red () 
{ 
    printColor "\033[43;07;31m";
    printAndClear "$@"
}
declare -fx ryellow_red
ryellow_redn () 
{ 
    ryellow_red "$@";
    echo
}
declare -fx ryellow_redn
ryellow_white () 
{ 
    printColor "\033[43;07;37m";
    printAndClear "$@"
}
declare -fx ryellow_white
ryellow_whiten () 
{ 
    ryellow_white "$@";
    echo
}
declare -fx ryellow_whiten
ryellow_yellow () 
{ 
    printColor "\033[43;07;33m";
    printAndClear "$@"
}
declare -fx ryellow_yellow
ryellow_yellown () 
{ 
    ryellow_yellow "$@";
    echo
}
declare -fx ryellow_yellown
ryellown () 
{ 
    ryellow "$@";
    echo
}
declare -fx ryellown
ublack () 
{ 
    printColor "\033[04;30m";
    printAndClear "$@"
}
declare -fx ublack
ublack_black () 
{ 
    printColor "\033[40;04;30m";
    printAndClear "$@"
}
declare -fx ublack_black
ublack_blackn () 
{ 
    ublack_black "$@";
    echo
}
declare -fx ublack_blackn
ublack_blue () 
{ 
    printColor "\033[40;04;34m";
    printAndClear "$@"
}
declare -fx ublack_blue
ublack_bluen () 
{ 
    ublack_blue "$@";
    echo
}
declare -fx ublack_bluen
ublack_cyan () 
{ 
    printColor "\033[40;04;36m";
    printAndClear "$@"
}
declare -fx ublack_cyan
ublack_cyann () 
{ 
    ublack_cyan "$@";
    echo
}
declare -fx ublack_cyann
ublack_green () 
{ 
    printColor "\033[40;04;32m";
    printAndClear "$@"
}
declare -fx ublack_green
ublack_greenn () 
{ 
    ublack_green "$@";
    echo
}
declare -fx ublack_greenn
ublack_magenta () 
{ 
    printColor "\033[40;04;35m";
    printAndClear "$@"
}
declare -fx ublack_magenta
ublack_magentan () 
{ 
    ublack_magenta "$@";
    echo
}
declare -fx ublack_magentan
ublack_red () 
{ 
    printColor "\033[40;04;31m";
    printAndClear "$@"
}
declare -fx ublack_red
ublack_redn () 
{ 
    ublack_red "$@";
    echo
}
declare -fx ublack_redn
ublack_white () 
{ 
    printColor "\033[40;04;37m";
    printAndClear "$@"
}
declare -fx ublack_white
ublack_whiten () 
{ 
    ublack_white "$@";
    echo
}
declare -fx ublack_whiten
ublack_yellow () 
{ 
    printColor "\033[40;04;33m";
    printAndClear "$@"
}
declare -fx ublack_yellow
ublack_yellown () 
{ 
    ublack_yellow "$@";
    echo
}
declare -fx ublack_yellown
ublackn () 
{ 
    ublack "$@";
    echo
}
declare -fx ublackn
ublue () 
{ 
    printColor "\033[04;34m";
    printAndClear "$@"
}
declare -fx ublue
ublue_black () 
{ 
    printColor "\033[44;04;30m";
    printAndClear "$@"
}
declare -fx ublue_black
ublue_blackn () 
{ 
    ublue_black "$@";
    echo
}
declare -fx ublue_blackn
ublue_blue () 
{ 
    printColor "\033[44;04;34m";
    printAndClear "$@"
}
declare -fx ublue_blue
ublue_bluen () 
{ 
    ublue_blue "$@";
    echo
}
declare -fx ublue_bluen
ublue_cyan () 
{ 
    printColor "\033[44;04;36m";
    printAndClear "$@"
}
declare -fx ublue_cyan
ublue_cyann () 
{ 
    ublue_cyan "$@";
    echo
}
declare -fx ublue_cyann
ublue_green () 
{ 
    printColor "\033[44;04;32m";
    printAndClear "$@"
}
declare -fx ublue_green
ublue_greenn () 
{ 
    ublue_green "$@";
    echo
}
declare -fx ublue_greenn
ublue_magenta () 
{ 
    printColor "\033[44;04;35m";
    printAndClear "$@"
}
declare -fx ublue_magenta
ublue_magentan () 
{ 
    ublue_magenta "$@";
    echo
}
declare -fx ublue_magentan
ublue_red () 
{ 
    printColor "\033[44;04;31m";
    printAndClear "$@"
}
declare -fx ublue_red
ublue_redn () 
{ 
    ublue_red "$@";
    echo
}
declare -fx ublue_redn
ublue_white () 
{ 
    printColor "\033[44;04;37m";
    printAndClear "$@"
}
declare -fx ublue_white
ublue_whiten () 
{ 
    ublue_white "$@";
    echo
}
declare -fx ublue_whiten
ublue_yellow () 
{ 
    printColor "\033[44;04;33m";
    printAndClear "$@"
}
declare -fx ublue_yellow
ublue_yellown () 
{ 
    ublue_yellow "$@";
    echo
}
declare -fx ublue_yellown
ubluen () 
{ 
    ublue "$@";
    echo
}
declare -fx ubluen
ucyan () 
{ 
    printColor "\033[04;36m";
    printAndClear "$@"
}
declare -fx ucyan
ucyan_black () 
{ 
    printColor "\033[46;04;30m";
    printAndClear "$@"
}
declare -fx ucyan_black
ucyan_blackn () 
{ 
    ucyan_black "$@";
    echo
}
declare -fx ucyan_blackn
ucyan_blue () 
{ 
    printColor "\033[46;04;34m";
    printAndClear "$@"
}
declare -fx ucyan_blue
ucyan_bluen () 
{ 
    ucyan_blue "$@";
    echo
}
declare -fx ucyan_bluen
ucyan_cyan () 
{ 
    printColor "\033[46;04;36m";
    printAndClear "$@"
}
declare -fx ucyan_cyan
ucyan_cyann () 
{ 
    ucyan_cyan "$@";
    echo
}
declare -fx ucyan_cyann
ucyan_green () 
{ 
    printColor "\033[46;04;32m";
    printAndClear "$@"
}
declare -fx ucyan_green
ucyan_greenn () 
{ 
    ucyan_green "$@";
    echo
}
declare -fx ucyan_greenn
ucyan_magenta () 
{ 
    printColor "\033[46;04;35m";
    printAndClear "$@"
}
declare -fx ucyan_magenta
ucyan_magentan () 
{ 
    ucyan_magenta "$@";
    echo
}
declare -fx ucyan_magentan
ucyan_red () 
{ 
    printColor "\033[46;04;31m";
    printAndClear "$@"
}
declare -fx ucyan_red
ucyan_redn () 
{ 
    ucyan_red "$@";
    echo
}
declare -fx ucyan_redn
ucyan_white () 
{ 
    printColor "\033[46;04;37m";
    printAndClear "$@"
}
declare -fx ucyan_white
ucyan_whiten () 
{ 
    ucyan_white "$@";
    echo
}
declare -fx ucyan_whiten
ucyan_yellow () 
{ 
    printColor "\033[46;04;33m";
    printAndClear "$@"
}
declare -fx ucyan_yellow
ucyan_yellown () 
{ 
    ucyan_yellow "$@";
    echo
}
declare -fx ucyan_yellown
ucyann () 
{ 
    ucyan "$@";
    echo
}
declare -fx ucyann
ugreen () 
{ 
    printColor "\033[04;32m";
    printAndClear "$@"
}
declare -fx ugreen
ugreen_black () 
{ 
    printColor "\033[42;04;30m";
    printAndClear "$@"
}
declare -fx ugreen_black
ugreen_blackn () 
{ 
    ugreen_black "$@";
    echo
}
declare -fx ugreen_blackn
ugreen_blue () 
{ 
    printColor "\033[42;04;34m";
    printAndClear "$@"
}
declare -fx ugreen_blue
ugreen_bluen () 
{ 
    ugreen_blue "$@";
    echo
}
declare -fx ugreen_bluen
ugreen_cyan () 
{ 
    printColor "\033[42;04;36m";
    printAndClear "$@"
}
declare -fx ugreen_cyan
ugreen_cyann () 
{ 
    ugreen_cyan "$@";
    echo
}
declare -fx ugreen_cyann
ugreen_green () 
{ 
    printColor "\033[42;04;32m";
    printAndClear "$@"
}
declare -fx ugreen_green
ugreen_greenn () 
{ 
    ugreen_green "$@";
    echo
}
declare -fx ugreen_greenn
ugreen_magenta () 
{ 
    printColor "\033[42;04;35m";
    printAndClear "$@"
}
declare -fx ugreen_magenta
ugreen_magentan () 
{ 
    ugreen_magenta "$@";
    echo
}
declare -fx ugreen_magentan
ugreen_red () 
{ 
    printColor "\033[42;04;31m";
    printAndClear "$@"
}
declare -fx ugreen_red
ugreen_redn () 
{ 
    ugreen_red "$@";
    echo
}
declare -fx ugreen_redn
ugreen_white () 
{ 
    printColor "\033[42;04;37m";
    printAndClear "$@"
}
declare -fx ugreen_white
ugreen_whiten () 
{ 
    ugreen_white "$@";
    echo
}
declare -fx ugreen_whiten
ugreen_yellow () 
{ 
    printColor "\033[42;04;33m";
    printAndClear "$@"
}
declare -fx ugreen_yellow
ugreen_yellown () 
{ 
    ugreen_yellow "$@";
    echo
}
declare -fx ugreen_yellown
ugreenn () 
{ 
    ugreen "$@";
    echo
}
declare -fx ugreenn
umagenta () 
{ 
    printColor "\033[04;35m";
    printAndClear "$@"
}
declare -fx umagenta
umagenta_black () 
{ 
    printColor "\033[45;04;30m";
    printAndClear "$@"
}
declare -fx umagenta_black
umagenta_blackn () 
{ 
    umagenta_black "$@";
    echo
}
declare -fx umagenta_blackn
umagenta_blue () 
{ 
    printColor "\033[45;04;34m";
    printAndClear "$@"
}
declare -fx umagenta_blue
umagenta_bluen () 
{ 
    umagenta_blue "$@";
    echo
}
declare -fx umagenta_bluen
umagenta_cyan () 
{ 
    printColor "\033[45;04;36m";
    printAndClear "$@"
}
declare -fx umagenta_cyan
umagenta_cyann () 
{ 
    umagenta_cyan "$@";
    echo
}
declare -fx umagenta_cyann
umagenta_green () 
{ 
    printColor "\033[45;04;32m";
    printAndClear "$@"
}
declare -fx umagenta_green
umagenta_greenn () 
{ 
    umagenta_green "$@";
    echo
}
declare -fx umagenta_greenn
umagenta_magenta () 
{ 
    printColor "\033[45;04;35m";
    printAndClear "$@"
}
declare -fx umagenta_magenta
umagenta_magentan () 
{ 
    umagenta_magenta "$@";
    echo
}
declare -fx umagenta_magentan
umagenta_red () 
{ 
    printColor "\033[45;04;31m";
    printAndClear "$@"
}
declare -fx umagenta_red
umagenta_redn () 
{ 
    umagenta_red "$@";
    echo
}
declare -fx umagenta_redn
umagenta_white () 
{ 
    printColor "\033[45;04;37m";
    printAndClear "$@"
}
declare -fx umagenta_white
umagenta_whiten () 
{ 
    umagenta_white "$@";
    echo
}
declare -fx umagenta_whiten
umagenta_yellow () 
{ 
    printColor "\033[45;04;33m";
    printAndClear "$@"
}
declare -fx umagenta_yellow
umagenta_yellown () 
{ 
    umagenta_yellow "$@";
    echo
}
declare -fx umagenta_yellown
umagentan () 
{ 
    umagenta "$@";
    echo
}
declare -fx umagentan
underscore () 
{ 
    printColor "\033[04m";
    printAndClear "$@"
}
declare -fx underscore
underscoren () 
{ 
    underscore "$@";
    echo
}
declare -fx underscoren
ured () 
{ 
    printColor "\033[04;31m";
    printAndClear "$@"
}
declare -fx ured
ured_black () 
{ 
    printColor "\033[41;04;30m";
    printAndClear "$@"
}
declare -fx ured_black
ured_blackn () 
{ 
    ured_black "$@";
    echo
}
declare -fx ured_blackn
ured_blue () 
{ 
    printColor "\033[41;04;34m";
    printAndClear "$@"
}
declare -fx ured_blue
ured_bluen () 
{ 
    ured_blue "$@";
    echo
}
declare -fx ured_bluen
ured_cyan () 
{ 
    printColor "\033[41;04;36m";
    printAndClear "$@"
}
declare -fx ured_cyan
ured_cyann () 
{ 
    ured_cyan "$@";
    echo
}
declare -fx ured_cyann
ured_green () 
{ 
    printColor "\033[41;04;32m";
    printAndClear "$@"
}
declare -fx ured_green
ured_greenn () 
{ 
    ured_green "$@";
    echo
}
declare -fx ured_greenn
ured_magenta () 
{ 
    printColor "\033[41;04;35m";
    printAndClear "$@"
}
declare -fx ured_magenta
ured_magentan () 
{ 
    ured_magenta "$@";
    echo
}
declare -fx ured_magentan
ured_red () 
{ 
    printColor "\033[41;04;31m";
    printAndClear "$@"
}
declare -fx ured_red
ured_redn () 
{ 
    ured_red "$@";
    echo
}
declare -fx ured_redn
ured_white () 
{ 
    printColor "\033[41;04;37m";
    printAndClear "$@"
}
declare -fx ured_white
ured_whiten () 
{ 
    ured_white "$@";
    echo
}
declare -fx ured_whiten
ured_yellow () 
{ 
    printColor "\033[41;04;33m";
    printAndClear "$@"
}
declare -fx ured_yellow
ured_yellown () 
{ 
    ured_yellow "$@";
    echo
}
declare -fx ured_yellown
uredn () 
{ 
    ured "$@";
    echo
}
declare -fx uredn
uwhite () 
{ 
    printColor "\033[04;37m";
    printAndClear "$@"
}
declare -fx uwhite
uwhite_black () 
{ 
    printColor "\033[47;04;30m";
    printAndClear "$@"
}
declare -fx uwhite_black
uwhite_blackn () 
{ 
    uwhite_black "$@";
    echo
}
declare -fx uwhite_blackn
uwhite_blue () 
{ 
    printColor "\033[47;04;34m";
    printAndClear "$@"
}
declare -fx uwhite_blue
uwhite_bluen () 
{ 
    uwhite_blue "$@";
    echo
}
declare -fx uwhite_bluen
uwhite_cyan () 
{ 
    printColor "\033[47;04;36m";
    printAndClear "$@"
}
declare -fx uwhite_cyan
uwhite_cyann () 
{ 
    uwhite_cyan "$@";
    echo
}
declare -fx uwhite_cyann
uwhite_green () 
{ 
    printColor "\033[47;04;32m";
    printAndClear "$@"
}
declare -fx uwhite_green
uwhite_greenn () 
{ 
    uwhite_green "$@";
    echo
}
declare -fx uwhite_greenn
uwhite_magenta () 
{ 
    printColor "\033[47;04;35m";
    printAndClear "$@"
}
declare -fx uwhite_magenta
uwhite_magentan () 
{ 
    uwhite_magenta "$@";
    echo
}
declare -fx uwhite_magentan
uwhite_red () 
{ 
    printColor "\033[47;04;31m";
    printAndClear "$@"
}
declare -fx uwhite_red
uwhite_redn () 
{ 
    uwhite_red "$@";
    echo
}
declare -fx uwhite_redn
uwhite_white () 
{ 
    printColor "\033[47;04;37m";
    printAndClear "$@"
}
declare -fx uwhite_white
uwhite_whiten () 
{ 
    uwhite_white "$@";
    echo
}
declare -fx uwhite_whiten
uwhite_yellow () 
{ 
    printColor "\033[47;04;33m";
    printAndClear "$@"
}
declare -fx uwhite_yellow
uwhite_yellown () 
{ 
    uwhite_yellow "$@";
    echo
}
declare -fx uwhite_yellown
uwhiten () 
{ 
    uwhite "$@";
    echo
}
declare -fx uwhiten
uyellow () 
{ 
    printColor "\033[04;33m";
    printAndClear "$@"
}
declare -fx uyellow
uyellow_black () 
{ 
    printColor "\033[43;04;30m";
    printAndClear "$@"
}
declare -fx uyellow_black
uyellow_blackn () 
{ 
    uyellow_black "$@";
    echo
}
declare -fx uyellow_blackn
uyellow_blue () 
{ 
    printColor "\033[43;04;34m";
    printAndClear "$@"
}
declare -fx uyellow_blue
uyellow_bluen () 
{ 
    uyellow_blue "$@";
    echo
}
declare -fx uyellow_bluen
uyellow_cyan () 
{ 
    printColor "\033[43;04;36m";
    printAndClear "$@"
}
declare -fx uyellow_cyan
uyellow_cyann () 
{ 
    uyellow_cyan "$@";
    echo
}
declare -fx uyellow_cyann
uyellow_green () 
{ 
    printColor "\033[43;04;32m";
    printAndClear "$@"
}
declare -fx uyellow_green
uyellow_greenn () 
{ 
    uyellow_green "$@";
    echo
}
declare -fx uyellow_greenn
uyellow_magenta () 
{ 
    printColor "\033[43;04;35m";
    printAndClear "$@"
}
declare -fx uyellow_magenta
uyellow_magentan () 
{ 
    uyellow_magenta "$@";
    echo
}
declare -fx uyellow_magentan
uyellow_red () 
{ 
    printColor "\033[43;04;31m";
    printAndClear "$@"
}
declare -fx uyellow_red
uyellow_redn () 
{ 
    uyellow_red "$@";
    echo
}
declare -fx uyellow_redn
uyellow_white () 
{ 
    printColor "\033[43;04;37m";
    printAndClear "$@"
}
declare -fx uyellow_white
uyellow_whiten () 
{ 
    uyellow_white "$@";
    echo
}
declare -fx uyellow_whiten
uyellow_yellow () 
{ 
    printColor "\033[43;04;33m";
    printAndClear "$@"
}
declare -fx uyellow_yellow
uyellow_yellown () 
{ 
    uyellow_yellow "$@";
    echo
}
declare -fx uyellow_yellown
uyellown () 
{ 
    uyellow "$@";
    echo
}
declare -fx uyellown
white () 
{ 
    printColor "\033[37m";
    printAndClear "$@"
}
declare -fx white
white_black () 
{ 
    printColor "\033[47;30m";
    printAndClear "$@"
}
declare -fx white_black
white_blackn () 
{ 
    white_black "$@";
    echo
}
declare -fx white_blackn
white_blue () 
{ 
    printColor "\033[47;34m";
    printAndClear "$@"
}
declare -fx white_blue
white_bluen () 
{ 
    white_blue "$@";
    echo
}
declare -fx white_bluen
white_cyan () 
{ 
    printColor "\033[47;36m";
    printAndClear "$@"
}
declare -fx white_cyan
white_cyann () 
{ 
    white_cyan "$@";
    echo
}
declare -fx white_cyann
white_green () 
{ 
    printColor "\033[47;32m";
    printAndClear "$@"
}
declare -fx white_green
white_greenn () 
{ 
    white_green "$@";
    echo
}
declare -fx white_greenn
white_magenta () 
{ 
    printColor "\033[47;35m";
    printAndClear "$@"
}
declare -fx white_magenta
white_magentan () 
{ 
    white_magenta "$@";
    echo
}
declare -fx white_magentan
white_red () 
{ 
    printColor "\033[47;31m";
    printAndClear "$@"
}
declare -fx white_red
white_redn () 
{ 
    white_red "$@";
    echo
}
declare -fx white_redn
white_white () 
{ 
    printColor "\033[47;37m";
    printAndClear "$@"
}
declare -fx white_white
white_whiten () 
{ 
    white_white "$@";
    echo
}
declare -fx white_whiten
white_yellow () 
{ 
    printColor "\033[47;33m";
    printAndClear "$@"
}
declare -fx white_yellow
white_yellown () 
{ 
    white_yellow "$@";
    echo
}
declare -fx white_yellown
whiten () 
{ 
    white "$@";
    echo
}
declare -fx whiten
yellow () 
{ 
    printColor "\033[33m";
    printAndClear "$@"
}
declare -fx yellow
yellow_black () 
{ 
    printColor "\033[43;30m";
    printAndClear "$@"
}
declare -fx yellow_black
yellow_blackn () 
{ 
    yellow_black "$@";
    echo
}
declare -fx yellow_blackn
yellow_blue () 
{ 
    printColor "\033[43;34m";
    printAndClear "$@"
}
declare -fx yellow_blue
yellow_bluen () 
{ 
    yellow_blue "$@";
    echo
}
declare -fx yellow_bluen
yellow_cyan () 
{ 
    printColor "\033[43;36m";
    printAndClear "$@"
}
declare -fx yellow_cyan
yellow_cyann () 
{ 
    yellow_cyan "$@";
    echo
}
declare -fx yellow_cyann
yellow_green () 
{ 
    printColor "\033[43;32m";
    printAndClear "$@"
}
declare -fx yellow_green
yellow_greenn () 
{ 
    yellow_green "$@";
    echo
}
declare -fx yellow_greenn
yellow_magenta () 
{ 
    printColor "\033[43;35m";
    printAndClear "$@"
}
declare -fx yellow_magenta
yellow_magentan () 
{ 
    yellow_magenta "$@";
    echo
}
declare -fx yellow_magentan
yellow_red () 
{ 
    printColor "\033[43;31m";
    printAndClear "$@"
}
declare -fx yellow_red
yellow_redn () 
{ 
    yellow_red "$@";
    echo
}
declare -fx yellow_redn
yellow_white () 
{ 
    printColor "\033[43;37m";
    printAndClear "$@"
}
declare -fx yellow_white
yellow_whiten () 
{ 
    yellow_white "$@";
    echo
}
declare -fx yellow_whiten
yellow_yellow () 
{ 
    printColor "\033[43;33m";
    printAndClear "$@"
}
declare -fx yellow_yellow
yellow_yellown () 
{ 
    yellow_yellow "$@";
    echo
}
declare -fx yellow_yellown
yellown () 
{ 
    yellow "$@";
    echo
}
declare -fx yellown
