---
layout: post
title: "bandit8"
---

16-07-2026
15:15

![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716151639.png' | relative_url }})

from the man pages of `uniq`:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716153508.png' | relative_url }})
it only filters out *adjecent* match lines. we'll take a look at `sort` man page:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716153847.png' | relative_url }})

so we will pipe sorts output into uniq:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716153924.png' | relative_url }})

flag: `EjmOSvuAu7sGAHqHVcBDPirRe9T03kxl`
