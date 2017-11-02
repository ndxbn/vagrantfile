#!/bin/bash -eu
alias log="logger -s"
FILE_PATH='/home/ubuntu/.bashrc'

if [ -f ${FILE_PATH} ]
then
  mv ${FILE_PATH}{,_} || log "fail to disable ${FILE_PATH}"
else
  log "${FILE_PATH} is not exists."
fi
