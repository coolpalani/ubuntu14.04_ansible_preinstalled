Ubuntu 14.04 Docker Image, preinstalled Python and Ansible 2.4.2

Steps to build a new Docker Image as locally

root@coolpalani:/#docker build --rm=true -t ubuntu1404-ansible .

Check the newly build image

root@coolpalani:/#docker images

Execute this image 

root@coolpalani:/#docker run -it ubuntu1404-ansible /bin/bash 

Access the container in shell

root@aeccad63d9aa:/#ansible --version 
ansible 2.4.2.0
  config file = /etc/ansible/ansible.cfg
  configured module search path = [u'/root/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python2.7/dist-packages/ansible
  executable location = /usr/bin/ansible
  python version = 2.7.6 (default, Nov 23 2017, 15:49:48) [GCC 4.8.4]
