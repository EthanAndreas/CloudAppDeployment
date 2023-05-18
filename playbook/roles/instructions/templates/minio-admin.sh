#!/bin/sh

{% for instance in instances %}
mc mb cloudvirt/{{ instance }}
mc admin user add cloudvirt {{ instance }} {{ lookup("file", "./instructions/per-group/" + instance + "/minio") }}
mc admin policy attach cloudvirt rwownbucket --user={{ instance }}
{% endfor %}
