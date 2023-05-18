{% set comma = joiner(", ") %}
{% for member in item.members|default([]) %}{{ comma() }}{{ hostvars[member].assigned_to }}{% endfor %}


[Cloud-Virt] Vos identifiants pour le groupe "{{ item.name }}"

Un serveur Consul et un serveur Nomad ont été provisionnés pour vous.
Cette machine est accessible par SSH :

    ssh -J student@{{ bastion_host }} ubuntu@{{ hostvars[item.main_host].ansible_host }}

Clé SSH privée pour accéder à la machine :

    {{ lookup('file', 'instructions/per-host/' + item.main_host + '/id_ecdsa') | indent(4) }}

IP interne utilisée par Consul et Nomad : {{ item.consul_address }}
Console Nomad : <https://nomad-{{ item.name }}.100do.se/>
Console Consul : <https://consul-{{ item.name }}.100do.se/>

Un bucket S3 a été provisionné pour vous :
    Serveur : <https://s3.100do.se/>
    Console : <https://s3-console.100do.se/>
    Access Key ID : {{ item.name }}
    Secret Access Key : {{ lookup("password", "./instructions/per-group/" + item.name + "/minio", chars=["ascii_letters", "digits"]) }}

Un accès à RabbitMQ a été provisionné pour vous :
URL : <amqp://queue.internal.100do.se:5672/{{ item.name }}>
    Console : <https://queue.100do.se/>
    Username : {{ item.name }}
    Password : {{ lookup("password", "./instructions/per-group/" + item.name + "/queue", chars=["ascii_letters", "digits"]) }}

IP flottante: {{ item.floating_address }}

Proxy HTTPS vers l'IP flottante: <https://{{ item.name }}.100do.se/> et <https://nimporte.{{ item.name }}.100do.se/>

Test:

    export CONSUL_HTTP_ADDR=https://consul-{{ item.name }}.100do.se
    export NOMAD_ADDR=https://nomad-{{ item.name }}.100do.se
    consul members
    nomad server members

Liste des proxy HTTPS:

    https://consul-{{ item.name }}.100do.se -> http://{{ item.consul_address|ansible.utils.ipaddr('address') }}:8500
    https://nomad-{{ item.name }}.100do.se -> http://{{ item.consul_address|ansible.utils.ipaddr('address') }}:4646
    https://{{ item.name }}.100do.se -> http://{{ item.floating_address|ansible.utils.ipaddr('address') }}:8081
    https://*.{{ item.name }}.100do.se -> http://{{ item.floating_address|ansible.utils.ipaddr('address') }}:8081
{% for member in (item.members|default([])) + [item.main_host] %}
    https://{{ member }}.100do.se -> http://{{ hostvars[member].vxlan_interface_address|ansible.utils.ipaddr('address') }}:8080
    https://*.{{ member }}.100do.se -> http://{{ hostvars[member].vxlan_interface_address|ansible.utils.ipaddr('address') }}:8080
{% endfor %}
