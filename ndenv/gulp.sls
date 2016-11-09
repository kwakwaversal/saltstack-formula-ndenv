{% from "ndenv/map.jinja" import map with context %}

ndenv-gulp:
  cmd.run:
    - unless: {{ map.ndenv }} which gulp
    - name: |
        {{ map.ndenv }} exec npm install gulp -g
        {{ map.ndenv }} rehash
    - user: {{ map.user }}
