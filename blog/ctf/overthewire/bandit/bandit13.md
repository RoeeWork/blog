---
layout: post
title: "bandit13"
---

20-07-2026
17:53

![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720175339.png' | relative_url }})

log in:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720180726.png' | relative_url }})

so this is the ssh key the talked about
ill just copy it using scp:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720180835.png' | relative_url }})

from the ssh man file, connecting with a private key:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720180942.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720181030.png' | relative_url }})

ssh apparently wont accept keys when their permissions allow users other than the user trying to connect. so ill just change that:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720181157.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720181420.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720181433.png' | relative_url }})

now im logged in:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720181527.png' | relative_url }})

the level information said the password for the next level is stored in etc/bandit_pass/bandit14. so ill check it out:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260720181657.png' | relative_url }})

flag: `aaWecNkG4FhxJQxz07uiwzVP6bJiYS65`