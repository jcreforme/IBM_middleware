#!/bin/bash

echo "🔧 Sourcing ACE environment..."
source /opt/ibm/ace-11/server/bin/mqsiprofile 

echo "source /opt/ibm/ace-11/server/bin/mqsiprofile" >> ~/.bashrc

# groups aceuser


# chown -R aceuser:mqbrkrs /var/mqsi
# chmod -R 770 /var/mqsi

# echo "🔐 Setting database credentials for JDBC..."
# mqsisetdbparms -w /home/aceuser/ace-server \
#   -n MySQLDatabaseCredentials \
#   -u root \
#   -p root || exit 1

echo "📦 Starting integration server..."
# exec /opt/ibm/ace-11/server/bin/IntegrationServer --work-dir /opt/ibm/ace-11/ 
exec /opt/ibm/ace-11/server/bin/IntegrationServer --work-dir /home/aceuser/ace-server/

# Add a long-running process to keep the container alive
# tail -f /dev/null