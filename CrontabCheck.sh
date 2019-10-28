RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;36m'
ORANGE='\033[0;33m'
NC='\033[0m'
LOG=`pwd`/crontab.log
LANG=`echo $LANG | awk -F "." '{print $1}'`
if [ $LANG = "en_US" ]
then
MOD="Modify: "
else
MOD="Изменён: "
fi
echo ${ORANGE}Searching Log File...${NC}
if [ -f $LOG ]
then
echo ${BLUE}[crontab.log] - Found!${NC} [${GREEN}OK${NC}]
else
echo ${RED}Log File - Not Found!${NC}
echo ${BLUE}[crontab.log] - Created!${NC} [${GREEN}OK${NC}]
stat /etc/crontab | grep $MOD | awk -F $MOD '{print $2}' | sed "s/ //g" | tee $LOG > /dev/null
fi
cron_stat=`stat /etc/crontab | grep $MOD | awk -F $MOD '{print $2}' | sed "s/ //g"`
cron_last_update=`cat $LOG`
echo ${BLUE}Cron Last Change${NC} [${GREEN}$cron_stat${NC}]
echo ${BLUE}Cron Last Arhived Change${NC} [${GREEN}$cron_last_update${NC}]
if [ $cron_last_update = $cron_stat ]
then
echo ${BLUE}Change - ${NC}${RED}Not Found!${NC}
equ=1
else
echo ${BLUE}Change - ${NC}${GREEN}Found!${NC}
equ=0
fi
if [ $equ -eq 0 ]
then
stat /etc/crontab | grep $MOD | awk -F $MOD '{print $2}' | sed "s/ //g" | tee $LOG > /dev/null
echo ${GREEN}Sending Mail Attention to Root...${NC}
echo ${ORANGE}Message will avaliable around 2 minutes!${NC}
echo ${ORANGE}Crontab File - Changed!${NC} | mail -s "Change File Attention!" root &
fi


