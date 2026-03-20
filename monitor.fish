#!/usr/bin/env fish

if ! test -n "$DB_IP"
    echo 'The DB_IP variable must be set'
    exit 1
end

if ! test -n "$DB_PORT"
    echo 'The DB_PORT variable must be set'
    exit 1
end

while true
    sleep (random 60 300)

    for host in $argv
        set msec (ping -q -c 5 $host | tail -n 1 | cut -d = -f 2 | cut -d / -f 2)
        set time (math "$msec / 1000")

        if test $status -eq 0
            echo "ping_times,host=$host sum=$time" | ncat --udp $DB_IP $DB_PORT
            echo "$host: $time seconds"
        end
    end
end
