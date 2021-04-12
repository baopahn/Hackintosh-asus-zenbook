#!/bin/bash
IASL='./tools/iasl -vw 3073 -vi -vr -p'

# Select wifi card
. ./src/wifi.txt
echo "[0%]: Select kext wifi:"
PS3='Select model wifi: '
select opt_wifi in "${MODELSWIFI[@]}"
do
    for i in "${!MODELSWIFI[@]}"; do
        if [[ "${MODELSWIFI[$i]}" = "${opt_wifi}" ]]; then
            opt_wifi=$i
            break 2
        fi
    done
    echo Invalid
    echo
done
echo

# Download kext
echo "[25%]: Download resource:"
# rm -r ./download
# sh "${MODELDOWNLOAD[$opt_wifi]}"

# Select model
. ./src/models.txt
echo "[75%]: Select model laptop:"
PS3='Select model: '
select opt in "${MODELS[@]}"
do
    for i in "${!MODELS[@]}"; do
        if [[ "${MODELS[$i]}" = "${opt}" ]]; then
            modelidx=$i
            break 2
        fi
    done
    echo Invalid
    echo
done
echo

# Load model config
. ./src/models/"${MODELCONFIG[$modelidx]}"

rm -rf build && mkdir build

# Copy OpenCore EFI folder
cp -R download/oc/OpenCorePkg/X64/EFI build

OCFOLDER="build/EFI/OC"

# Build ACPI
for j in "${!AMLFILES[@]}"; do
    $IASL $OCFOLDER/ACPI/"${AMLFILES[$j]}".aml src/acpi/"${AMLFILES[$j]}".dsl
done

# Copy UEFI Drivers
cp -R download/drivers/* $OCFOLDER/Drivers/

# Copy kexts
cp -R download/kexts/* $OCFOLDER/Kexts/
cp -R src/kexts/* $OCFOLDER/Kexts/

# Copy OpenCore config
cp src/"${MODELCONFIGWIFI[$opt_wifi]}"/$CONFIGPLIST $OCFOLDER/config.plist

echo "[100%]: Serial number:"
# Replace SMBIOS
if [ -e src/smbios.txt ]; then
    read -p "Serial number exists. Do you want to use the old serial number? [y/n]: "  should_create
    if test "$should_create" = "n" || test "$should_create" = "N"; then
      rm -f src/smbios.txt && ./GenSMBIOS/GenSMBIOS.command >> src/smbios.txt
    fi
else
    ./GenSMBIOS/GenSMBIOS.command >> src/smbios.txt
fi

. ./src/smbios.txt
sed -i "" -e "s/MLB_PLACEHOLDER/$MLB/" \
          -e "s/Serial_PLACEHOLDER/$SystemSerialNumber/" \
          -e "s/SmUUID_PLACEHOLDER/$SystemUUID/" $OCFOLDER/config.plist

# Remove unused UEFI Drivers
find $OCFOLDER/Drivers ! -name AudioDxe.efi \
                       ! -name HfsPlus.efi \
                       ! -name OpenRuntime.efi -type f -delete

# Remove unused UEFI Tools
rm -rf $OCFOLDER/Tools

# Copy EFI
rm -r ./../EFI
mv -v ./build/EFI ./../EFI
cat ./logo/logo_done.txt
