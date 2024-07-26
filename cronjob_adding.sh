
#!/bin/bash


# crontab 폴더 없으면 만들어주기 
mkdir -p /home/ubuntu/crontab

# 쉘스크립트에 권한주기 
chmod +x /home/ubuntu/shell/resource_loging.sh
chmod +x /home/ubuntu/shell/sending_mail.sh


#  크론잡에 실행할 구문 
CRON_JOB1="*/1 * * * * /home/ubuntu/shell/resource_loging.sh"
#(실습용)
CRON_JOB2="*/1 * * * * sudo logrotate -f /etc/logrotate.d/resourcelog"
CRON_JOB3="*/1 * * * * sh /home/ubuntu/shell/sending_mail.sh"

#chmod a+rw /home/ubuntu/crontab/new_crontab.txt
#chmod a+rw /home/ubuntu/crontab/current_crontab.txt

# 현재 돌아가고있는 크론탭을 임시 파일에 백업
crontab -l > /home/ubuntu/crontab/current_crontab.txt


# 임시 파일에서 특정 구문을 포함하지 않는 라인만을 새로운 파일로 저장
grep -v "* * * * * /home/ubuntu/shell/resource_loging.sh" /home/ubuntu/crontab/current_crontab.txt | \
grep -v "* * * * * sudo logrotate -f /etc/logrotate.d/resourcelog" | \
grep -v "* * * * * /home/ubuntu/shell/sending_mail.sh" > /home/ubuntu/crontab/new_crontab.txt


#  로깅 쉘스크립트 등록 구문을 추가
echo "$CRON_JOB1" >> /home/ubuntu/crontab/new_crontab.txt
#( 실습용 - 로테이트를 1분에 한번씩 )
echo "$CRON_JOB2" >> /home/ubuntu/crontab/new_crontab.txt
echo "$CRON_JOB3" >> /home/ubuntu/crontab/new_crontab.txt


# 새로운 크론탭 파일을 적용
crontab /home/ubuntu/crontab/new_crontab.txt


# old_log 폴더 없으면 만들어주기 
mkdir -p /home/ubuntu/old_log

# 크론 재실행 
sudo systemctl restart cron
