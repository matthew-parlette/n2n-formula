{%- for host in salt['pillar.get']('n2n:hosts', {}).keys() %}
n2n-host-{{ host }}:
  host.present:
    - ip: {{ salt['pillar.get']('n2n:hosts:' + host) }}
    - name: {{ host }}.n2n
{%- endfor %}
