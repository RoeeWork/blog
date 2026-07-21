---
layout: post
title: "bandit20"
---

21-07-2026
13:53
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260721140116.png' | relative_url }})

to run jobs in the background, suspend the job using CTRL+Z and then run "bg":
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260721140345.png' | relative_url }})

now `suconnect` is listening on port `30000`, lets connect to localhost and paste in the password:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260721140656.png' | relative_url }})
why is this happening?

ok i get the problem, i thought that `suconnect` creates a server to which you can connect through telnet and copy-paste the password to get the flag (like the other challenges). but in reality this creates a connection the port we specify, and listens for the password.
so well just create a server that echos the password using netcat:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260721141754.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260721141905.png' | relative_url }})
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260721142152.png' | relative_url }})

flag: bW9kBv5WC3P4yoDyf12LSdGuNz5ka6hY
