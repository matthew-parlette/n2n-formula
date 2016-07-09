# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "n2n/supernode/map.jinja" import supernode with context %}

n2n-supernode-service-definition:
  file.managed:
    - name: {{ supernode.config }}
    - mode: 644
    - user: root
    - group: root
    - contents:
      - setuid supernode
      - start on (started networking)
      - exec supernode -l {{ salt['pillar.get']('n2n:supernode:port', 5644) }}
      - respawn

n2n-supernode-service:
  service.running:
    - name: {{ supernode.service.name }}
    - enable: True
    - reload: True
    - require:
      - file: n2n-supernode-service-definition
    - watch:
      - file: n2n-supernode-service-definition
