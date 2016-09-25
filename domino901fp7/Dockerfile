FROM ubuntu:14.04
#FROM vs/ubuntu:14.04

ENV DOM_SCR=resources/initscripts
ENV DOM_CONF=resources/serverconfig

#install nano & wget
RUN apt-get update && \
    apt-get install -y nano && \
    apt-get install -y wget && \
    apt-get clean

RUN useradd -ms /bin/bash notes && \
    usermod -aG notes notes && \
    usermod -d /local/notesdata notes && \
    sed -i '$d' /etc/security/limits.conf && \
    echo 'notes soft nofile 60000' >> /etc/security/limits.conf && \
    echo 'notes hard nofile 80000' >> /etc/security/limits.conf && \
    echo '# End of file' >> /etc/security/limits.conf

COPY ${DOM_CONF}/ /tmp/sw-repo/serverconfig
ENV NUI_NOTESDIR /opt/ibm/domino/

RUN mkdir -p /tmp/sw-repo/ && \
    cd /tmp/sw-repo/ && \
    wget -q http://ubuntu02.local:7777/DOMINO_9.0.1_64_BIT_LIN_XS_EN.tar && \
    tar -xf DOMINO_9.0.1_64_BIT_LIN_XS_EN.tar &&\
    /bin/bash -c "/tmp/sw-repo/linux64/domino/install -silent -options /tmp/sw-repo/serverconfig/domino901_response.dat" && \
    cd /tmp/sw-repo/ && \
    rm /tmp/sw-repo/linux64 -R && \
    wget -q http://ubuntu02.local:7777/domino901FP7_linux64_x86.tar && \
    tar -xf domino901FP7_linux64_x86.tar &&\
    cd /tmp/sw-repo/linux64/domino && \
    /bin/bash -c "./install -script /tmp/sw-repo/serverconfig/domino901_fp7_response.dat" && \
    cd / && \
    rm /tmp/* -R

RUN mkdir -p /etc/sysconfig/
COPY ${DOM_SCR}/rc_domino /etc/init.d/
RUN chmod u+x /etc/init.d/rc_domino && \
    chown root.root /etc/init.d/rc_domino
COPY ${DOM_SCR}/rc_domino_script /opt/ibm/domino/
RUN chmod u+x /opt/ibm/domino/rc_domino_script && \
    chown notes.notes /opt/ibm/domino/rc_domino_script
COPY ${DOM_SCR}/rc_domino_config_notes /etc/sysconfig/
