#!/bin/bash

serverID=/local/notesdata/server.id

if [ ! -f "$serverID" ]; then
    echo "This is a new server. Run remote setup"
    exec su - notes -c "/opt/ibm/domino/bin/server –listen  &"
    
else
    echo "Domino server start"
    exec su - notes -c "/opt/ibm/domino/rc_domino_script start  &"
fi