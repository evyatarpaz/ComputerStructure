#!/bin/bash

echo "Enter your ID[Teudat_Zehut] number:"
read id

echo "Enter your Full Bar-Ilan Email Address:"
read mail

query_string="http://127.0.0.1:15213/?username=$USER&usermail=$mail&submit=Submit"
wget_cmd="wget --content-disposition $query_string"
ssh_cmd="ssh -f -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=quiet -N -L 15213:127.0.0.1:15213 localhost"

eval $ssh_cmd

echo "Trying to download bomb file..."
wget -q -t 3 --content-disposition $query_string

if [ $? -eq 0 ]
then
  echo "File downloaded Successfully:"
  ls -la bomb*
else
  echo "File download failed :("
fi

echo "Closing ssh tunnel"
pkill -u $USER -f "ssh -f"

echo "Have a nice day =)"
