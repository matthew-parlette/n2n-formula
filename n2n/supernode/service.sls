# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "n2n/supernode/map.jinja" import supernode with context %}

n2n-supernode-service-definition:
  file.managed:
    - mode: 644
    - user: root
    - group: root
{%- if grains['init'] == 'upstart' %}
    - name: {{ supernode.service.file.upstart }}
    - contents:
      - setuid supernode
      - start on (started networking)
      - exec supernode -l {{ salt['pillar.get']('n2n:supernode:port', 5644) }}
      - respawn
{%- elif grains['init'] == 'systemd' %}
    - name: {{ supernode.service.file.systemd }}
    - contents:
      - "[Unit]"
      - Description=n2n Supernode
      - "[Service]"
      - ExecStart=/usr/bin/supernode -l {{ salt['pillar.get']('n2n:supernode:port', 5644) }}
      - "[Install]"
      - WantedBy=multi-user.target
{%- endif %}

n2n-supernode-service:
  service.running:
    - name: {{ supernode.service.name }}
    - enable: True
    - reload: True
    - require:
      - file: n2n-supernode-service-definition
    - watch:
      - file: n2n-supernode-service-definition
