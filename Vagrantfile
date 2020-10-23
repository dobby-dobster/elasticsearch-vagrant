VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

    config.ssh.forward_agent = true

    config.vm.provider :virtualbox do |v|
        v.customize ["modifyvm", :id, "--memory", 1536]
        v.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        v.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    end

    config.vm.define "master" do |master|
        master.vm.box = "centos/7"
        master.vm.network "private_network", ip: "192.168.100.11"
        master.vm.hostname = "master"
        master.vm.provision :shell, :path => "bootstrap.sh"
        master.vm.provision :shell, :path => "plugins.sh"
        master.vm.provider :virtualbox do |v|
            v.name = "master"
        end
    end

    config.vm.define "node1" do |node|
        node.vm.box = "centos/7"
        node.vm.network "private_network", ip: "192.168.100.12"
        node.vm.hostname = "node1"
        node.vm.provision "file", source: "users.csv", destination: "/tmp/users.csv"
        node.vm.provision "file", source: "import.py", destination: "/tmp/import.py"
        node.vm.provision :shell, :path => "bootstrap.sh"
        node.vm.provision :shell, :path => "plugins.sh"
        node.vm.provision :shell, :path => "elasticsearch.sh"
        node.vm.provider :virtualbox do |v|
            v.name = "node1"
        end
    end
end