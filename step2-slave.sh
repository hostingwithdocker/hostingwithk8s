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

## OUTPUT
echo "Use the token & hash which are raised on master node"
echo "> kubeadm join 192.168.0.109:6443 --token xxxxx --discovery-token-ca-cert-hash sha256:xxxxx"

