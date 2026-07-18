---
layout: post
title: "bandit2"
---

16-07-2026
13:42

login:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260716134320.png' | relative_url }})

the two dashes `--` in the filename will make the `cat` command pass `spaces in this filename--` as an argument.

so we need to pass it as a file path:
![]({{ '/ctf/overthewire/bandit/' . 'Pasted%20image%2020260716134716.png' | relative_url }})

flag: `7ZZ2LFrykP2zEyvBl4m3clcL7tGYJPME`
