#!/bin/bash

# Loop through all provided log files
for log_file in "$@"; do
    tail -F "$log_file" | \
    /usr/local/bin/apache_logs_kv_safe_to_json.py >> "/opt/gub-apache2/logs/$(basename $log_file).json" &
done

# Wait for all background tail processes to finish
wait
