# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "n2n/supernode/map.jinja" import supernode with context %}

{%- set n2n = salt['pillar.get']('n2n') %}
{%- set ip = salt['pillar.get']('n2n:hosts:' + grains['host']) %}

{%- if ip %}
n2n-supernode-service-definition:
  file.managed:
    - name: {{ supernode.config }}
    - mode: 644
    - user: root
    - group: root
    - contents:
      - start on (started networking)
      - exec edge -d edge0 -a {{ ip }} -b -c {{ n2n.community }} -k {{ n2n.password }} -l {{ n2n.supernode.host }}:{{ n2n.supernode.port }}
      - respawn
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
