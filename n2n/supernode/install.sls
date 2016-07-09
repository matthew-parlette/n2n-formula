# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "n2n/supernode/map.jinja" import supernode with context %}

n2n-supernode-pkg:
  pkg.installed:
    - name: {{ supernode.pkg }}
