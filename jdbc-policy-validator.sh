#!/bin/bash

# === CONFIG ===
SERVER_NAME="TEST_SERVER"
WORKSPACE="$HOME/IBM/ACET12/workspace/$SERVER_NAME"
POLICY_NAME="MySQLPolicy"
DRIVER_PATH="/Applications/IBM App Connect Enterprise.app/Contents/mqsi/server/lib/mysql-connector-j-9.4.0.jar"
LOG_FILE="$WORKSPACE/log/integration_server.${SERVER_NAME}.events.txt"

# === CHECKS ===
echo "🔍 Checking JDBC policy XML..."
grep "<Policy .*type=\"JDBCProviders\" .*name=\"$POLICY_NAME\".*>" "$WORKSPACE/policy/JDBCProviders/$POLICY_NAME.policyxml" || echo "❌ Policy XML not found or misnamed."

echo "🔍 Checking driver JAR..."
[ -f "$DRIVER_PATH" ] && echo "✅ Driver JAR found." || echo "❌ Driver JAR missing."

echo "🔍 Checking policy load in logs..."
grep "BIP9332I.*$POLICY_NAME" "$LOG_FILE" && echo "✅ JDBC policy loaded." || echo "❌ JDBC policy not loaded."

echo "🔍 Checking for fallback to ODBC..."
grep "Unable to search for empty name" "$LOG_FILE" && echo "⚠️ Flow is defaulting to ODBC. JDBC policy not resolved." || echo "✅ No fallback detected."

echo "🔍 Checking for SQL execution errors..."
grep "BIP2488E" "$LOG_FILE" && echo "⚠️ SQL execution failed." || echo "✅ No SQL errors detected."
