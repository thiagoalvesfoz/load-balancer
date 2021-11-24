cluster = {
  "master" => { 
    :box_image => "generic/ubuntu1804", 
    :ip => "192.168.10.10", 
    :mem => 1024,
    :nginx => "./nginx-config",
    :script => "./node1/script.sh",
  },
  "node2" => { 
    :box_image => "generic/ubuntu1804", 
    :ip => "192.168.10.20", 
    :mem => 1024,
    :script => "./node2/script.sh",
  },
}

Vagrant.configure("2") do |config|
  
    cluster.each do |hostname, info| 

        config.vm.define hostname do |cfg|

            cfg.vm.box = info[:box_image]
            cfg.vm.box_check_update = false
            cfg.vm.network :private_network, ip: info[:ip]

            cfg.vm.provider :virtualbox do |vb, override|
                vb.name = hostname
                vb.memory = info[:mem] if info[:mem]
                vb.cpus = info[:cpus] if info[:cpus]
            end 

            # install nginx
            if info[:nginx]
                cfg.vm.provision :file,  source: info[:nginx], destination: "/tmp/nginx"
                cfg.vm.provision :shell, inline: <<-SHELL
                    chmod +x /tmp/nginx/install.sh
                    cd /tmp/nginx/ && ./install.sh
                SHELL
            end      
        
            # execute script
            cfg.vm.provision :shell, path: info[:script] if info[:script]
                    
        end #end config
    end #end cluster each
  
end #end vagrant