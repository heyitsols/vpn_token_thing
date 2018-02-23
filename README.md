# vpn_token_thing

My VPN provider utilises access tokens rather than username and password. Purchased tokens last for variable lengths of time, depending on what you choose. This is great as you can have your token rotate on a weekly basis. What's tricky is keeping all your devices updated with this token.

Personally I do this using DNS TXT records, because why not?

How it works is as follows:

`update_dns_token.sh` takes the token, encrypts it with your PGP key, base64s it for added hidden-ness and to fit in a TXT record. The data is then pushed to a TXT record using Cloudflare's API

```
% time ./update_dns_token.sh sup3rS3CR3Ttoken
200
./update_dns_token.sh sup3rS3CR3Ttoken  0.03s user 0.02s system 3% cpu 1.482 total
```

You can see that when I do a dig against the domain I have put aside for my VPN token, I get the smushed and encrypted token back

```
% dig -t txt +short vpn.ols.wtf
;; Truncated, retrying in TCP mode.
"LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpoUUlNQTdOQ1BMVmlzQnFIQVEvL1lUM3JuMzFOVE1ZUm1qK2wxMWMvMFROVWcvNldXMVBKWW1UY04yS0J6SEpRCmxmbjg1bVNZemVsRENBa1hqdjFuK0pnSVQ1eXQzM3ZpS3lmNXNkSTlRSm00VTVRUjF6VkY5N0VGb3QzZTMzeDUKbnZOcENLK3M3SWFnazZYcnV3c1FpaXlqbEVwT29uMDN" "McmF3VXBEREE4NHpxdy9CREpnSnZUSXFrQjBDM3ZhMQo4N2xrV3VEUTlBRlQzREl4K0tGVjcrSTBIZWQ0NmNhYk9OWXNrb284Y3hWMHJ4ZGRlY0Fkam53eFNxWDMvbnFaCld4aGlYK3YxUEVMYStkcC9TN1R6dUtoZ1lpWUtQWFhpUFVSalJwZ0V1amt3c1R3YjhRMHVNWDJEWjlrQkxyQ3QKeVVnNVZyczBzQzdTc2JqM1puWjJhVjdYUDNqY2" "RtOGJ5SXEzbENhUUg5bkZmNFR0RHhTWTNZWWFDRFdEdXY1cQp3eWpNenc0bDBTVFg2RkRZdFljRlFuVXVQQWgyWEJDV2lTelIrZ1h2enBGNEJ3VWlYQkFaZVk1a2NtaXpMYzlnCkRGS0IzYXlYVXFJSHBKU3A4RGpIdytsUU1PME1aM0tWaDN4OUhxcU8xQW1MdFNhcWttWGxNOTNheXVCZkhVWHoKNjNaeUZyMWQ2T1JPTW9iTGlkWHhSaWFUS" "WQ0eWNQWWJpSENGV1ZSWU8yRHVvSkE3eVVia3NZOVJGQVpOSEVRRQppU2RsT2JaemNPbXQvdjRuNnZINWxQMUxoNXIwNTA0TFBjTzI2cm1VamgwVno5NE92SVFtbHlzY0owQ0dBTEtCCkMxbGMxdDJDTDB2clBzcmR3d0dUMTQydHI1MGpwN1BkeUwwYyt4Y0hoTDJUdFo4RkIxUnBxUkNCTGRrTUEvM1MKWFFHc0ZmaHU5Wm9HY3ZzRFFBN3Vr" "VndNeU5JOEVRQ21nRlJpK1djUG0ySTFBT1VLekhzaGJMMWxXWjFpTzdHbQprWlpESlZIRm90WSt3Lzl5QWtYWmJjWGpEVzhKRHRIOTdYdjFYRXlmTHpudEdNZTdBeG8reXJsM3RsRmcvZz09Cj1uU25qCi0tLS0tRU5EIFBHUCBNRVNTQUdFLS0tLS0K"
```

In order to obtain the token, run `get_vpn_token.sh` fetches the token back again by digging, un-smushing, and decrypting, ready for use in whatever config file you need

```
% time ./get_vpn_token.sh
sup3rS3CR3Ttoken
./get_vpn_token.sh  0.01s user 0.01s system 38% cpu 0.073 total
```

As you can see from the outputs above, this is super fast!
