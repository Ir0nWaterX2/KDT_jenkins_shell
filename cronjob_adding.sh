
#!/bin/bash

#  제외하고싶은 구문
CRON_JOB="*/5 * * * * /home/ubuntu/crontab/log_resource_usage.sh"

# 현재 돌아가고있는 크론탭을 임시 파일에 백업
crontab -l > /home/ubuntu/crontab/current_crontab.txt

# 임시 파일에서 특정 구문을 포함하지 않는 라인만을 새로운 파일로 저장
grep -v "$CRON_JOB" /home/ubuntu/crontab/current_crontab.txt > /home/ubuntu/crontab/new_crontab.txt


#  로깅 쉘스크립트 등록 구문을 추가
echo "*/5 * * * * /usr/local/bin/log_resource_usage.sh" > /home/ubuntu/crontab/new_crontab.txt

# 새로운 크론탭 파일을 적용
crontab new_crontab.txt


# 임시 파일 삭제
rm /home/ubuntu/crontab/current_crontab.txt /home/ubuntu/crontab/new_crontab.txt
