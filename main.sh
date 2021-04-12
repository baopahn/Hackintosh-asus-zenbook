cat ./ToolCreateEFI/logo/logo_paopao.txt

echo
echo "[1]: Create EFI."
echo "[2]: Fix Audio."
echo
echo "[q]: Quit."
echo
read -p "Select: " option

case $option in
  1)
    cat ./ToolCreateEFI/logo/logo_create_efi.txt
    cd ToolCreateEFI && sh build.sh
    exit
    ;;
  2)
    cat ./ToolCreateEFI/logo/logo_fix_headphone_audio.txt
    cd Audio/Script && sh Uninstall.sh && sh Install.sh
    ;;
  *) 
    echo "Exit!!"
    ;;
esac