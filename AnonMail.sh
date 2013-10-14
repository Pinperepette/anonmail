#!/bin/bash
#Pinperepette --edited by eleve11
#########################################################################
#  This program is free software; you can redistribute it and/or modify #
#  it under the terms of the GNU General Public License as published by #
#  the Free Software Foundation; either version 2 of the License, or    #
#  (at your option) any later version.                                  #
#                                                                       #
#  This program is distributed in the hope that it will be useful,      #
#  but WITHOUT ANY WARRANTY; without even the implied warranty of       #
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the        #
#  GNU General Public License for more details.                         #
#                                                                       #
#  You should have received a copy of the GNU General Public License    #
#  along with this program; if not, write to the Free Software          #
#  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,           #
#  MA 02110-1301, USA.                                                  #
############################# DISCALIMER ################################
#  Usage of this software for probing/attacking targets without prior   #
#  mutual consent, is illegal. It's the end user's responsability to    #
#  obey alla applicable local laws. Developers assume no liability and  #
#  are not responible for any missue or damage caused by thi program    #
#########################################################################
########################################################################
######################### EXTRA SUBROUTINES ############################
########################################################################

msg() {
	local mesg=$1; shift
	printf "${BOLD}[ ${GREEN}I${ALL_OFF}${BOLD} ]${ALL_OFF} ${mesg}\n" "$@" >&2
}

excla() {
	local mesg=$1; shift
	printf "${BOLD}[ ${BLUE}!${ALL_OFF}${BOLD} ]${ALL_OFF} ${mesg}\n" "$@" >&2
}

warning() {
	local mesg=$1; shift
	printf "${BOLD}[ ${YELLOW}W${ALL_OFF}${BOLD} ]${ALL_OFF} ${mesg}\n" "$@" >&2
}

error() {
	local mesg=$1; shift
	printf "${BOLD}[ ${RED}E${ALL_OFF}${BOLD} ]${ALL_OFF} ${mesg}\n" "$@" >&2
}

# check if messages are to be printed using color
unset ALL_OFF BOLD BLUE GREEN RED YELLOW
ALL_OFF="\e[1;0m"
BOLD="\e[1;1m"
BLUE="${BOLD}\e[1;34m"
GREEN="${BOLD}\e[1;32m"
RED="${BOLD}\e[1;31m"
YELLOW="${BOLD}\e[1;33m"
readonly ALL_OFF BOLD BLUE GREEN RED YELLOW
prog="AnonMail"
########################################################################
############################# SUBROUTINES ##############################
########################################################################
check_software() {
	uscita=0
	if [ $(dpkg -s zenity | grep -c "install ok") -ne "1" ]; then
		error "Impossibile trovare il programma: zenity."
	notify-send -t 8000 -i /usr/share/icons/gnome/48x48/status/dmerror1.png "Impossibile trovare il programma: zenity."	
		uscita=1
	fi
}

########################################################################
###############                 SCRIPT                     #############
########################################################################
#avviso prescript
`zenity --warning --text="Prepara un file.txt contenente il testo della mail prima di continuare. (Puoi salvarlo in una directory qualunque)."`
#inizio script
check_software
#put the service you want to use
host=out.alice.it
#put the port you want to use
port=25
(
echo open $host $port
sleep 2
echo helo ciao
echo "mail from: <"`zenity --entry --title="$prog - Insert the Mail Sender" --text="Insert the Mail Sender"`">"
sleep 2
echo "rcpt to: <"`zenity --entry --title="$prog - Insert the Mail of recipient" --text="Insert the Mail of recipient"`">"
sleep 2
echo "data"
sleep 2
echo "from: <"`zenity --entry --title="$prog - Enter the name of the sender" --text="Enter the name of the sender"`">" "<"`zenity --entry --title="$prog - Insert the Mail Sender" --text="Insert the Mail Sender"`">"
echo "to: <"`zenity --entry --title="$prog - Enter the name of the recipient" --text="Enter the name of the recipient"`">" "<"`zenity --entry --title="$prog - Insert the Mail of recipient" --text="Insert the Mail of recipient"`">"
echo "subject: <"`zenity --entry --title="$prog - Insert the subject" --text="Insert the subject"`">"
sleep 2
#scegli file di testo
file=`zenity --file-selection \
	--title="Scegli file testo contenuto mail"`
#contenuto mail e invio
echo "<" `zenity   --text-info \ --title="$prog - Insert the content of mail" \
                   --filename=$file \ --editable 2>/tmp/tmp.txt`">"
echo "."
sleep 10
)| telnet
