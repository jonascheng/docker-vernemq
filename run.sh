#!/bin/bash
#
# Verne.mq Docker Image
# 

cp /tmp/vernemq.conf.default /etc/vernemq/vernemq.conf
cp /tmp/vmq.acl.default /etc/vernemq/vmq.acl
cp /tmp/vmq.passwd.default /etc/vernemq/vmq.passwd

sudo vernemq start
tail -f /var/log/vernemq/console.log
