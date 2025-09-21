# project path
<!-- keep the format => ktf -->
## idea from here [![alt text][1]](xxx)
<!-- keep the format -->
## **wget -qO-** [![alt text][1]](https://superuser.com/questions/321240/how-do-you-redirect-wget-response-to-standard-out)
<!-- keep the format -->
## Execute Bash Script Directly From a URL [![alt text][1]](https://www.baeldung.com/linux/execute-bash-script-from-url)
<!-- ktf -->
- Most Linux distributions have wget installed by default
<!-- ktf -->
```bash <!-- markdownlint-disable-line code-block-style -->
wget -qO - http://example.com/script.sh | bash
```
<!-- ktf -->
## Path of script
<!-- ktf -->
<!-- markdownlint-disable MD034 -->
https://raw.githubusercontent.com/MathiasStadler/rust_init_project/refs/heads/main/scripts/dummy.sh
<!-- markdownlint-enable MD034 -->
<!-- ktf -->
## Execute path in folder tmp **WITHOUT** save the script itself
<!-- ktf-->
```bash <!-- markdownlint-disable-line code-block-style -->
cd && cd /tmp
wget -qO - https://raw.githubusercontent.com/MathiasStadler/rust_init_project/refs/heads/main/scripts/dummy.sh | sh
```
<!-- ktf -->
## Execute path in folder tmp **WITH** save the script itself
<!-- ktf-->
```bash <!-- markdownlint-disable-line code-block-style -->
cd && cd /tmp
SCRIPT_URL="https://raw.githubusercontent.com/MathiasStadler/rust_init_project/refs/heads/main/scripts/dummy.sh"
SCRIPT_NAME="$(basename $SCRIPT_URL)" && wget $SCRIPT_URL -O $SCRIPT_NAME && sh +x $SCRIPT_NAME
# quiet - no wget output
SCRIPT_URL="https://raw.githubusercontent.com/MathiasStadler/rust_init_project/refs/heads/main/scripts/dummy.sh"
SCRIPT_NAME="$(basename $SCRIPT_URL)" && wget --quiet $SCRIPT_URL -O $SCRIPT_NAME && sh +x $SCRIPT_NAME
```
<!-- ktf-->
## shellcheck - install debian
<!-- ktf-->
```bash <!-- markdownlint-disable-line code-block-style -->
sudo apt install shellcheck
```
<!-- ktf-->
## shellcheck - use on debian/bash
<!-- ktf-->
```bash <!-- markdownlint-disable-line code-block-style -->
bash --version
# GNU bash, version 5.2.37(1)-release (x86_64-pc-linux-gnu)
shellcheck --version
#ShellCheck - shell script analysis tool
#version: 0.10.0
```
<!-- ktf-->
## shellcheck - How to used it from your terminal
<!-- ktf-->
```bash <!-- markdownlint-disable-line code-block-style -->
shellcheck scripts/dummy.sh
```
<!-- keep the format -->
## Setup for user
<!-- keep the format -->
```bash <!-- markdownlint-disable-line code-block-style -->
```
<!-- keep the format -->
## dummy code block
<!-- keep the format -->
```bash <!-- markdownlint-disable-line code-block-style -->
```
<!-- keep the format -->
For further steps, see Project path [![alt text][1]](project_path.md)
<!-- make folder and download the link sign vai curl -->
<!-- mkdir -p img && curl --create-dirs --output-dir img -O  "https://raw.githubusercontent.com/MathiasStadler/link_symbol_svg/refs/heads/main/link_symbol.svg"-->
<!-- Link sign - Don't Found a better way :-( - You know a better method? - **send me a email** -->
[1]: ./img/link_symbol.svg
<!-- keep the format -->