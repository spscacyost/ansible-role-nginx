FROM ansible/ubuntu14.04-ansible:devel
MAINTAINER acyost@spscommerce.com
##MOO
ADD ./tests /tmp/playbook
ADD . /tmp/playbook/roles/ansible-role-nginx
WORKDIR /tmp/playbook
ENV ANSIBLE_FORCE_COLOR=true
ENV PYTHONUNBUFFERED=1

## run tests

RUN ansible-playbook -i "[test] localhost," -c local tests.yml &&\
    ansible-playbook -i "[test] localhost," -c local tests.yml 2>/dev/null | grep -q 'changed=0.*failed=0' &&\
    (echo 'Idempotence test(autostart): \033[0;32mpass\033[0m' && exit 0) ||\
    (echo 'Idempotence test(autostart): \033[0;31mfail\033[0m' && exit 1) 

CMD /bin/bash
