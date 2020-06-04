#!/usr/bin/env bash
#
# This file called by gnome session startup to start conky system monitoring for user session
#

pkg=$(basename $0)
logger=$(which logger)
_home=$(echo $HOME)
PYTHON2_PATH=$(which python)
DELAY=12     # seconds

# --- declarations ------------------------------------------------------------


function host_keyword(){
    ##
    ## finds hostname keyword used to id conky configuration file
    ##
    local host

    host=$(hostname)

    case $host in

        *aries*)
            echo 'aries'
            return 0
            ;;

        *libra*)
            echo 'libra'
            return 0
            ;;

        gemini* | ubuntu1*)
            echo 'ubuntu18'
            return 0
            ;;

        *[Oo]nica*)
            echo 'lenovo'
            return 0
            ;;

        *scorpio*)
            echo 'scorpio'
            return 0
            ;;

        *)
            logger "[WARN]: Hostname keyword cannot be identified. Exit"
            exit 1
            ;;
    esac
    #
    # <-- end function host_keyword -->
}

# global vars
KEYWORD=$(host_keyword)
ROOT_DIR="$_home/git/conky-system-monitor"

# test if previous init
logger "[INFO]: pkg name detect is: $pkg"
logger "[INFO]: KEYWORD = $KEYWORD"
logger "[INFO]: ROOT_DIR = $ROOT_DIR"

# estimate conky running status
run_status=$(ps -ef | grep $pkg | grep -v grep 2>/dev/null)
echo -e logger "[INFO]: run status detect is: $run_status"

if [[ $run_status ]]; then
    logger "[INFO]: $pkg already running in the environment. Exit"
#    exit 0    # pkg running
fi


# start hddtemp daemon
# sudo hddtemp -d /dev/sda

# start conky
sleep $DELAY

# find out what monitor is connected
RES_INFO=$($PYTHON2_PATH $ROOT_DIR/getResolution.py | grep "current" |  awk '{print $1}')

case $RES_INFO in
    1366)
        logger "[INFO]: 1366x765 resolution identified, init appropriate conkyrc"
        conky --config="${ROOT_DIR}/$(hostname)/conkyrc-${KEYWORD}_1366X768" 2>/dev/null &
        ;;

    1920)
        logger "[INFO]: 1920x1080 resolution identified, init appropriate conkyrc"
        conky --config="${ROOT_DIR}/$(hostname)/conkyrc-${KEYWORD}_1920x1080" 2>/dev/null &
	    ;;

    2560 | 5120)
        logger "[INFO]: 2560x1440 resolution identified, init appropriate conkyrc"
        conky --config="${ROOT_DIR}/$(hostname)/conkyrc-${KEYWORD}_2560x1440" 2>/dev/null &
  	    ;;

    *)
        logger "[INFO]: Unknown screen resolution identified, starting default conky config"
        # unknown defaults to conky for builti-in resolution
        conky --config="${ROOT_DIR}/$(hostname)/conkyrc-${KEYWORD}_1920x1080" 2>/dev/null &
	    ;;
esac


set +x

# <-- end -->

exit 0
