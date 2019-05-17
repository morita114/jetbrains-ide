# jetbrains-ide
Script to install Jetbrains IDEs

## Usage
Download script
```shell-session
$ curl -fsSL https://github.com/morita114/jetbrains-ide/raw/master/install.sh -o install.sh
```

Install IDE:
```shell-session
$ bash install.sh pycharm-2019.1.2
```
Install multiple IDEs:
```shell-session
$ bash install.sh pycharm-2019.1.2 clion-2019.1.3
```

## Set PATH
```shell-session
$ echo 'export PATH=${HOME}/.local/bin:${PATH}' >> ~/.bashrc
```
