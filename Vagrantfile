Vagrant.configure("2") do |config|
  # Definir VM1 como servidor web
  config.vm.define "vm1" do |vm1|
    vm1.vm.box = "ubuntu/jammy64"           # Ubuntu 22.04 LTS (no hay box oficial de 24.04):contentReference[oaicite:0]{index=0}
    vm1.vm.hostname = "vm1"
    vm1.vm.network "private_network", ip: "192.168.50.10"  # IP fija para VM1
    vm1.vm.provision "shell", path: "provision/backend.sh"
  end

  # Definir VM2 como servidor web
  config.vm.define "vm2" do |vm2|
    vm2.vm.box = "ubuntu/jammy64"           # Misma caja que VM1
    vm2.vm.hostname = "vm2"
    vm2.vm.network "private_network", ip: "192.168.50.20"  # IP fija para VM2
    vm2.vm.provision "shell", path: "provision/backend.sh"
  end

  # Definir VM3 como balanceador
  config.vm.define "vm3" do |vm3|
    vm3.vm.box = "ubuntu/jammy64"
    vm3.vm.hostname = "vm3"
    vm3.vm.network "private_network", ip: "192.168.50.30"  # IP fija para VM3
    vm3.vm.provision "shell", path: "provision/balancer.sh"
  end
end
