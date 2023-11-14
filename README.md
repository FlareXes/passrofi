<h1 align="center">Passrofi</h1>
<p align="center">Rofi/dmenu to autofill TOTP for pass-otp. A better, faster and suckless way to autofill otps</p>

#

<img src="https://raw.githubusercontent.com/FlareXes/passrofi/main/passrofi-demo.gif" width="460" align="right" />


Before using this script make sure you're using [pass-otp](https://github.com/tadfisher/pass-otp). A pass extension for managing one-time-password (OTP) tokens.

Check this blog post for info and explaination of this script [How to Setup and Autofill OTP Using Pass-OTP?](https://flarexes.com/how-to-setup-and-autofill-otp-using-pass-otp)

> **Note:** `Passrofi` default uses `rofi`. You can can also use `dmenu` by uncommenting 17th line and comment 13th line.

## Prerequisite
```
- Rofi / Dmenu
- xclip
- xdotool
```

# Installation

```
wget https://raw.githubusercontent.com/FlareXes/passrofi/main/passrofi -O /usr/local/bin/passrofi

sudo chmod +x /usr/local/bin/passrofi
```

## Keyboard Bindings
It's best to bind `passrofi` with Keyboard shortcut. I use `sxhkdrc` but you're free to use any.

```
# Pass-Otp
alt + shift + l
  /usr/local/bin/passrofi
```

# Resources
- [A Step-by-Step Guide to Use pass-OTP and passrofi for Secure 2FA Management](https://flarexes.com/how-to-setup-and-autofill-otp-using-pass-otp).

- [How to manage Linux passwords with the pass command](https://www.redhat.com/sysadmin/management-password-store).

## How to update GPG keys?
Encrypting your OTPs with new GPG keys is a crucial security practice. To simplify this process, I've created a bash script, `passrofi-update-keys.sh`. This script automates the key update, ensuring that your OTPs remain secure. 
Additionally, it keeps a backup of your previous keys for added safety. Existing `~/.password-store` and `~/.gnupg` will be backed up as `~/.password-store-bak`, `~/.gnupg-bak` respectively.

1. Run `bash passrofi-update-keys.sh`
2. This will decrypt and export all TOTPs' URIs into a file named `passwords.csv`.
3. Then, Choose to either create new keys (recommended) or select existing ones.
4. From here, Script will handle the update automatically. If any errors occur, script will stop, allowing you to debug.
5. ***Important:* Don't forget to delete `passwords.csv` once the update is complete. The script won't do it for you.***

> **Note:** I recommend updating GPG keys once or twice a year.

I hope this might have saved you some time and hustle.

# LICENSE
MIT License

Copyright (c) 2022 FlareXes

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
