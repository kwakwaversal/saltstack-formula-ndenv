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
{%- set version = salt["pillar.get"]("ndenv:users:" + name + ":node:version", ndenv.node.version) %}
ndenv-install-{{ name }}:
  cmd.run:
    - unless: {{ ndenv.bin }} versions | grep {{ version }}
    - name: {{ ndenv.bin }} install {{ version }}
    - runas: {{ args.user }}
{%- endfor %}
