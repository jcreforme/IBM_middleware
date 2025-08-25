ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
ALTER USER 'aceuser'@'%' IDENTIFIED WITH mysql_native_password BY 'acepass';
FLUSH PRIVILEGES;
