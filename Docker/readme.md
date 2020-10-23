# Variable 

#### DB_HOST : The host in which is run the database 

#### DB_NAME : The database name to which wordpress will be connecting.

#### DB_USER : The Database user who will be connecting to the correspoding database.

#### DB_PASSWORD : Stores the password of database user who will be connecting to fetch the data from appropirate database. 


### Example values
- DB_NAME=wpdb
- DB_USER=wpuser
- DB_PASSWORD=wppass@1234
- DB_HOST=172.17.0.2

### Example Docker Run Command
```sh
$ docker run -d --name my_wp -p 8080:80 -e DB_NAME=wpdb -e DB_USER=wpuser -e DB_PASSWORD=wppass@1234 -e DB_HOST=172.17.0.2  my_wordpress:v1
```
