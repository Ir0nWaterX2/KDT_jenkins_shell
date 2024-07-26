#!/bin/bash

# 변수 설정
RECIPIENT="a01084922552@gmail.com"
SUBJECT="[김직원]로그파일 보내드립니다. "
BODY="오늘자 로그입니다. 감사합니다.  "
FILENAME="/home/ubuntu/resource_usage.log"

# 이메일 전송
echo "$BODY" | mutt -s "$SUBJECT" -a "$FILENAME" -- "$RECIPIENT"