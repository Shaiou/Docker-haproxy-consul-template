#!/bin/sh
/usr/local/sbin/haproxy -D -p haproxy.pid -f /etc/haproxy/haproxy.cfg -sf $(cat haproxy.pid) || true
