FROM vs/domino:9.0.1

ENV DOM_CONF=resources/serverconfig

COPY ${DOM_CONF}/ /tmp/sw-repo/serverconfig

ENV NUI_NOTESDIR /opt/ibm/domino/

RUN mkdir -p /tmp/sw-repo/ && \
    cd /tmp/sw-repo/ && \
    wget -q http://ubuntu02.local:7777/domino901FP7_linux64_x86.tar && \
    tar -xf domino901FP7_linux64_x86.tar &&\
    cd /tmp/sw-repo/linux64/domino && \
    /bin/bash -c "./install -script /tmp/sw-repo/serverconfig/domino901_fp7_response.dat" && \
    cd / && \
    rm /tmp/* -R
