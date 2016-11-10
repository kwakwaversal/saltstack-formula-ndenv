{% from "ndenv/map.jinja" import ndenv with context %}

include:
  - ndenv.install

{%- for name, args in ndenv.users.items() %}
  {%- set npm_install_options = salt["pillar.get"]("ndenv:users:" + name + ":node:packages_install_options", ndenv.node.packages_install_options)  %}
  {%- set versions = salt["pillar.get"]("ndenv:users:" + name + ":node:versions", ndenv.node.versions) %}
  {%- for version in versions %}
    {%- set pkgs = salt["pillar.get"]("ndenv:users:" + name + ":node:packages", ndenv.node.packages) %}
    {%- for pkg in pkgs %}
ndenv-global-pkgs-{{ version }}-{{ pkg }}-{{ name }}:
  cmd.run:
    - unless: {{ ndenv.bin }} exec npm list -g | grep " {{ pkg }}@"
    - name: |
        {{ ndenv.bin }} exec npm install -g {{ npm_install_options }} {{ pkg }}
        {{ ndenv.bin }} rehash
    - runas: {{ args.user }}
    - env:
      - NDENV_VERSION: {{ version }}
    {%- endfor %}
  {%- endfor %}
{%- endfor %}
