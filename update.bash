#!/bin/bash

function backup () {
    cp /etc/lsb-release ./lsb-release.bak
    cp /usr/lib/os-release ./os-release.bak
}

function run_update () {

    backup
    echo "Execute the update. Please wait for a little while."
    echo -e "\\nRun apt-get -y update\\n" >> update.log
    apt-get -y update  >> update.log
    echo -e "\\nRun apt-get -y upgrade\\n" >> update.log
    apt-get -y upgrade >> update.log
    echo -e "\\nRun apt-get -yf install xfce4-terminal\\n" >> update.log
    apt-get -yf install xfce4-terminal >> update.log
    echo -e "\\nRun apt-get -y purge gnome-terminal\\n" >> update.log
    apt-get -y purge gnome-terminal >> update.log
    echo -e "\\nRun apt-get -y autoremove --purge\\n" >> update.log
    apt-get -y autoremove --purge >> update.log
    echo -e "\\nos-release\\n" >> update.log
    cp os-release /usr/lib/os-release >> update.log
    echo -e "\\nlsb-release\\n" >> update.log
    cp lsb-release /etc/release >> update.log
    echo -e "\\nSince we have not confirmed whether the script has terminated normally, please refer to the log file (located in the same folder as the script)."
    echo -e "\\nスクリプトが正常に終了しているかどうかは確認していないので、各自でログファイル（スクリプトと同じフォルダにあります）を参照してください。\\n"
}

if [[ ${UID} = 0 ]]; then
    if [[ -f update.log ]]; then
        rm update.log
    fi

    echo "Are you sure you want to update the version of SereneLinux to 19Q1.4.2? [Y/n]"
    echo "SereneLinuxのバージョンを19Q1.4.2に更新してよろしいですか？ [Y/n]"
    read yN
    case $yN in
        "" | "Y" | "y" | "yes" | "Yes" | "YES" ) run_update ;;
                                             * ) exit 1;;
    esac
else
    echo "You need Root permission."
    echo "Root権限が必要です。"
    exit 1
fi