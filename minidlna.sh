#!/bin/sh

#  minidlna.sh
#
#
#  Created by Amr AlSamahy on 7/5/19.
#
MEMORY_TOOL(){
clear
echo "___  ___ ________  ________________   __";
echo "|  \/  ||  ___|  \/  |  _  | ___ \ \ / /";
echo "| .  . || |__ | .  . | | | | |_/ /\ V / ";
echo "| |\/| ||  __|| |\/| | | | |    /  \ /  ";
echo "| |  | || |___| |  | \ \_/ / |\ \  | |  ";
echo "\_|  |_/\____/\_|  |_/\___/\_| \_| \_/  ";
echo "                                        ";
echo "                                        ";
echo " _____ _____  _____ _                   ";
echo "|_   _|  _  ||  _  | |                  ";
echo "  | | | | | || | | | |                  ";
echo "  | | | | | || | | | |                  ";
echo "  | | \ \_/ /\ \_/ / |____              ";
echo "  \_/  \___/  \___/\_____/              ";
echo "                                        ";
echo "                                        ";
#
printf "\n***************************\n"
printf "* Memory Tool *\n"
printf "***************************\n\n"
printf " How Can I Help You Today"
printf "\n---------------\n"
printf "Press \"C\" For Combo Choice\n"
printf "Press \"F\" to Check Current Memory\n"
printf "Press \"P\" For Droping pagecache\n"
printf "Press \"Q\" To Quite\n"
read -n 1 INPUT
case $INPUT in
c|C)            # Combo Choice
################## pagecache clearer ####################
printf " "
printf "\nPurging...\n"
printf "\n---------------\n"
printf "Before"
printf "\n-------------------------.\n"
free -m                                         ## check free memory.
printf "\n-------------------------.\n"
printf 1 > /proc/sys/vm/drop_caches               ## empty cache.
printf "After"
printf "\n-------------------------.\n"
free -m                                         ## check free memory.
printf "\n-------------------------.\n"
printf "Done\n"
sleep 1
;;
f|F)        # check just free memory.
printf "\nCurrent Memory State"
printf "\n-------------------------.\n"
free -m
printf "\n-------------------------.\n"
;;
p|P)
printf "\nPurging...\n"
echo 1 > /proc/sys/vm/drop_caches
;;
q|Q|*)
printf "\nExiting...\n"
exit 1
;;
esac
################## End of pagecache clearer ####################
}

MINIDLNA_MANAGER(){
#####################################################
################ MiniDLNA Service Manager ##########
#####################################################
clear
#
echo "___  ____       _______ _      _   _   ___  ";
echo "|  \/  (_)     (_)  _  \ |    | \ | | / _ \ ";
echo "| .  . |_ _ __  _| | | | |    |  \| |/ /_\ \ ";
echo "| |\/| | | '_ \| | | | | |    | . \` ||  _  |";
echo "| |  | | | | | | | |/ /| |____| |\  || | | |";
echo "\_|  |_/_|_| |_|_|___/ \_____/\_| \_/\_| |_/";
echo "                                            ";
echo "                                            ";
#
printf "\n***************************\n"
printf "* MiniDLNA Service Manager *\n"
printf "***************************\n"
printf " How Can I Help You Today"
printf "\n---------------. \n"
printf "Press ""S"" to Start MiniDLNA service\n"
printf "Press ""H"" to Stop MiniDLNA Service\n"
printf "Press ""E"" to Enable MiniDLNA Service\n"
printf "Press ""D"" to Disable MiniDLNA Service\n"
printf "Press ""L"" to Reload MiniDLNA Service\n"
printf "Press ""R"" to Restart MiniDLNA Service\n"
printf "Press ""B"" to Delete Current MiniDLNA Database\n"
printf "Press ""Q"" to Quit MiniDLNA Service Manager\n"

read -n 1 MANAGE
case $MANAGE in             # Selector Start
s|S)
printf "\nStarting MiniDLNA\n"
/etc/init.d/minidlna start                # start minidlna service
printf "Start Service Done\n"
exit
;;
h|H)
printf "\nStopping MiniDLNA\n"
/etc/init.d/minidlna stop                # stop minidlna service
printf "MiniDLNA Service Stopped\n"
exit
;;
e|E)
printf "\nEnable MiniDLNA\n"
/etc/init.d/minidlna enable                # enable minidlna service
printf "MiniDLNA Service Enabled\n"
exit
;;
d|D)
printf "\nDisable MiniDLNA\n"
/etc/init.d/minidlna disable                # Disable minidlna service
printf "MiniDLNA Service Disabled\n"
exit
;;
l|L)
printf "\nReload MiniDLNA\n"
/etc/init.d/minidlna reload                # Reload minidlna service
printf "MiniDLNA service Reloaded\n"
exit
;;
r|R)                                           # Restart minidlna service
printf "\nRestarting MiniDLNA\n"
/etc/init.d/minidlna restart
printf "Restart Finished\n"
exit
;;
b|B)
printf "\nIf your database is large it will take sometime to Populate\n"
printf "Delete Databse file too? (Y/N)\n"
read -n 1 DEL_DB1
case $DEL_DB1 in
n|N)
echo "\ncool cool cool"
;;
y|Y|*)
printf "\nAre You Sure? (Y/N)\n"
read -n1 DEL_DB2
case $DEL_DB2 in
n|N)
echo "\nDatabase File NOT deleted"
;;
y|Y|*)
printf "\nLocating and Deleteing Database...\n"
# get the output of "UCI", awk to remove everything else except the path itself, store it in variable DB,
# use the variable to run the "rm" command or notify if the file was already deleted.
uci show minidlna | awk -F"'" '/db_dir/{print $2}' | ( read DB; (rm $DB/files.db) && printf "Database Deleted\n" || printf " \nDatabase file is already Deleted\n")
printf "Restarting the MiniDLNA service to re-make and Populate your Database\n"
;;
esac     # End Inner case switch
;;
esac
exit
;; # end of b|B)
q|Q)                        # Quit
printf "\nExiting\n"
exit
;;
*)
echo " "
printf "You Didn't Choose. Exiting...\n"
exit 10
;;
esac                        # Selector End
###########################################################
############ End of MiniDLNA Service Manager ##############
###########################################################
}
##########################################################################
# parse CLI input
while getopts "mt" OPTS; do
case $OPTS in
m)  MINIDLNA_MANAGER;;
t)  MEMORY_TOOL;;
*)
printf "\ninvalid input. did you mean -a\n"
exit 0
;;
esac
done
shift $(($OPTIND - 1))              # End of CLI Parser
##########################################################################
printf "Welcome\n"
printf "Make Your Choice\n"
printf " \"T\" to Open Memory Tool\n"
printf " \"M\" to Open MiniDLNA Service Manager\n"
printf " \"Q\" to Exit\n"
read -n 1 CHOICE
echo " "
case $CHOICE in
t|T)                # Memory Manager
MEMORY_TOOL
;;
m|M)        # Manage MiniDLNA
MINIDLNA_MANAGER        # Call out to MINIDLNA_MANAGER from main case Selector.
;;         # End of Manage MiniDLNA Service Manager from script's starting Case.
q|Q|*)
printf "Exiting....\n\n"
exit
;;
esac

