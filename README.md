# vpn_token_thing

My VPN provider utilises access tokens rather than username and password. Purchased tokens last for variable lengths of time, depending on what you choose. This is great as you can have your token rotate on a weekly basis. What's tricky is keeping all your devices updated with this token.

Personally I do this using DNS TXT records, because why not?

How it works is as follows:

`update_dns_token.sh` takes the token, encrypts it with your PGP key, and smushes it to fit in a TXT record. The data is then pushed to a TXT record using Cloudflare's API

```
% time ./update_dns_token.sh sup3rS3CR3Ttoken
200
./update_dns_token.sh sup3rS3CR3Ttoken  0.03s user 0.02s system 3% cpu 1.482 total
```

You can see that when I do a dig against the domain I have put aside for my VPN token, I get the smushed and encrypted token back

```
% dig -t txt +short vpn.ols.wtf
;; Truncated, retrying in TCP mode.
"-----BEGIN PGP MESSAGE-----||hQILA7NCPLVisBqHAQ/3dRjT23k1sIntItvLLzQBbznHG5h0RjXpBkNXRQVpM0IQ|rdVsJobOMocO3sWi2wFhTGnyej4L6lT0Zvxg35RT6zJzCJrMv5zv61CkwoLdla92|xUgLSM257LS7V0OxUWkBMKEaVX2o91RUNBi1i6PFPjgriofoqzdtk9sadZxGWuU3|2AFjmKkKnQLQY2XRbOsNXBijC/ozWdP" "f7BNkjwhivYwyRxcODR/tbqY8vPNACpR7|iXSgKaPCGWqD8+xfnPn9XPq8KRo6LarK9qeM519du4rw58r+VCvWs1OtOGWSNo80|pcz5+nN4ZBr0kAWi5rZsJYLZ/RZoAlemddljSR8Z8qVSMfqKIjGJsROIXu2Ym9gA|s6QEsP5T3ucgZS6H62t2/UiVisaj4pV9Tue3aHI8lQdypysbi+Kbt0N0qMskUvNa|7yc1S7jQI/ylFLSoiVW1DwtGFZ" "tEnI9VZAJQ+l+il7FFcmxTRrDXCTtxU8AoPsUf|qiRuUCHdOQ/FZUq9H4fNIygTthTVIUM4bDpNO//tOkVOXXHTxUMyKorf4ykHF54u|Wrq9LAQVsrvonKYZCOEbcui7xrH57x8U/6PhWrY6OjbUwdahqBxam74xGXvLzI8Q|aWVi9+zuslNWp1tZWW74VIjUGkwDu8+5m8Ewo8W6XJuXWF/vIUpa/iNKzWhg5dJO|ARnZqnDDId6BcP/IdLJps" "ETu4HEWnHwjAz9xs3GdfNJk7dDP+SI2sjzFdQqqXZL+|R4UOrV0VtoEbD8qR+xhVgiKGdYLSNhauiSbQJW9M|=ykL5|-----END PGP MESSAGE-----"
```

In order to obtain the token, run `get_vpn_token.sh` fetches the token back again by digging, un-smushing, and decrypting, ready for use in whatever config file you need

```
% time ./get_vpn_token.sh
sup3rS3CR3Ttoken
./get_vpn_token.sh  0.01s user 0.01s system 38% cpu 0.073 total
```

As you can see from the outputs above, this is super fast!
