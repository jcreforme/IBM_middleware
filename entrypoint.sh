#!/bin/bash

echo "🔧 Sourcing ACE environment..."
source /opt/ibm/ace-11/server/bin/mqsiprofile 

echo 'export ODBCINI=/etc/odbc.ini' >> ~/.bashrc
echo 'export ODBCSYSINI=/etc' >> ~/.bashrc


echo "📦 Display Groups..."
groups aceuser

echo "📦 DDisplay directories..."
ls -ld /var/mqsi
ls -ld /home/aceuser/ace-server/


# chown -R aceuser:mqbrkrs /var/mqsi
# chmod -R 770 /var/mqsi

echo "🔐 Setting database credentials for JDBC..."
mqsisetdbparms -w /home/aceuser/ace-server -n MySQLDatabaseCredentials -u root -p root || exit 1
echo " Dsiplaying database credentials..."
mqsireportdbparms -w /home/aceuser/ace-server -n MySQLDatabaseCredentials


echo "📦 Starting integration server..."
# exec /opt/ibm/ace-11/server/bin/IntegrationServer --work-dir /opt/ibm/ace-11/ 
exec /opt/ibm/ace-11/server/bin/IntegrationServer --work-dir /home/aceuser/ace-server/

# Add a long-running process to keep the container alive
 tail -f /dev/null