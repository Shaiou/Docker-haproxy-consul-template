#!/bin/sh
# sleep to keep script up
stay_up ()
{
while :; do
    sleep 1
done
}

haproxy_cmd ()
{
    case $1 in
        check)
            echo "Checking haproxy config file"
            OPTS="-c"
            ;;
        start)
            echo "Starting haproxy"
            OPTS="-D -p /var/run/haproxy.pid"
            ;;
        reload)
            echo "Reloading haproxy"
            OPTS="-D -p /var/run/haproxy.pid -sf $(cat /var/run/haproxy.pid) -x /var/run/haproxy.sock"
            ;;
    esac
    /usr/local/sbin/haproxy -f /etc/haproxy/haproxy.cfg $OPTS
}

# Handle the SIGHUP from consul
reload_haproxy ()
{
    echo "SIGHUP signal received"
    haproxy_cmd reload
}
trap 'reload_haproxy' HUP

# Start haproxy
haproxy_cmd check
haproxy_cmd start
stay_up
