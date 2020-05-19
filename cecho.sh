export black='\E[30m'
export red='\E[31m'
export green='\E[32m'
export yellow='\E[33m'
export blue='\E[34m'
export magenta='\E[35m'
export cyan='\E[36m'
export white='\E[37m'
export lightblue='\E[94m'
export reset='\e[39m'


cecho ()                        # Color-echo.
# Argument $1 = message
# Argument $2 = color
{
	local default_msg="No message passed."
	# Doesn't really need to be a local variable.

	message=${1:-$default_msg}   # Defaults to default message.
	color=${2:-$white}           # Defaults to white, if not specified.

	echo -e -n "$color"
	echo -e "$message"
	tput sgr0

	return
} 

tell () {
    cecho "[ dotfiles-bot ] $1 " $magenta
}
