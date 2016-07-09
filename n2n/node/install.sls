# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "n2n/node/map.jinja" import node with context %}

n2n-node-pkg:
  pkg.installed:
    - name: {{ node.pkg }}
