{{ hostvars[item].assigned_to }}

[Cloud-Virt] Vos identifiants pour la machine virtuelle "{{ item }}"

La machine virtuelle {{ item }} vous a été affectée pour le projet de Cloud et Virtualisation.

Votre clé SSH privée :

    {{ lookup('file', 'instructions/per-host/' + item + '/id_ecdsa') | indent(4) }}

Ajoutez cette clé à votre agent SSH via la commande ssh-add :

    ssh-add ./id_ecdsa

La machine virtuelle n'est accessible que depuis le réseau de l'Université.
Connectez-vous à votre machine virtuelle via la machine bastion :

    ssh -J student@{{ bastion_host }} ubuntu@{{ hostvars[item].ansible_host }}

Pour simplifier la connexion par SSH, ajoutez cette section à votre fichier ~/.ssh/config

    Host bastion-cloud
      Hostname {{ bastion_host }}
      User student

    Host {{ item }}
      Hostname {{ hostvars[item].ansible_host }}
      User ubuntu
      ProxyJump bastion-cloud

Vous pourrez ensuite vous connecter à la machine via :

    ssh {{ item }}

IP de l'interface VXLAN : {{ hostvars[item].vxlan_interface_address }}
IP interne : {{ hostvars[item].ansible_host }}
Nom d'hôte interne : {{ item }}.internal.100do.se

Les adresses suivantes proxy le traffic vers votre machine virtuelle sur le port 8080 ({{ hostvars[item].vxlan_interface_address | ansible.utils.ipaddr('address') }}:8080) :

 - https://{{ item }}.100do.se
 - https://*.{{ item }}.100do.se
