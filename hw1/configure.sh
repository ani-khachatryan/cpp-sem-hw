#!/bin/bash

create_judge() {

        username=$(getent passwd | cut -d: -f1 | grep "judge")
        #echo $username
        if [ "$username" == "judge" ]; then
                echo "User 'judge' already exists."
        else
        useradd -m -d /home/judge -s /bin/bash judge
        passwd -d judge 1> /dev/null
        echo "Created the user 'judge'."
        fi
}

get_archive() {

        wget -q -O art.tar https://github.com/ani-khachatryan/csharp-summer-school/raw/master/artefact.tar
        if [ $? -eq 0 ]; then
                echo Download completed successfully!
        else
                echo ":( :( :( :( :("
        fi
        mv art.tar /home/judge
        cd /home/judge
        rm -rf ./Archive
        mkdir ./Archive
        tar -xf art.tar -C ./Archive
        rm art.tar
        echo Artefact lies in /home/judge/Archive.
}

change_owner() {
        chown -R judge /home/judge
}

add_to_path() {
        path=$(find /home/judge -type f -name server)
        cat $path > /home/judge/.bashrc
}

set_permissions() {
        chmod u=r -R /home/judge
        chmod u+x /home/judge/Archive/artefact/server
}

function main() {
        create_judge
        get_archive
        change_owner
        add_to_path
        set_permissions
}

main