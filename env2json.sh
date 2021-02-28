#!/bin/bash

s="HOME|HOSTNAME|ENVIRONMENT
$HOME|$HOSTNAME|$ENVIRONMENT"

(echo "$s" | jq -Rn '
            ( input  | split("|") ) as $keys |
            ( inputs | split("|") ) as $vals |
            [[$keys, $vals] | transpose[] | {key:.[0],value:.[1]}] | from_entries') > env.json
