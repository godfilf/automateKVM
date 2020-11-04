Automate KVM Install/Storage/Docker

Questo playbook contiene 3 role differenti :

darkwizard242.docker	# Reperibile su Ansible-Galaxy
jooho.kvm_operate 	# Reperibili su Ansible-Galaxy 
ob.make_kvm		# Creato da Me


lo scopo di questo Playbook, grazie ai ruoli integrati, è quello di :

- Creare un VM su KVM su un Debian hypervisor
- Aggiungere un disco di dimensione variabile alla/e vm esistenti
- installare Docker sulle vm create


prerequisito:

python >= 2.9
libvirtd : As of version libvirt 0.6.0 (Jan 2009), restarting the libvirtd service will not stop virtual guests.




se le var :

vm_name; br_if

non sono settate, il playbook fallisce

