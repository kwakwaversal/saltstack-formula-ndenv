{% from "ndenv/map.jinja" import ndenv with context %}

include:
  - ndenv.clone

{%- for name, args in ndenv.users.items() %}
  {%- for plugin, gitrepo in ndenv.plugins.items() %}
ndenv-plugins-{{ plugin }}-{{ name }}:
  cmd.run:
    - unless: {{ ndenv.bin }} commands | grep {{ plugin }}
    - name: git clone {{ gitrepo }} ~/.ndenv/plugins/{{ plugin }}
    - runas: {{ args.user }}
  {%- endfor %}
{%- endfor %}
