---
layout: post
title: "bandit5"
---

16-07-2026
14:07

level goal:
![](pics/Pasted%20image%2020260716140927.png)

login:
![](pics/Pasted%20image%2020260716140808.png)

call `man find`:
![](pics/Pasted%20image%2020260716141035.png)

great, its exactly what we need.
finding a non-executable:
![](pics/Pasted%20image%2020260716142018.png)

the `!` is for negation:
![](pics/Pasted%20image%2020260716141724.png)

to search for executables:
![](pics/Pasted%20image%2020260716141833.png)

so, to find all non-executable files in all directories we call `find ! -executable` or `find \! -executable`:
![](pics/Pasted%20image%2020260716141903.png)

now, to find byte size:
![](pics/Pasted%20image%2020260716142208.png)

and to use with the "file" command for finding the human-readable files:
![](pics/Pasted%20image%2020260716142831.png)

combining all these:
`$ find ! -executable -size 1033c -exec file {} \; | grep 'ASCII'`

`|` pipes the output of `find` to the `grep` command, which looks for a specific pattern (in this case, its "ASCII").

![](pics/Pasted%20image%2020260716143050.png)

flag: `pXa26xhMWaC2SvDotA4r9EgZkulOeSBW`

