---
layout: post
title: "bandit5"
---

16-07-2026
14:07

level goal:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716140927.png' | relative_url }})

login:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716140808.png' | relative_url }})

call `man find`:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716141035.png' | relative_url }})

great, its exactly what we need.
finding a non-executable:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716142018.png' | relative_url }})

the `!` is for negation:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716141724.png' | relative_url }})

to search for executables:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716141833.png' | relative_url }})

so, to find all non-executable files in all directories we call `find ! -executable` or `find \! -executable`:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716141903.png' | relative_url }})

now, to find byte size:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716142208.png' | relative_url }})

and to use with the "file" command for finding the human-readable files:
![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716142831.png' | relative_url }})

combining all these:
`$ find ! -executable -size 1033c -exec file {} \; | grep 'ASCII'`

`|` pipes the output of `find` to the `grep` command, which looks for a specific pattern (in this case, its "ASCII").

![]({{ '/ctf/overthewire/bandit/pics/Pasted%20image%2020260716143050.png' | relative_url }})

flag: `pXa26xhMWaC2SvDotA4r9EgZkulOeSBW`

