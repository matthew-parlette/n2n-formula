# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "n2n/supernode/map.jinja" import supernode with context %}

n2n-supernode-image:
  dockerng.image_present:
    - name: {{ supernode.image }}
    - force: True
