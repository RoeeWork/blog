---
layout: post
title: "bandit1"
---

16-07-2026
13:30

Login:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260716133033.png' | relative_url }})

calling `$ cat -`  wont work here, it will just attempt to read from `stdin`. so we should cat the filepath `./"-"`:
![]({{ '/ctf/overthewire/bandit/' . 'pics/Pasted%20image%2020260716133302.png' | relative_url }})
got it

flag: `PK8fYLZg2hnHSz83plBL1iEPKdD3QToB`