#!/bin/bash

s="HOME|HOSTNAME|PWD
$HOME|$HOSTNAME|$PWD"

(echo "$s" | jq -Rn '
            ( input  | split("|") ) as $keys |
            ( inputs | split("|") ) as $vals |
            [[$keys, $vals] | transpose[] | {key:.[0],value:.[1]}] | from_entries') > env.json
