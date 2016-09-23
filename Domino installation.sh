######################################################################
#Host. Host system
cd /home/vs/software/IBM_Domino_901_7/
tar -xvf domino901FP5_aix64.tar
mv linux64 domino_901
tar -xvf \domino901FP7_linux64_x86.tar
mv linux64 domino_901_fp7

######################################################################
#Host. Run a container
#Ubuntu
docker run -it -p 8585:8585 -p 1352:1352 -p 8888:80 --name domino01 -v /home/vs/software:/software ubuntu:14.04
#CentOS 7
#docker run -it --name domino02 -v /home/vs/software:/software centos:7

######################################################################
#Container. Pre-configuration
DOMINODIR='/software/IBM_Domino_901_7'
useradd -ms /bin/bash notes
usermod -aG notes notes
usermod -d /local/notesdata notes
sed -i '$d' /etc/security/limits.conf
echo 'notes soft nofile 60000' >> /etc/security/limits.conf
echo 'notes hard nofile 80000' >> /etc/security/limits.conf
echo '# End of file' >> /etc/security/limits.conf

######################################################################
#Container. Ubuntu pre-configuration
apt-get update
apt-get install -y nano

######################################################################
#Container. CentOS 7 pre-configuration
#yum update -y
#yum install -y perl
#yum install -y which

######################################################################
#Container. Manual installation
cd $DOMINODIR/domino_901/domino
#./install
./install -silent -options $DOMINODIR/serverconfig/domino901_response.dat 

######################################################################
#Container. Environment configuration
NUI_NOTESDIR=/opt/ibm/domino
export NUI_NOTESDIR

######################################################################
#Container. Fixpack installation (manual)
cd $DOMINODIR/domino_901_fp7/domino
#./install
./install -script $DOMINODIR/serverconfig/domino901_fp7_response.dat

######################################################################
#Container. Copy scripts
mkdir -p /etc/sysconfig/
cp $DOMINODIR/initscripts/rc_domino /etc/init.d/
chmod u+x /etc/init.d/rc_domino
chown root.root /etc/init.d/rc_domino
cp $DOMINODIR/initscripts/rc_domino_script /opt/ibm/domino/
chmod u+x /opt/ibm/domino/rc_domino_script
chown notes.notes /opt/ibm/domino/rc_domino_script
cp $DOMINODIR/initscripts/rc_domino_config_notes /etc/sysconfig/

######################################################################
#Container. notes user configuration
touch /local/notesdata/.profile || exit
echo "PATH=$PATH:/local/notesdata:/opt/ibm/domino/bin" >> /local/notesdata/.profile
echo "export PATH" >> /local/notesdata/.profile


######################################################################
#Container. Start domino server
su - notes -c "/opt/ibm/domino/bin/server –listen"
su - notes -c "/opt/ibm/domino/rc_domino_script monitor"
#su notes -c "cd /local/notesdata && /opt/ibm/domino/bin/server –listen"

