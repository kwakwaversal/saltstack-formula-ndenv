{% from "ndenv/map.jinja" import ndenv with context %}

{%- for name, args in ndenv.users.items() %}
ndenv-profile-exists-{{ name }}:
  file.managed:
    {%- if args.user == 'root' %}
    - name: /root/{{ salt["pillar.get"]("ndenv:users:" + name + ":profile", ndenv.profile) }}
    {%- else %}
    - name: /home/{{ args.user }}/{{ salt["pillar.get"]("ndenv:users:" + name + ":profile", ndenv.profile) }}
    {%- endif %}
    - user: {{ args.user }}
    - group: {{ args.user }}
    - mode: 644

ndenv-profile-append-{{ name }}:
  file.append:
    {%- if args.user == 'root' %}
    - name: /root/{{ salt["pillar.get"]("ndenv:users:" + name + ":profile", ndenv.profile) }}
    {%- else %}
    - name: /home/{{ args.user }}/{{ salt["pillar.get"]("ndenv:users:" + name + ":profile", ndenv.profile) }}
    {%- endif %}
    - source: salt://ndenv/files/.bash_profile
{%- endfor %}
