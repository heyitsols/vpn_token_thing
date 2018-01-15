#!/usr/bin/env bash

token_plain="$1"

token_enc=$(echo $token_plain | gpg -ear <YOUR PGP KEY> | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n/|/g')

post_data(){
cat <<EOF
{
"type":"TXT",
"name":"<YOUR SUBDOMAIN>",
"content":"$token_enc",
"ttl":"1"
}
EOF
}

curl -X PUT "https://api.cloudflare.com/client/v4/zones/<YOUR DNS ZONE ID>/dns_records/<YOUR DNS RECORD ID>" \
     -H "X-Auth-Email: <YOUR CLOUDFLARE EMAIL>" \
     -H "X-Auth-Key: <YOUR CLOUDFLARE API KEY>" \
     -H "Content-Type: application/json" \
     --data "$(post_data)"
