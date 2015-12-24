#!/bin/bash
#
# Verne.mq Docker Image
# 

cp /host/vernemq.conf.default /etc/vernemq/vernemq.conf
cp /host/vmq.acl.default /etc/vernemq/vmq.acl
cp /host/vmq.passwd.default /etc/vernemq/vmq.passwd

touch /var/log/vernemq/console.log
vernemq start
tail -f /var/log/vernemq/console.log
