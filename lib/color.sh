#!/bin/bash

# a beautiful script (in my opinion ;) ) using eval to colorize CLI and export advanced _COLOR variables
#
# USAGE : 
#
# Functions:
# ~> yellow "string" => echo a yellow "string" WITHOUT "\n"
# ~> bredn "string" => echo a bold and red "string" with "\n"
# ~> underscoren "string" => echo an underscore "string" with "\n"
# ~> uwhite_red "string" => echo an underscore background white and red "string" WITHOUT "\n"
#
# Variables:
# ~> BWHITE_RED_COLOR => evaluated as $'\033[47;01;31m'
#
# Note : loop and eval consume proc 
#        so use the 'minproc' version for a procedural declaration (does not currently support _COLOR Variables export)
#

# can be 0 or 1
# if 0 > all functions will be use echo instead of colorisation
# Note : loop and eval consume proc
#        so if you want COLORIZE=0 > use 'fake' or 'fake-minproc' version
[ -z "$COLORIZE" ] && COLORIZE=1
# can be 'bash' or 'html'
[ -z "$COLORTYPE" ] && COLORTYPE='bash'

export CHAR_ESC=$'\e'

PREFIX_=""
PREFIX_b="bold"
PREFIX_bl="blink"
PREFIX_u="underscore"
PREFIX_r="reverse"
PREFIX_c="cancel"

# BASH VALUES
# ===========

STYLE_bold="01"
STYLE_underscore="04"
STYLE_blink="05"
STYLE_reverse="07"
STYLE_cancel="08"

COLOR_black="30"
COLOR_red="31"
COLOR_green="32"
COLOR_yellow="33"
COLOR_blue="34"
COLOR_magenta="35"
COLOR_cyan="36"
COLOR_white="37"

BACKGROUND_black="40"
BACKGROUND_red="41"
BACKGROUND_green="42"
BACKGROUND_yellow="43"
BACKGROUND_blue="44"
BACKGROUND_magenta="45"
BACKGROUND_cyan="46"
BACKGROUND_white="47"

# HTML VALUES
# ===========
HTML_STYLE_bold="b"
HTML_STYLE_underscore="u"
HTML_STYLE_blink="blink"
HTML_STYLE_reverse=""
HTML_STYLE_cancel=""

HTML_COLOR_black="black"
HTML_COLOR_red="red"
HTML_COLOR_green="green"
HTML_COLOR_yellow="yellow"
HTML_COLOR_blue="blue"
HTML_COLOR_magenta="magenta"
HTML_COLOR_cyan="cyan"
HTML_COLOR_white="white"

HTML_BACKGROUND_black="black"
HTML_BACKGROUND_red="red"
HTML_BACKGROUND_green="green"
HTML_BACKGROUND_yellow="yellow"
HTML_BACKGROUND_blue="blue"
HTML_BACKGROUND_magenta="magenta"
HTML_BACKGROUND_cyan="cyan"
HTML_BACKGROUND_white="white"

export RESET_COLOR=$'\e[0m'

#--------------------------------------------------------------------------------
#  E C H O S    
#--------------------------------------------------------------------------------

function html() {
  [ "x$COLORTYPE" == "xhtml" ]
}
# EVAL html OR bash
# -----------------

if (html) ; then
  STYLES_VARS="${!HTML_STYLE_*}"
  COLORS_VARS="${!HTML_COLOR_*}"
  BACKGROUNDS_VARS="${!HTML_BACKGROUND_*}"
  eval "function printColorn() { echo -e \"\$@<br/>\" ; }"
else # this is bash type as default one (even if COLORTYPE is another that not specified here)
  STYLES_VARS="${!STYLE_*}"
  COLORS_VARS="${!COLOR_*}"
  BACKGROUNDS_VARS="${!BACKGROUND_*}"
  eval "function printColorn() { echo -e \"\$@\" ; }"
fi
function printAndClear() {
  echo -en "$@"
  tput sgr0
}

function printColor() {
  echo -en "$@"
}
function printHtml() {
  local styles_colors=(${1//;/ })
  local content="$2"
  local length=${#styles_colors[@]}
  local bgcolor=""
  local style=""
  local color=""
  case $length in
    1) 
      # test if style
      if (echo "$styles_colors" | grep -qE "^(b|u|bliknk)$") ; then
        echo "<$styles_colors>$content</$styles_colors>"
      else # then is color
        echo "<span style='color:$styles_colors'>$content</span>"
      fi
    ;; 2)
      style="${styles_colors[0]}"
      color="${styles_colors[1]}"
      echo "<span style='color:$color'><$style>$content</$style></span>"
    ;; 3)
      bgcolor="${styles_colors[0]}"
      style="${styles_colors[1]}"
      color="${styles_colors[2]}"
      echo "<span style='color:$color;background:$bgcolor'><$style>$content</$style></span>"
    ;; *)
      echo "$content"
    ;;
  esac
}

function evalColorFunction() {
  local func="$1"
  local var="${1^^}_COLOR"
  if (html) ; then
    if [ $COLORIZE -ge 1 ] ; then
      local style_color="$2"
      eval "$var=\$'$style_color'"
      eval "function ${func}() { printHtml \"$style_color\" \"\$@\" ; }"
      eval "function ${func}n() { ${func} \"\$@\" ; echo \"<br/>\"; }"
    else
      eval "function ${func}() { echo \"\$@\" ; }"
      eval "function ${func}n() { echo \"\$@<br/>\" ; }"
    fi
  else
    if [ $COLORIZE -ge 1 ] ; then
      local style_color="$2"
      eval "$var=\$'$CHAR_ESC[${style_color}m'"
      export $var
      eval "function ${func}() { printColor \"$CHAR_ESC[${style_color}m\" ; printAndClear \"\$@\" ; }"
      eval "function ${func}n() { ${func} \"\$@\" ; echo ; }"
    else
      eval "function ${func}() { echo -n \"\$@\" ; }"
      eval "function ${func}n() { echo \"\$@\" ; }"
    fi
  fi
  export -f $func
  export -f ${func}n
}

function evalBacgFunction() {
  local pref="$1"
  local func="$2"
  local style_color="$3"
  local bacg_var=""
  for bacg_var in ${BACKGROUNDS_VARS} ; do
    bacg_func=${bacg_var##*_}
    eval "bacg=\$$bacg_var"
    evalColorFunction "${pref}${bacg_func}_${func}" "${bacg};${style_color}"
  done
}

export -f html
export -f printAndClear
export -f printColor
export -f printColorn
export -f printHtml
export -f evalColorFunction
export -f evalBacgFunction


#--------------------------------------------------------------------------------
#  S T Y L E S   ( A L O N E )
#--------------------------------------------------------------------------------

for style_var in ${STYLES_VARS} ; do
  func=${style_var##*_}
  eval "style=\$$style_var"
  if [ ! -z "$style" ] ; then
    evalColorFunction "${func}" "${style}"
  fi
done

#--------------------------------------------------------------------------------
#  C O L O R S   W I T H   S T Y L E S   &   B A C K G R O U N D S
#--------------------------------------------------------------------------------

for color_var in ${COLORS_VARS} ; do
  func=${color_var##*_}
  eval "color=\$$color_var"

  for prefix in ${!PREFIX_*} ; do
    pref=${prefix##*_}
    if [ ! -z "$pref" ] ; then
      eval "style_var=\$$prefix"
      if (html) ; then
        eval "style=\$HTML_STYLE_$style_var"
      else
        eval "style=\$STYLE_$style_var"
      fi
      # styled color
      style_color="${style};${color}"
    else
      # alone color
      style_color="${color}"
    fi
    # alone
    evalColorFunction "${pref}${func}" "${style_color}"
    # backgrounded
    evalBacgFunction "${pref}" "${func}" "${style_color}"

  done

done

#--------------------------------------------------------------------------------
#  T E E   W I T H O U T   C O L O R
#--------------------------------------------------------------------------------

## TODO: TEST (PREVIOUSLY DONT WORK !!)
## ====================================
#function teeWithoutColor() {
# local stdin=""
# if [ -z $1 ] ; then
#   #echo "no file given"
#   while read stdin ; do
#     #echo -n "stdin: " 
#     echo "$stdin" | sed 's/[^m]*m//g;s/.$//'
#   done
# else
#   echo "file given: $1"
#   while read stdin ; do
#     #echo -n "stdin: " 
#     echo "$stdin" | sed 's/[^m]*m//g;s/.$//' | tee -a "$1"
#   done
# fi
#}
