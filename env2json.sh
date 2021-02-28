#!/bin/bash

s="HOME|HOSTNAME|ENVIRONMENT|DEMO_GREETING|DEMO_FAREWELL:
$HOME|$HOSTNAME|$ENVIRONMENT|$DEMO_GREETING|$DEMO_FAREWELL:"

(echo "$s" | jq -Rn '
            ( input  | split("|") ) as $keys |
            ( inputs | split("|") ) as $vals |
            [[$keys, $vals] | transpose[] | {key:.[0],value:.[1]}] | from_entries') > env.json
