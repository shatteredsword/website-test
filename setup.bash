#INSTALL PODMAN
declare -A osInfo;
osInfo[/etc/redhat-release]="sudo yum -y install podman"
osInfo[/etc/arch-release]="sudo pacman -S podman"
osInfo[/etc/gentoo-release]="sudo emerge app-emulation/podman"
osInfo[/etc/SuSE-release]="sudo zypper install podman"
osInfo[/etc/debian_version]="sudo apt-get install podman"
osInfo[/etc/alpine-release]="sudo apk add podman"

for f in ${!osInfo[@]}
do
    if [[ -f $f ]];then
       ${osInfo[$f]}
    fi
done
#INSTALL MINIKUBE
DOWNLOAD=$(mktemp)
ARC=$(dpkg --print-architecture)
if [ "$ARC" = "amd64" ]; then
  echo "amd64 processor detected"
  curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 -o $DOWNLOAD
elif [ "$ARC" = "armhf" ]; then
  echo "armhf  processor detected"
  curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm -o $DOWNLOAD
elif [ "$ARC" = "arm64" ]; then
  echo "arm64 processor detected"
  curl -L https://storage.googleapis.com/minikube/releases/latest/minikube-linux-arm64 -o $DOWNLOAD
else
  echo "architecture not supported"
  #Operation not permitted
  exit 1
fi
sudo install $DOWNLOAD /usr/local/bin/minikube

