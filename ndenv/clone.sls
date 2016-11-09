{% from "ndenv/map.jinja" import ndenv with context %}

ndenv-clone:
  pkg.installed:
    - names:
      - git

{%- for name, args in ndenv.users.items() %}
ndenv-clone-{{ name }}:
  cmd.run:
    - unless: test -d ~/.ndenv
    - name: git clone {{ salt["pillar.get"]("ndenv:users:" + name + ":repository", ndenv.repository) }} ~/.ndenv
    - runas: {{ args.user }}
{%- endfor %}
