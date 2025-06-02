#!/usr/bin/env python3
import sys
import json

# Enable line buffering to minimize risk of
# data loss or partial writes while log rotation is running
# TODO: Is line buffering turned on by default for stdout?
sys.stdout.reconfigure(line_buffering=True)

FIELD_DELIM = '\\x1F'
RECORD_DELIM = '\\x1E'

for line in sys.stdin:
    line += line
    if line.rstrip().endswith(RECORD_DELIM):
        line = line.rstrip()[:-4]  # remove trailing \x1E
        record = {}
        for field in line.split(FIELD_DELIM):
            if '=' in field:
                key, value = field.split('=', 1)
                record[key.strip()] = value
        print(json.dumps(record, ensure_ascii=False))
        line = ""
