
# Installation

## Docker

1. Create a docker image from the root of the repository:
````
docker build -t poli-youve .
````

2. Create and run the container built on the previous step:
````
docker run -d -p 6688:6688 poli-youve
````

3. Add JDBC drivers.

    > There are no JDBC drivers included except the JDBC driver for SQLite. You need to download the JDBC jar files based on the database you'd like to connect to and copy those JDBC jar files to MY_CONTAINER_ID:/app/jdbc-drivers

    For example,

    ```sh
    docker cp postgresql-42.2.5.jar poli-youve:/app/jdbc-drivers
    ```

4. Restart the container
    ```sh
    docker restart poli-youve
    ```

5. Open http://localhost:6688/poli/login in chrome. Welcome to Poli!

