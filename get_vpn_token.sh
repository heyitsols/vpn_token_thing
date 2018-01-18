#!/usr/bin/env bash

token_plain=$(dig -t txt <YOUR DOMAIN> +short +tcp | sed 's/"//g' | base64 -D | gpg -qd)

printf "$token_plain"
