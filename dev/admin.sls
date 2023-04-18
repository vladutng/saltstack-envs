admin:
  user.present:
    - name: admin
    - password: $y$j9T$nRxhxt16rSWlVTYLw5CAe1$quugZX2F.XvwjozSDYwIcLS4kSXGxPoapDoTfhMYrD0 
    - shell: /bin/bash
    - home: /home/admin
    - createhome: True
    - uid: 1001
    - gid: 1001
#    - groups:
#      - sudo

sudoers_file:
  file.append:
    - name: /etc/sudoers
    - text: 'admin ALL=(ALL:ALL) ALL'
    - require:
      - user: admin
