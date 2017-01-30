# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "n2n/supernode/map.jinja" import supernode with context %}

include:
  - n2n.supernode.install

n2n-supernode-container:
  dockerng.running:
    - name: {{ supernode.name }}
    - image: {{ supernode.image }}
    - port_bindings:
      - {{ supernode.port }}:7654/udp
    - require:
      - dockerng: n2n-supernode-image
