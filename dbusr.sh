#!bin/bash

if [[ $(mongo localhost/admin --eval 'db.getSiblingDB("dashboard").getUsers()'| grep '\[ \]' | wc -c) -ne 0 ]]; then
  echo "adding database user"
  mongo localhost/admin --eval 'db.getSiblingDB("dashboard").createUser({user: "db", pwd: "dbpass", roles: [{role: "readWrite", db: "dashboard"}]})'
else
  echo "User already added"
fi
