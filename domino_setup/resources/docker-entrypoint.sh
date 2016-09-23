#!/bin/bash

serverID=/local/notesdata/server.id

if [ ! -f "$serverID" ]; then
    #echo "This is a new server. Please run the command:"
    #echo "su - notes -c \"cd /local/notesdata; /opt/ibm/domino/bin/server –listen \""
    /opt/ibm/domino/bin/server -listen
else
    #echo "Domino server start"
    #su - notes -c "/opt/ibm/domino/rc_domino_script start "
    /opt/ibm/domino/rc_domino_script start
    /bin/bash
fi
