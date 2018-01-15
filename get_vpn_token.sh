#!/usr/bin/env bash

token_plain=$(dig -t txt <YOUR DOMAIN> +short +tcp | sed 's/"//g' | sed -e $'s/|/\\\n/g' | gpg -qd)

printf $token_plain
