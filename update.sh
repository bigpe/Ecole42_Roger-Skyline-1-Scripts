RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;36m'
ORANGE='\033[0;33m'
NC='\033[0m'
USER=@`whoami`
LOG=/var/log/update_script.log
TIME=`date '+%d/%m %H:%M'`
COUNT=`sudo apt update 2>/dev/null | tail -n 1 | awk -F "." '{print $1}'`
echo $USER" - "$TIME" | " $COUNT | tee -a $LOG
PACK=`sudo apt list --upgradable 2>/dev/null | tail -n +2 | awk -F "/" '{print $1}'`
echo ${ORANGE}Updating...${NC} | tee -a $LOG
for p in $PACK
do
echo [${GREEN}OK${NC}] ${BLUE}$p${NC} | column -t | tee -a $LOG
apt install $p > /dev/null
done
