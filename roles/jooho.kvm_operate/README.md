Ansible Role: KVM Operation (Start/Stop/Destroy/Suspend/Teardown/Clone/Attach Storage)
=========

This role help operate VM status or add storage on KVM or clone VM

*Details*
- Start/Stop/Destroy/Suspend/Teardown VM
- Clone VM
- Attach extra storage to VM

Requirements
------------
None

Role Variables
--------------

| Name              | Default value | Requird | Description                                                                         |
| ----------------- | ------------- | ------- | ----------------------------------------------------------------------------------- |
| kvm_install_host  | localhost     | no      | KVM install host                                                                    |
| kvm_storage_pool_name | default       | no      | KVM storage Pool Name                                                               |
| kvm_storage_pool_dir | /var/lib/libvirt/images       | no      | KVM storage Pool Dir                                              |
| virt_operate      | running       | no      | Default image state                                                                 |
| kind              | undefined     | yes     | Set vm for start/stop/suspend/destory/teardown Or set storage for attach extra disk |
| operate           | undefined     | yes     | Set start/stop/suspend/destory/teardown for vm Or attach for storage                |
| src_vm            | undefined     | yes     | Clone operate params. The base vm name                                              |
| dest_vm           | undefined     | yes     | Clone operate params. A new vm name                                                 |
| vm_memory         | undefined     | no      | Clone operate params. A new vm max memory size                                      |
| dest_vm_hostname  | undefined     | no      | Clone operate params. Set hostname if you want to update hostname                   |
| vm_network_br     | default       | no      | Set if cloned vm use differen br                                                    |
| prefix_vm         | undefined     | yes     | start/stop/suspend/destory/clone params. For multiple VMs                           |
| vm_name           | undefined     | yes     | start/stop/suspend/destory/clone. For single VM                                     |
| target_vm         | undefined     | yes     | Storage params. Attach VM name                                                      |
| disk_size         | undefined     | yes     | Storage params. A new disk size (ex, 20G/200M)                                      |


Dependencies
------------

None



Example Playbook - start/stop/suspend/destory/teardown
----------------
~~~
- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-kvm-operate
      vars:
        kind: vm
        prefix_vm: OKD0311
        operate: start

or

- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-kvm-operate
      vars:
        kind: vm
        vm_name: OKD0311
        operate: teardown
~~~



Example Playbook - clone
----------------
~~~
- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-kvm-operate
      vars:
        kind: vm
        operate: clone
        src_vm: CentOS_Base
        dest_vm: OKD0311_master_1
        vm_network_br: okd
        dest_vm_hostname: master1.example.com
~~~

Example Playbook - storage
----------------
~~~
- name: Example Playbook
  hosts: localhost
  tasks:
    - import_role:
        name: ansible-role-kvm-operate
      vars:
         kind: storage
         operate: attach
         target_vm: OKD0311_master_1
         disk_size: 20G

~~~


License
-------

BSD/MIT

Author Information
------------------

This role was created in 2018 by [Jooho Lee](http://github.com/jooho).
