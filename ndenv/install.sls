{% from "ndenv/map.jinja" import ndenv with context %}

include:
  - ndenv.clone
  - ndenv.plugins
  - ndenv.profile

ndenv-install:
  pkg.installed:
    - names:
      - curl

{%- for name, args in ndenv.users.items() %}
  {%- set versions = salt["pillar.get"]("ndenv:users:" + name + ":node:versions", ndenv.node.versions) %}
  {%- for version in versions %}
ndenv-install-{{ version }}-{{ name }}:
  cmd.run:
    - unless: {{ ndenv.bin }} versions | grep {{ version }}
    - name: {{ ndenv.bin }} install {{ version }}
    - runas: {{ args.user }}
  {%- endfor %}
{%- endfor %}
