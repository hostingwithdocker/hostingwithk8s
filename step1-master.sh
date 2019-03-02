echo "[>>>] Installation script for K8s. Referer https://www.learnitguide.net/2018/08/install-and-configure-kubernetes-cluster.html"

echo "[s01] Install k8s repo"
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

echo "[s02] Install k8s"
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

echo "[s03] Enable kubelet service"
systemctl start kubelet && systemctl enable kubelet

echo "[s04] setup firewall...."
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables

echo "[s05] setup master node"
kubeadm init --apiserver-advertise-address 192.168.0.109 --pod-network-cidr=172.16.0.0/16

## OUTPUT
## kubeadm join 192.168.0.109:6443 --token imvwla.3zkxxggogyeglmqp --discovery-token-ca-cert-hash sha256:348bd5c76b560af6ea27b6b284c2d50692475d6730d137967d4c237dc1aa2818

echo "[s06] copy the config file"
mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml