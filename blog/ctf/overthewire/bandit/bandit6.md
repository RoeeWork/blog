---
layout: post
title: "bandit6"
---

16-07-2026
14:33

level goal:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260716143632.png' | relative_url }})

lets look at `find` man page:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260716143840.png' | relative_url }})

also:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260716143909.png' | relative_url }})

right now, the command will output a bunch of "permission denied" errors:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260716150520.png' | relative_url }})

to prevent this, we can redirect `stderr` to `/dev/null`. this outputs:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260716151035.png' | relative_url }})

flag: `Bmnnvf82KzQlfxgAI2d1zYbr1u9pr3E3`
