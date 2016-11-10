{% from "ndenv/map.jinja" import ndenv with context %}

include:
  - ndenv.install

{%- for name, args in ndenv.users.items() %}
  {%- set version = salt["pillar.get"]("ndenv:users:" + name + ":node:global", ndenv.node.global) %}
  {%- if version %}
ndenv-global-{{ name }}:
  cmd.run:
    - onlyif: {{ ndenv.bin }} versions | grep {{ version }}
    - name: {{ ndenv.bin }} global {{ version }}
    - runas: {{ args.user }}
    - require:
      - cmd: ndenv-install-{{ version }}-{{ name }}
  {%- endif %}
{%- endfor %}
