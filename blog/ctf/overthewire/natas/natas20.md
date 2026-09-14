---
layout: post
title: "natas20"
---

31-08-2026
15:27
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260831153225.png' | relative_url }})
w

![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260831154846.png' | relative_url }})
the `mywrite()` method saves the `$data` parameter inside a file, the data is separated by a newline `\n`. meaning we could inject our own key and value using this newlines:
``` php
name => "roee"\n # <--- newline is inserted by us here
admi => 1
```

theres also a debug method:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260831164852.png' | relative_url }})![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260831164935.png' | relative_url }})![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260831165032.png' | relative_url }})

ill inject it in burpsuite:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260831171247.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260831171302.png' | relative_url }})

flag: 7meHZ1l2zPoK2v1qfTUxq4Ydfja4UlmU