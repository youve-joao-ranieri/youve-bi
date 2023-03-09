# Youve Pro BI Platform

Youve BI is an open-source platform inspired on [Poli BI](https://github.com/shzlw/poli)

## Tech
### Main tech stack
* Spring Boot 2
* React 16
* SQLite 3

### Prerequisite
* Node.js
* Maven
* SQLite 3 CLI
* JDK 1.8+

### Source code structure
```
|-- Repository
    |-- config
        |-- poli.properties
    |-- db
        |-- schema-sqlite.sql
    |-- src
    |-- web-app
    |-- pom.xml
    |-- build.sh
    |-- build.bat
    |...
```

* Src folder contains the java source code.
* Web-app folder contains the react code.
* Schema-sqlite.sql contains the database schema for SQLite 3. The poli.db file in the release is loaded from this schema.
* The build scripts build the code in web-app first, copy the generated files to src ~/static folder and finally run maven to build the java project.


## Installation
### How to run it locally:

##### Using Docker (preferred):

````
docker build -t poli-youve .
docker run -d -p 6688:6688 poli-youve
````

##### Using Java:
1. Run the build script.

```
# Windows
build.bat

# Linux and Mac
./build.sh
```

2. The java executable poli-x.y.z.jar is generated under the target folder. Run this to start the server.

```
java -jar target\poli-x.y.z.jar
```
```sh
127.0.0.1:6688
```
