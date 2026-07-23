---
layout: post
title: "bandit25"
---

22-07-2026
16:36

![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260722163652.png' | relative_url }})

ill try to log in and see if it works:

![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260722164039.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260722164050.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260722170325.png' | relative_url }})

from the man pages of the more command:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260723171236.png' | relative_url }})

more is (intended to be) used to view large amounts text one screen at a time. we can exploit this by making our terminal smaller, which will make `more` wait for input before closing our connection. by then we can use `v` to enter vim and explore the server as user bandit26:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260723180630.png' | relative_url }})

pressing v and resizing the terminal:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260723180706.png' | relative_url }})

in vim, you can use the commd `:Ex` to enter a file explorer called netrw:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260723180752.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260723180921.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260723181713.png' | relative_url }})

flag: jHdv2ELQhT22BkprMNDjybZDAkw1zeBJ