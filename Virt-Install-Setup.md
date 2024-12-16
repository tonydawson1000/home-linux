[Chapter 1. Creating and managing activation keys](https://docs.redhat.com/en/documentation/subscription_central/1-latest/html/getting_started_with_activation_keys_on_the_hybrid_cloud_console/assembly-creating-managing-activation-keys#proc-enabling-additional-repos_)

[Chapter 3. Registering a RHEL system with command line tools](https://docs.redhat.com/en/documentation/subscription_central/1-latest/html/getting_started_with_rhel_system_registration/basic-reg-rhel-cli)

[Chapter 5. Creating system images by using RHEL image builder web console interface](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/composing_a_customized_rhel_system_image/creating-system-images-with-composer-web-console-interface_composing-a-customized-rhel-system-image#creating-system-images-with-composer-web-console-interface_composing-a-customized-rhel-system-image)


[Resize a QCOW2 and Filesystem](https://techieandtravel.com/resize-a-qcow2-and-filesystem/)
[How to resize a qcow2 disk image on Linux](https://gist.github.com/joseluisq/2fcf26ff1b9c59fe998b4fbfcc388342)



Pre Req
- KVM Host
- Admin User
- All the KVM/Virsh packages installed

1) Use ‘sudo virsh-install’ to create a new KVM VM
	RHEL 8.10 (rhel810-bastion.local)
	RHEL 9.4 (rhel94-bastion.local)

2) Activate (Subscribe) 
	rhc connect —activation-key=rhel-server-td-poc —organization= 17204763







sudo virt-install \
 --name=rhel94-bastion \
 --vcpus=2 \
 --memory=2048 \
 --disk pool=Base_Virtual_Machines,size=20,bus=virtio \
 --location /home/ISOs/rhel-9.4-x86_64-dvd.iso \
 --os-variant=rhel9.4 \
 --network network='default',model=virtio \
 --extra-args='console=ttyS0,115200n8 serial' \
 --nographics



sudo virt-install \
 --name=rhel810-bastion \
 --vcpus=2 \
 --memory=2048 \
 --disk pool=Base_Virtual_Machines,size=20,bus=virtio \
 --location /home/ISOs/rhel-8.10-x86_64-dvd.iso \
 --os-variant=rhel8.10 \
 --network network='default',model=virtio \
 --extra-args='console=ttyS0,115200n8 serial' \
 --nographics




