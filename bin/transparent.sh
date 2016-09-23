#!/bin/bash
# this script use imagemagick convert cmd for make blank in png image as tranparent
# -w make everigthing white (maybe after transparent BG, you can white rest of image)
# -cxxxxxx | --color=xxxxxx get hexa color instead of ffffff for transparentify action
# -fxx | --fuzz=xx get percent to fuzz instead of 25 for both of transparentify and whitify actions

white=0
options=""
colorize="ffffff"
fuzz="25"
force_yes="0"

function ok() {
	echo -n "$1"
	if [ $force_yes -eq 0 ] ; then
		echo "OK (continue) ?"
		read
	else
		echo
	fi

}
function usage() {
	echo "USAGE :"
	echo "  $0 [options] image.{jpg,png}"
	echo "WHERE OPTIONS ARE :"
	echo "  -h|--help)      this help"
	echo "  -y|--yes)       auto yes every where (non interactive mode)"
	echo "  -f*|--fuzz=*)   percent fuzz for whitify and transparentify (default:$fuzz)"
	echo "  -c*|--color=*)  color to transparentify (default:$colorize)"
	echo "  -w|--white)     whitify instead of transparentify"
	echo "  -w*|--white=*)  colorize instead of whitify "
	echo
}

if [ ${#@} -eq 0 ] ; then
	usage
else
	for i in $@ ; do
		tmp=""

		if [ "x${i:0:1}" == "x-" ] ; then
			# getopt
			case $i in
				-h|--help) usage ;;
				-y|--yes) force_yes="1" ;;
				-f*|--fuzz=*)
					case $i in
						-f*) tmp=${i/-f/} ;;
						--fuzz=*) tmp=${i/--fuzz\=/} ;;
					esac
					ok "transparent fuzz '$tmp' instead of '$fuzz'."
					fuzz=$tmp
				;;
				-c*|--color=*)
					case $i in
						-c*) tmp=${i/-c/} ;;
						--color=*) tmp=${i/--color\=/} ;;
					esac
					ok "transparent color '$tmp' instead of '$colorize'."
					colorize=$tmp
				;;
				-w|--white)
					ok "whitify called instead of default transparentify."
					white=1
					options="-w"
				;;
				-w*|--white=*)
					case $i in
						-w*) tmp=${i/-w/} ;;
						--white=*) tmp=${i/--white\=/} ;;
					esac
					ok "colorize in '$tmp' instead of whitify in 'white' (instead of default transparentify)."
					white=$tmp
					options="-w"
				;;
				*)
					echo "unknown option '$i'."
					read
				;;
			esac
			continue
			# end of getopt

		else
			# action script
			if [ -e "$i" ]  ; then
				if (echo "$i" | egrep -q "\.png$") ; then
					echo -n "converting '$i' ... "
					if [ $white -eq 0 ] ;then
						echo -n "transparentify ... "
						convert -transparent \#${colorize} -fuzz ${fuzz}%  $i ${i/.png/-t.png}
					else
						if [ $white -eq 1 ] ;then
							echo -n "whitify ... "
							convert -fuzz ${fuzz}% -fill white -opaque \#${colorize} $i ${i/.png/-w.png}
						else
							echo -n "colorize ... "
							convert -fuzz ${fuzz}% -fill \#$white -opaque \#${colorize} $i ${i/.png/-w.png}
						fi
					fi

					out=$?
					[ $out -eq 0 ] \
						&& echo "ok" \
						|| echo "ERROR ($out)"
				else
					echo "'$i' is not a PNG file. Try to convert it into png file"
					ext="${i##*.}"
					case $ext in
						[Jj][pP][Gg]|[Jj][pP][Ee][Gg])
							png="${i/.$ext/.png}" ;
							convert $i $png && $0 $options $png || echo "conversion failed" ;;
						*) echo "ext is not recognized:'$ext'" ;;
					esac
				fi
			else
				echo "'$i' is not a regular file"
			fi

			# end of action script
		fi
	done
fi
