---
layout: post
title: "natas11"
---

09-08-2026
11:50
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809115033.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809115106.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809115125.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809115137.png' | relative_url }})
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809115152.png' | relative_url }})

the goal here is to set the `showpassword` cookie to "yes", the problem is the xor encryption key is set to `"<censored>"` (this isnt the key, trying to decrypt the cookie with this as the key yields garbage.)

possible entry points:
- XOR encryption 
- the `preg_match` warning
-  the `loadData()` function seems to decrypt the cookie data using `json_decode(), xord_encrypt(), base64_decode()`.
- this line of code, what happens if the preg_match fails?
  ![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809121239.png' | relative_url }})
- once we have the key, we will be able to easily get the flag.
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809132619.png' | relative_url }})
for the input `#ffffff`, the key result is: 
`EGAgHwQ1IxYYMSQYGSZxTUksPFVHYDEQCC0%2FGBlgaVVIJDURDSQ1VRY%3D`
"%3D" is the equivilent of "=", so the result data is:

`EGAgHwQ1IxYYMSQYGSZxTUksPFVHYDEQCC0%2FGBlgaVVIJDURDSQ1VRY=`

in xor:
```
A (+) B = C
B = A (+) C
```
in this case:
```
plaintext (+) key = ciphertext
key = plaintext (+) ciphertext 
```
we can get the plaintext by crafting our own cookie and emit the xor encryption:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809150330.png' | relative_url }})
plaintext result:
`eyJzaG93cGFzc3dvcmQiOiJubyIsImJnY29sb3IiOiIjZmZmZmZmIn0=`
now to get the key, we can just decode from base64 and xor both results:
```
EGAgHwQ1IxYYMSQYGSZxTUksPFVHYDEQCC0%2FGBlgaVVIJDURDSQ1VRY=
eyJzaG93cGFzc3dvcmQiOiJubyIsImJnY29sb3IiOiIjZmZmZmZmIn0=
```

![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809153246.png' | relative_url }})
the key is `kBSwkBSwkBSwkBSwkBSwkBSwkBSwkBSwkBSwkBSwk`
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809153329.png' | relative_url }})
now we can create a cookie and forward it using burpsuite:
![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809162129.png' | relative_url }})![]({{ '/ctf/overthewire/natas/pics/Pasted%20image%2020260809162153.png' | relative_url }})

flag: EAGkE8uzFTxeoTT2mMst9Xy7PX6guEng