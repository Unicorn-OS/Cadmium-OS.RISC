find_image(){
img=$(find *.img)
if [ $? -eq 0 ];then
export img
else
echo "Image not found, run 'dl.sh' first, then retry."
fi
}

write_to_usb(){
echo "Which USB would you like to use? ex: 'sdZ'"
echo "type 'exit' to cancel"
read usb
if [ $usb == "exit" ]; then exit
else
export $usb
fi
}

confirm(){
echo "Write to /dev/$usb with $img? Confirm: [yes/no]"
read confirmation
if [ $confirmation == "yes" ];then
write_with_dd
else
echo Start over
main
fi
}

write_with_dd(){
echo Writing
sudo dd if=$img of=/dev/$usb bs=50M status=progress; sync
}

main(){
find_image
write_to_usb
confirm
}

main
