cat ./ToolCreateEFI/logo_paopao.txt

echo
echo "[1]: Create EFI."
echo "[2]: Fix Audio."
echo
echo "[q]: Quit."
echo
read -p "Select: " option

case $option in
  "1")
    echo "= CREATE EFI ="
    cd ToolCreateEFI && sh build.sh
    exit
    ;;
  2)
    echo "= FIX HEADPHONE AUDIO ="
    cd Audio/Script && sh Uninstall.sh && sh Install.sh
    ;;
  *) 
    echo "Exit!!"
    ;;
esac