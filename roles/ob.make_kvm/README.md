Role Name
=========

Questo Role è stato creato utilizzando un Vecchio PlayBook personale.
Ha il solo scopo di creare un VM su un sistema Linux con KVM già deployato.
Funziona solo ed esclusivamente passando al role una file immagine QCOW già disponibile. NON crea file qcow da 0 e NON assegna dischi alla creazione della VM.

Nelle "Variabili", i parametri contenuti nella sezione "lib_vm" sono tutti OBBLIGATORI, mentre i parametri contenuti nelle sezioni "lib_os" e "lib_net", sono opzionali

Requirements
------------

- Per i miei test ho scaricato una CentOS-8 - CentOS Cloud images :

        CentOS-8-ec2-8.1.1911-20200113.3.x86_64.qcow2

  al seguente link :

        https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-ec2-8.1.1911-20200113.3.x86_64.qcow2

  al termine del download posizionare la iso nel path :

        ob.make_kvm/templates/qcowimg/

- Installare la collections dell community di libvirt :

        ansible-galaxy collection install community.libvirt

- Necessario installare sul server e sul client :

        python >= 2.6 
        python-libvirt
        python-lxml



Role Variables
--------------
filetarget: "hosts.target"              ## Nome del file hosts dell'inventory di ansible. Io uso un file custom "hosts.target"
hoststarget: "{{ pbpath }}/{{ filetarget }}"    ## Variabile completa del file inventory
filehosts: "/etc/hosts"                 ## Parametro di Default. Questo role, inserisce l'ip della VM appena creata nel file hosts, in modo da poterlo richiamare solo con il suo nome host dal file inventory

lib_vm:                                 
  #vm_name:                             ## NECESSARIO : Nome della VM. Questo parametro è obbligatorio per poter usare il  role
  vm_mem: '512'                         ## Ram da allocare alla VM. Sono Settati dei valori di default per test
  #cp_set:                              ## Utilizzato per il live grow delle cpu. parametro commentanto in tasks/create_vm.yml
  vm_vcpu: '1'                          ## vCPU da allocare alla VM.Sono Settati dei valori di default per test
  vm_os: 'generic'                      ## Indica il tipo di OS che verrà installato. Se non lo si conosce si consiglia di lasciare il parametro di default
  vm_root_pwd: 'p1pp0123'               ## NECESSARIO : Definizione della ROOT pwd con la quale fare login. Settato un valore di test
  qcow: "null"                          ## NECESSARIO : Settaggio : "present" - utilizzato per copiare il qcow. Il deploy della VM funziona solo cn QCOW dià disponibili
  path_img: "null"                      ## NECESSARIO : Path di origine dell'immagine QCOW
  qcow_name: "null"                     ## NECESSARIO : Nome del file QCOW, locato nella var "path_img"
  vm_directory: "/Work/StoreVM"         ## NECESSARIO : Path di destinazione del QCOW della VM che sta per essere creata
  template_size: "50G"                  ## NECESSARIO : Capacità dell'immagine 
 
lib_os:
  vm_hostname: "null"                   ## Hostname da assegnare all'OS se viene definita nel playbook
  #vm_user:                             ## Crea un utente se viene definita la variabile nel playbook. Necessario per effettuare il login in ssh
  
lib_net:
  #br_net: "kvm-NAT"                    ## Necessario solo se si vuole far creare al role un rete kvm da 0. Indica il nome della rete in KVM. NON crea schede in bridge. Solo NAT.
  br_if: "null"                         ## Necessario solo se si decide di creare la NET con il role. Questo è il nome della scheda sull'hypervisor KVM
  br_net_gw: "192.168.123.1"            ## Indica l'ip che avrà la NET creata su KVM. Sarà il def gw della VM
  br_net_mask: 255.255.255.0            ## Indica la netmask da assegnare alla NET creata su KVM.
  ip_address: "192.168.123.3"           ## E' l'IP da assegnare alla scheda della VM creata 
  netmask: "255.255.255.0"              ## E' la netmask da assegnare alla scheda della VM creata
  gateway: "{{ br_net_gw }}"            ## E' il def gw della VM creata. Cambiabile in base alle proprie configurazione di rete
  dns1: "8.8.8.8"                       ## E' il DNS della VM creata. Modificabile in base alle proprie conf di rete


  
Example Playbook
----------------

---
- name: Create VMs
  hosts: hypervisor
  remote_user: overburn
  roles:
    - role: ob.make_kvm
      pbpath: '/Work/MyPrj/hosts'
      filetarget: "hosts.target"

      lib_vm:
        vm_name: 'vm1'
        vm_mem: '1024'
        vm_vcpu: '1'
        vm_os: 'generic'
        vm_root_pwd: 'p1pp0123'
        qcow: 'present'
        path_img: '../templates/qcowimg'
        qcow_name: "CentOS-8-ec2-8.1.1911-20200113.3.x86_64.qcow2"
        vm_directory: '/Work/StoreVM'

      lib_os:
        vm_hostname: "centos1"
        vm_user: 'kadmin'
	

      lib_net:
        br_if: "knat0"
        br_net: kvm-NAT
        br_net_gw: 192.168.124.1
        br_net_mask: 255.255.255.0
        ip_address: "192.168.123.4"
        netmask: "255.255.255.0"
        gateway: "192.168.123.1"


License
-------

BSD

Author Information
------------------

Michele Costa => costa.tux@gmail.com 
