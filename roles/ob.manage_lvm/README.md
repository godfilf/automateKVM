Role Name
=========

Questo role ha il solo scopo di creare VG/LV/FS su una VM Centos/RH

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

vg_groups:
  vgname: "{{ lv_groups.vglvname }}"	## Nome necessario per creare un VG nuovo
  disks:				## Indicare i nomi dei PV da Usare
    #- /dev/vdbb
    #- /dev/vdbc

lv_groups:
  lvname: false				## Nome del LV da creare. Se rimane a False, verra' 
					   creato solo il VG.
  size: 5g 				## Necessario per creare il LV. parametri permessi :
					   100%FREE, 10g, 1024 (megabytes by default).
  opts: ''				## Opzioni da passare in fase di lvcreate
  filesystem: swap			## Indicare il FSTYPE (ext/xfs/swap..)
  mntp: []				## Indicare il mount point
  mopts: ''				## Indicare le opzioni di mount
  #vglvname:				## Permette di creare un LV su un VG gia' esistente. 
                                           Se valorizzata Ignorera' tutti i parametri vg_groups.
					   Valorizzare con il nome VG esistente solo nel Playbook. 
  #mount: true				## Se definita con valori bool, dopo aver creato il LV 
					   verrà creato anche il FS.

Example Playbook
----------------

---
- name: Crate Docker
  hosts: vm1
  remote_user: kadmin
  become: yes
  roles:
    - role: ob.manage_lvm
      vg_groups:
        vgname: vg_docker
        disks:
          - /dev/vdb
          - /dev/vdc
      lv_groups:
### vglvname da Inserire solo per creare LV su VG esistente
#        vglvname: vg_docker
### se lvname è definito, crea anche il LV dopo aver definito il VG
        lvname: lv_docker1
        size: 10g
        create: true
        filesystem: ext4
        mount: true
        mntp: /mnt



License
-------

BSD

Author Information
------------------

Michele Costa => costa.tux@gmail.com 
