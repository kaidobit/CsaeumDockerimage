#!/bin/bash
#replace placeholders in sql file
sed -i "s/:DATABASE/$DB_NAME/g" db_setup.sql
sed -i "s/:USER/$DB_ADMIN_USER/g" db_setup.sql
sed -i "s/:PASSWORD/$DB_ADMIN_PASSWORD/g" db_setup.sql
sed -i "s/:ROOT_PASSWORD/$DB_ROOT_PASSWORD/g" db_setup.sql

#execute sql file
mysql -uroot < db_setup.sql

#cleanup
#rm db_setup.sql