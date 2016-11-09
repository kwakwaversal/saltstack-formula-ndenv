{% from "ndenv/map.jinja" import ndenv with context %}

include:
  - ndenv.install
  - ndenv.global

{%- for name, args in ndenv.users.items() %}
  {%- set pkgs = salt["pillar.get"]("ndenv:users:" + name + ":node:packages", ndenv.node.packages) %}
  {%- for pkg in pkgs %}
ndenv-global-pkgs-{{ pkg }}-{{ name }}:
  cmd.run:
    - unless: {{ ndenv.bin }} which gulp
    - name: |
        {{ ndenv.bin }} exec npm install {{ pkg }} -g
        {{ ndenv.bin }} rehash
    - runas: {{ args.user }}
  {%- endfor %}
{%- endfor %}
