## PostgreSQL Installation


### Definition

* **SQL -** Structured Query Language enables to manage data held in a relational database
* **Relational database -** is a system of tables that have some level of relationship based on a common index
* **PostgreSQL -** is a free and an open-source relational database management system (RDBMS) emphasizing extensibility and SQL compliance. It was originally named POSTGRES, referring to its origins as a successor to the Ingres database developed at the University of California, Berkeley.<sup>2</sup>

### Installation

PostgreSQL supprts most of the common OS such as Windows, macOS, Linux, etc.

To download go to Postgres project [website](https://www.postgresql.org/) and navigate to the **Downlaod** tab and select your OS, which will naviage it to the OS download page, and follow the instraction:

 [<img src="images/download_page.png" width="80%" align="center"/></a>](https://www.postgresql.org/download/)


On mac I highly recommand to install PostgreSQL through the [Postgres.app](https://postgresapp.com/):

 [<img src="images/postgres_app.png" width="80%" align="center"/></a>](https://postgresapp.com/)


When opening the app, you should have a default server set to port 5432 (make sure that this port is available):

<img src="images/app_unactive.png" width="60%" align="center"/></a>

To launch the server click on the `start` button:

<img src="images/app_active.png" width="60%" align="center"/></a>

By default, the server will create three databases - `postgres`, `YOUR_USER_NAME`, and `template1`. You can add additional server (or remove) by clicking the `+` or `-` symbols on the left botton.


To run Postgres from the terminal you will have to set define the path of the app on your `zshrc` file (on mac) by adding the following line:

``` zsh
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/14/bin/
```

Where `/Applications/Postgres.app/Contents/Versions/14/bin/` is the local path on my machine.

Alternativly, you can set the alias from the terminal by running the following"


``` zsh
echo "export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/14/bin/" >> ${ZDOTDIR:-$HOME}/.zshrc
```


#### Clear port

If the port you set for the Postgres server is in use you should expect to get the following message when trying to start the server:

<img src="images/port_in_used.png" width="60%" align="center"/></a>

This mean that the port is either used by other Postgres server or other application. To check what ports in use and by which applications you can use the `lsof` function on the terimnal:

``` zsh
sudo lsof -i :5432                                                                                           COMMAND  PID     USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
postgres 124 postgres    7u  IPv6 0xc250a5ea155736fb      0t0  TCP *:postgresql (LISTEN)
postgres 124 postgres    8u  IPv4 0xc250a5ea164aa3b3      0t0  TCP *:postgresql (LISTEN)
```

Where the `i` argument enables to search by port number, in the example above by `5432`. As can see from the output, the port is used by other Posrgres server. You can clear the port by using the `pkill` command:

``` zsh
sudo pkill -u postgres
```

Where the `u` arugment enbales to define the port you want to clear by the USER field, in this case `postgres`.

**Note:** Before you are clearing the port, make sure you do not need the applications on that port. 



### SSH the database

To open the database on the terminal you can either use the Postgres App or directly on the command line.

#### SSH with the Postgres App
 
The Postgres App enables you to SSH directly to the server via the terminal. On Mac, by default, the app will use the built-in terminal emlator. If you want to change terimnal default setting go to `Preferences...` and select the terminal emlator you want to use:

<img src="images/set_terminal.png" width="60%" align="center"/></a>

Once the Postgres server is up and working, clicking on any of the databases on the server will open the terminal and SSH into the server:



### SSH from the terminal

Alternatively, you can SSH directly from the terminal with the `psql` command:

<img src="images/ssh_terminal.png" width="60%" align="center"/></a>

By default, the `psql` commend will SSH to the database with the user name, in this case `ramikrispin`. You can use the `dbname` argument to specify the database name:

``` zsh
psql template1                                                 
psql (14.1)
Type "help" for help.

template1=#
```


More options available on the `psql` command [documentation](https://www.postgresql.org/docs/9.2/app-psql.html), or on the command line with `psql --help`.


### Help and Documentations

Like most common programming systems or lagnuages, Postgres has both help functionality and documentation. 

You can access the core documentation on Postgres website under the [Documentation](https://www.postgresql.org/docs/) tab, where you can select Postgres manuals by version. The manuales available, in addition to English, in other languages such as Chinese, French, Japanese, and Russian.

The `psql` is the command line function that enable you to SSH into the Postgres server. Like most common command lines, you can use the `help` argument to review the function arguments:

``` zsh
psql --help
```

Once connected to the Postgres command line interface, you use the `help` command to review the core main help functions:

``` zsh
ramikrispin=# help
You are using psql, the command-line interface to PostgreSQL.
Type:  \copyright for distribution terms
       \h for help with SQL commands
       \? for help with psql commands
       \g or terminate with semicolon to execute query
       \q to quit

```


### Working with Database

As we saw before, by default, when using the `psql` function will login to the default database which would be under the user name, in my case `ramikrispin`. You can define aditional arguments such as the server name, ports or any other exsiting database. For example, let's re-log to `template1` database using the `psql` function:

```zsh
psql -h localhost -p 5432 -U ramikrispin template1                                                     
psql (14.1)
Type "help" for help.
```

Where, `h` define the host name, `p` the server port, and `U` the user name.

Typically, the first thing you would like to check is the list of active database. The `\l` function returns a table with a list of active databases and some additional information such as database owner, encoding, access privileges:

```zsh
ramikrispin-# \l
                                    List of databases
    Name     |    Owner    | Encoding |   Collate   |    Ctype    |   Access privileges
-------------+-------------+----------+-------------+-------------+-----------------------
 postgres    | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 ramikrispin | ramikrispin | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0   | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
             |             |          |             |             | postgres=CTc/postgres
 template1   | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
             |             |          |             |             | postgres=CTc/postgres
(4 rows)

```

You can use the `\c` function to change to another database, for example, let's login to `postgres` database:

```
template1=# \c postgres
You are now connected to database "postgres" as user "ramikrispin".
postgres=#
```


The `CREATE DATABASE`, as its name implies, enable you to create a new database:

```
postgres=# CREATE DATABASE db1;
CREATE DATABASE
postgres=# \l
                                    List of databases
    Name     |    Owner    | Encoding |   Collate   |    Ctype    |   Access privileges
-------------+-------------+----------+-------------+-------------+-----------------------
 db1         | ramikrispin | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 postgres    | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 ramikrispin | ramikrispin | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0   | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
             |             |          |             |             | postgres=CTc/postgres
 template1   | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
             |             |          |             |             | postgres=CTc/postgres
(5 rows)
```
**Note:** All the commends on inter ended up with `;`


Similarly, you can use the `DROP DATABASE` to delete a database:

```
ramikrispin=# DROP DATABASE db1;
DROP DATABASE
ramikrispin=# \l
                                    List of databases
    Name     |    Owner    | Encoding |   Collate   |    Ctype    |   Access privileges
-------------+-------------+----------+-------------+-------------+-----------------------
 postgres    | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 ramikrispin | ramikrispin | UTF8     | en_US.UTF-8 | en_US.UTF-8 |
 template0   | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
             |             |          |             |             | postgres=CTc/postgres
 template1   | postgres    | UTF8     | en_US.UTF-8 | en_US.UTF-8 | =c/postgres          +
             |             |          |             |             | postgres=CTc/postgres
(4 rows)
```


### Define Columns

After you logged in an existing database or created a new one, the next step is to create a table with the `CREATE TABLE` function. The function define the table name and inside a bracket define the column names, attributes (integer, character, etc.), and constrians. For example, let's create a table for the `mtcars` dataset<sup>3</sup> :


``` sql
CREATE TABLE  mtcars (
    model VARCHAR(20) NOT NULL PRIMARY KEY,
    mpg FLOAT(2) NOT NULL,
    cyc INT NOT NULL,
    disp FLOAT(2) NOT NULL,
    hp INT NOT NULL,
    drat FLOAT(2) NOT NULL,
    wt FLOAT(3) NOT NULL,
    qsec FLOAT(2) NOT NULL,
    vs INT NOT NULL,
    am INT NOT NULL,
    gear INT NOT NULL,
    carb INT NOT NULL
);
```

You should expect the following output as confermation that the table was created:
```
CREATE TABLE
```

Where, we set all the columns with the constrain of `NOT NULL` (e.g., cannot enter empty values) and the `model` column as the primary key of the table. The `d` command enables you the review what tables exist on the database:

```
ramikrispin=# \d
           List of relations
 Schema |  Name  | Type  |    Owner
--------+--------+-------+-------------
 public | mtcars | table | ramikrispin
(1 row)

```

Using the `d+` command will return additional information, such as the table descriptions (if exists) and table size:

```
ramikrispin-# \d+
                                       List of relations
 Schema |  Name  | Type  |    Owner    | Persistence | Access method |    Size    | Description
--------+--------+-------+-------------+-------------+---------------+------------+-------------
 public | mtcars | table | ramikrispin | permanent   | heap          | 8192 bytes |
(1 row)
```

**Note:** The `row` number on the table above refer to the number of items in the returned table as opposed to number of raws on the `mtcars` table (which at this point should be 0).


You can use the `d` command to review the table columns and their attribues as defined above:

``` zsh
ramikrispin=# \d mtcars
                      Table "public.mtcars"
 Column |         Type          | Collation | Nullable | Default
--------+-----------------------+-----------+----------+---------
 model  | character varying(20) |           | not null |
 mpg    | real                  |           | not null |
 cyc    | integer               |           | not null |
 disp   | integer               |           | not null |
 hp     | integer               |           | not null |
 drat   | real                  |           | not null |
 wt     | real                  |           | not null |
 qsec   | real                  |           | not null |
 vs     | integer               |           | not null |
 am     | integer               |           | not null |
 gear   | integer               |           | not null |
 carb   | integer               |           | not null |
Indexes:
    "mtcars_pkey" PRIMARY KEY, btree (model)
```

You can see on the table above, all the value on the `Nullable` colume showed the constrain we set above, and all the table fileds must have some value (or `not null`). 


Last but not least, we can print the table by using basic SQL:

``` SQL
SELECT * FROM public.mtcars;
```

Which should return:
```
 model | mpg | cyc | disp | hp | drat | wt | qsec | vs | am | gear | carb
-------+-----+-----+------+----+------+----+------+----+----+------+------
(0 rows)
```


### Populate the Table

After creating the table, the next step is to populate the table with records. The `INSERT INTO` command enables to add new rows (or records) to the table. For example, we will enter the first raw on the `mtcars` dataset for model `Mazda RX4`:

``` 
INSERT INTO mtcars(
    model, mpg, cyc, disp, hp, drat, wt, qsec, vs, am, gear, carb
)
VALUES ('Mazda RX4', 21.0, 6, 160, 110, 3.90, 2.620, 16.46, 0, 1,4, 4);
```

This will retuern:

```
INSERT 0 1
```

Which confirmed that the row was added successfully. Let's query again the table and see the new row values:

```
ramikrispin=# SELECT * FROM public.mtcars;
   model   | mpg | cyc | disp | hp  | drat |  wt  | qsec  | vs | am | gear | carb
-----------+-----+-----+------+-----+------+------+-------+----+----+------+------
 Mazda RX4 |  21 |   6 |  160 | 110 |  3.9 | 2.62 | 16.46 |  0 |  1 |    4 |    4
(1 row)
```

**Note:** Postgres is sensative on the type of quotation mark for strings objects allowing only single quotation mark. This will work 'Mazda RX4', but this "Mazda RX4" will return a syntax error.

What will happen when trying to enter undefined value? Let's now the second row of the `mtcars` dataset for `Mazda RX4 Wag` model, this time we will enter the `cyc` field as float instead of integer (i.e., `6.1` instead of `6`) and print the table again:

``` 
ramikrispin=# INSERT INTO mtcars(                                                                                                                                 model, mpg, cyc, disp, hp, drat, wt, qsec, vs, am, gear, carb                                                                                             )                                                                                                                                                             VALUES ('Mazda RX4 Wag', 21.0, 6.1, 160, 110, 3.90, 2.620, 16.46, 0, 1,4, 4);
INSERT 0 1
ramikrispin=# SELECT * FROM public.mtcars;
     model     | mpg | cyc | disp | hp  | drat |  wt  | qsec  | vs | am | gear | carb
---------------+-----+-----+------+-----+------+------+-------+----+----+------+------
 Mazda RX4     |  21 |   6 |  160 | 110 |  3.9 | 2.62 | 16.46 |  0 |  1 |    4 |    4
 Mazda RX4 Wag |  21 |   6 |  160 | 110 |  3.9 | 2.62 | 16.46 |  0 |  1 |    4 |    4
(2 rows)
```

As you can see the value of the `cyc` was accepted, although we did not use the defined format - integer. It ignored the number decimal and treat it as integer. In other cases it might trigger error, for example, when trying to add string to numeric field (e.g., '6' won't trigger error, but '6a' does). This something to be aware of, as it reformat the input values without triggering any warnnings or error message. 


### Importing data from external sources
In most cases, you won't populate or enter the table fields manually, as in the example above. This section will review different methods to import or load data from external sources.

#### Loading table from CSV file
One of the most common formats for flat files is CSV (or Comma Separated Values). In the following example, we will use the `COPY` command to load the **mtcars** dataset from a CSV file - `mtcars.csv`. The file is available in the `csv` folder. Before loading the file, let's use the `head` command on the terminal to review the data format:

``` shell
head csv/mtcars.csv                                                                            
"model","mpg","cyl","disp","hp","drat","wt","qsec","vs","am","gear","carb"
"Mazda RX4",21,6,160,110,3.9,2.62,16.46,0,1,4,4
"Mazda RX4 Wag",21,6,160,110,3.9,2.875,17.02,0,1,4,4
"Datsun 710",22.8,4,108,93,3.85,2.32,18.61,1,1,4,1
"Hornet 4 Drive",21.4,6,258,110,3.08,3.215,19.44,1,0,3,1
"Hornet Sportabout",18.7,8,360,175,3.15,3.44,17.02,0,0,3,2
"Valiant",18.1,6,225,105,2.76,3.46,20.22,1,0,3,1
"Duster 360",14.3,8,360,245,3.21,3.57,15.84,0,0,3,4
"Merc 240D",24.4,4,146.7,62,3.69,3.19,20,1,0,4,2
"Merc 230",22.8,4,140.8,95,3.92,3.15,22.9,1,0,4,2
```

As you can see, the values on the table are separated with `,` delimiter. Before loading the data from the file, we will have to create a table and declare the columns format. Let's reuse the command we used before to create the `mtcars` table, this time named it `mtcars_csv`:

``` sql
CREATE TABLE  mtcars_csv (
  model VARCHAR(20) NOT NULL PRIMARY KEY,
  mpg FLOAT(2) NOT NULL,
  cyc INT NOT NULL,
  disp FLOAT(2) NOT NULL,
  hp INT NOT NULL,
  drat FLOAT(2) NOT NULL,
  wt FLOAT(3) NOT NULL,
  qsec FLOAT(2) NOT NULL,
  vs INT NOT NULL,
  am INT NOT NULL,
  gear INT NOT NULL,
  carb INT NOT NULL
);

```

The expected output - `CREATE TABLE` confirmed that the table was created successfully.

```
COPY mtcars_csv (
  model, mpg, cyc, disp, hp, drat, wt, qsec, vs, am, gear, carb
  )
FROM 'YOUR_PATH/csv/mtcars.csv'
DELIMITER ','
CSV HEADER;

```

Where `COPY` defines the target table, and `FROM` the target CSV file. You can define the type of the delimiter with the `DELIMITER` argument. Last but not least, the `CSV HEADER` indicated that the first raw is the table header, and it can be skipped. If the data was loaded, successfully from the file, you should expect the following output:

```
COPY 32
```

Which indicated that 32 raws were loaded from the CSV file. We can use the `SELECT` command to confirm that the table was loaded properly:


```
ramikrispin=# SELECT * FROM mtcars_csv LIMIT 10;
       model       | mpg  | cyc | disp  | hp  | drat |  wt   | qsec  | vs | am | gear | carb
-------------------+------+-----+-------+-----+------+-------+-------+----+----+------+------
 Mazda RX4         |   21 |   6 |   160 | 110 |  3.9 |  2.62 | 16.46 |  0 |  1 |    4 |    4
 Mazda RX4 Wag     |   21 |   6 |   160 | 110 |  3.9 | 2.875 | 17.02 |  0 |  1 |    4 |    4
 Datsun 710        | 22.8 |   4 |   108 |  93 | 3.85 |  2.32 | 18.61 |  1 |  1 |    4 |    1
 Hornet 4 Drive    | 21.4 |   6 |   258 | 110 | 3.08 | 3.215 | 19.44 |  1 |  0 |    3 |    1
 Hornet Sportabout | 18.7 |   8 |   360 | 175 | 3.15 |  3.44 | 17.02 |  0 |  0 |    3 |    2
 Valiant           | 18.1 |   6 |   225 | 105 | 2.76 |  3.46 | 20.22 |  1 |  0 |    3 |    1
 Duster 360        | 14.3 |   8 |   360 | 245 | 3.21 |  3.57 | 15.84 |  0 |  0 |    3 |    4
 Merc 240D         | 24.4 |   4 | 146.7 |  62 | 3.69 |  3.19 |    20 |  1 |  0 |    4 |    2
 Merc 230          | 22.8 |   4 | 140.8 |  95 | 3.92 |  3.15 |  22.9 |  1 |  0 |    4 |    2
 Merc 280          | 19.2 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.3 |  1 |  0 |    4 |    4
(10 rows)
```


### Running SQL script

So far we saw how to execute an ad hoc Postgres commends and SQL code from the `psql` consule (e.g., command line interface). Like any other programming language, you can save your commend into a SQL script file and execute it from the command line. In the example below we will create a script that load the `mtcars` dataset from a CSV file and save it as Postgres table:

`mtcars_load_csv.sql`
``` SQL 
DROP TABLE mtcars_auto;

CREATE TABLE  mtcars_auto (
  model VARCHAR(20) NOT NULL PRIMARY KEY,
  mpg FLOAT(2) NOT NULL,
  cyc INT NOT NULL,
  disp FLOAT(2) NOT NULL,
  hp INT NOT NULL,
  drat FLOAT(2) NOT NULL,
  wt FLOAT(3) NOT NULL,
  qsec FLOAT(2) NOT NULL,
  vs INT NOT NULL,
  am INT NOT NULL,
  gear INT NOT NULL,
  carb INT NOT NULL
);

SELECT * FROM mtcars_auto; 

COPY mtcars_auto (
  model, mpg, cyc, disp, hp, drat, wt, qsec, vs, am, gear, carb
  )
FROM 'YOUR_PATH/csv/mtcars.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM mtcars_auto LIMIT 10;

```

**Note:** The file is saved on the `scripts` folder. Before running the script make sure you are replacing `YOUR_PATH` with full path of the root folder.


You can execute SQL scripts from the psql console by using the `i` argument:
```
ramikrispin=# \i /YOUR_PATH/scripts/mtcars_load_csv.sql
DROP TABLE
CREATE TABLE
 model | mpg | cyc | disp | hp | drat | wt | qsec | vs | am | gear | carb
-------+-----+-----+------+----+------+----+------+----+----+------+------
(0 rows)

COPY 32
       model       | mpg  | cyc | disp  | hp  | drat |  wt   | qsec  | vs | am | gear | carb
-------------------+------+-----+-------+-----+------+-------+-------+----+----+------+------
 Mazda RX4         |   21 |   6 |   160 | 110 |  3.9 |  2.62 | 16.46 |  0 |  1 |    4 |    4
 Mazda RX4 Wag     |   21 |   6 |   160 | 110 |  3.9 | 2.875 | 17.02 |  0 |  1 |    4 |    4
 Datsun 710        | 22.8 |   4 |   108 |  93 | 3.85 |  2.32 | 18.61 |  1 |  1 |    4 |    1
 Hornet 4 Drive    | 21.4 |   6 |   258 | 110 | 3.08 | 3.215 | 19.44 |  1 |  0 |    3 |    1
 Hornet Sportabout | 18.7 |   8 |   360 | 175 | 3.15 |  3.44 | 17.02 |  0 |  0 |    3 |    2
 Valiant           | 18.1 |   6 |   225 | 105 | 2.76 |  3.46 | 20.22 |  1 |  0 |    3 |    1
 Duster 360        | 14.3 |   8 |   360 | 245 | 3.21 |  3.57 | 15.84 |  0 |  0 |    3 |    4
 Merc 240D         | 24.4 |   4 | 146.7 |  62 | 3.69 |  3.19 |    20 |  1 |  0 |    4 |    2
 Merc 230          | 22.8 |   4 | 140.8 |  95 | 3.92 |  3.15 |  22.9 |  1 |  0 |    4 |    2
 Merc 280          | 19.2 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.3 |  1 |  0 |    4 |    4
(10 rows)
```

A more robust approach for running SQL scripts would be from the command line using the `psql` function to trigger a script. This is a useful functionality as it enable you to automate your processes by triggering your code with some scripting language such as R, Pythin, or Bash. For example, let's re-execute the same script, this time from the command line:

``` shell
 psql ramikrispin -h 127.0.0.1 -d ramikrispin  -f scripts/mtcars_load_csv.sql
```

As you can see we added to the `psql` the following four arguments:
- `ramikrispin` - the user name
- `-h 127.0.0.1` - the host name
- `-d ramikrispin` - the name of the database to execute the file
- `-f scripts/mtcars_load_csv.sql` - the path and file name of the SQL script

You should expect the following output:

```
 DROP TABLE
CREATE TABLE
 model | mpg | cyc | disp | hp | drat | wt | qsec | vs | am | gear | carb
-------+-----+-----+------+----+------+----+------+----+----+------+------
(0 rows)

COPY 32
       model       | mpg  | cyc | disp  | hp  | drat |  wt   | qsec  | vs | am | gear | carb
-------------------+------+-----+-------+-----+------+-------+-------+----+----+------+------
 Mazda RX4         |   21 |   6 |   160 | 110 |  3.9 |  2.62 | 16.46 |  0 |  1 |    4 |    4
 Mazda RX4 Wag     |   21 |   6 |   160 | 110 |  3.9 | 2.875 | 17.02 |  0 |  1 |    4 |    4
 Datsun 710        | 22.8 |   4 |   108 |  93 | 3.85 |  2.32 | 18.61 |  1 |  1 |    4 |    1
 Hornet 4 Drive    | 21.4 |   6 |   258 | 110 | 3.08 | 3.215 | 19.44 |  1 |  0 |    3 |    1
 Hornet Sportabout | 18.7 |   8 |   360 | 175 | 3.15 |  3.44 | 17.02 |  0 |  0 |    3 |    2
 Valiant           | 18.1 |   6 |   225 | 105 | 2.76 |  3.46 | 20.22 |  1 |  0 |    3 |    1
 Duster 360        | 14.3 |   8 |   360 | 245 | 3.21 |  3.57 | 15.84 |  0 |  0 |    3 |    4
 Merc 240D         | 24.4 |   4 | 146.7 |  62 | 3.69 |  3.19 |    20 |  1 |  0 |    4 |    2
 Merc 230          | 22.8 |   4 | 140.8 |  95 | 3.92 |  3.15 |  22.9 |  1 |  0 |    4 |    2
 Merc 280          | 19.2 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.3 |  1 |  0 |    4 |    4
(10 rows)
```

If you will login back to `psql` and print the list of tables, you should see the new table on the output:

```
ramikrispin=# \d
             List of relations
 Schema |    Name     | Type  |    Owner
--------+-------------+-------+-------------
 public | mtcars      | table | ramikrispin
 public | mtcars_auto | table | ramikrispin
 public | mtcars_csv  | table | ramikrispin
(3 rows)

```



One of the limitation of this type of script that the CSV file path is static, therefore, any time the path is changing (or using different machine) you will have to modify the script. One way to mitigate this issue is by set the CSV path as argument that the user can set dynamicly. Let's update the previous script and replace the file name and path with the `file_name` argument:

`mtcars_load_csv_dynamic.sql`
``` SQL
DROP TABLE mtcars_auto;

CREATE TABLE  mtcars_auto (
  model VARCHAR(20) NOT NULL PRIMARY KEY,
  mpg FLOAT(2) NOT NULL,
  cyc INT NOT NULL,
  disp FLOAT(2) NOT NULL,
  hp INT NOT NULL,
  drat FLOAT(2) NOT NULL,
  wt FLOAT(3) NOT NULL,
  qsec FLOAT(2) NOT NULL,
  vs INT NOT NULL,
  am INT NOT NULL,
  gear INT NOT NULL,
  carb INT NOT NULL
);

SELECT * FROM mtcars_auto; 

COPY mtcars_auto (
  model, mpg, cyc, disp, hp, drat, wt, qsec, vs, am, gear, carb
  )
FROM :file_name
DELIMITER ','
CSV HEADER;

SELECT * FROM mtcars_auto LIMIT 10;
```

**Note:** This file is available on the `script` folder.

Let's now execute the file, this time we will define the `file_name` variable with the `-v` argument:

```
psql ramikrispin -h 127.0.0.1 -d ramikrispin -v file_name="'$PSQL_ROOT/csv/mtcars.csv'"  -f scripts/mtcars_load_csv_dynamic.sql
```


**Note:** We used both single and double quotes to pass the file path to the argument. 

You should receive the same output as the one above. Where, `$PSQL_ROOT` is a variable that define the root folder on my machine, alternativly, you can set the full path. 


### Sources
* **Tutrial -** https://www.youtube.com/watch?v=qw--VYLpxG4&t=1073s&ab_channel=freeCodeCamp.org
* **PostgreSQL -** https://en.wikipedia.org/wiki/PostgreSQL
* **Documentation -** https://www.postgresql.org/docs/

Import file from CSV - https://www.postgresqltutorial.com/import-csv-file-into-posgresql-table/
Run sql file on postgres - https://kb.objectrocket.com/postgresql/how-to-run-an-sql-file-in-postgres-846
<sup>1</sup> https://www.freecodecamp.org/news/postgresql-full-course/

<sup>2 </sup> Source [Postgres Wikipedia](https://en.wikipedia.org/wiki/PostgreSQL) page

<sup>3</sup> The `mtcars` data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models). This dataset can be found on the R `datasets` package.



### Basic SQL commands

The SQL (Structured Query Language) programming language enable us to quary and manage data in a relational database system. In this section we will cover most common SQL statments that will enable you to query your tables. In the comming examples we will use the `mtcars_csv` table we loaded earlier to Postgres:
```
ramikrispin=# \d mtcars_csv
                    Table "public.mtcars_csv"
 Column |         Type          | Collation | Nullable | Default
--------+-----------------------+-----------+----------+---------
 model  | character varying(20) |           | not null |
 mpg    | real                  |           | not null |
 cyc    | integer               |           | not null |
 disp   | real                  |           | not null |
 hp     | integer               |           | not null |
 drat   | real                  |           | not null |
 wt     | real                  |           | not null |
 qsec   | real                  |           | not null |
 vs     | integer               |           | not null |
 am     | integer               |           | not null |
 gear   | integer               |           | not null |
 carb   | integer               |           | not null |
Indexes:
    "mtcars_csv_pkey" PRIMARY KEY, btree (model)

```

#### The SELECT...FROM statment

The `SELECT...FROM` statment is one of the most common SQL commands which is used, as the implies, to select data fields from a table. A basic `SELECT...FROM` statment must includes both the columns names you want to select and the table name you want to select from:

```SQL
SELECT column1, column2, ..., columnN
FROM table_name;
```

**Note:** While the **SQL** language is not case sensative, it is common to use upper case for the the language statments.
 
For example, let's select from the `mtcars_csv` table the `model`, `mpg`, and `cyc` fields:

```
SELECT model, mpg, cyc FROM mtcars_csv;
        model        | mpg  | cyc
---------------------+------+-----
 Mazda RX4           |   21 |   6
 Mazda RX4 Wag       |   21 |   6
 Datsun 710          | 22.8 |   4
 Hornet 4 Drive      | 21.4 |   6
 Hornet Sportabout   | 18.7 |   8
 Valiant             | 18.1 |   6
 Duster 360          | 14.3 |   8
 Merc 240D           | 24.4 |   4
 Merc 230            | 22.8 |   4
 Merc 280            | 19.2 |   6
 Merc 280C           | 17.8 |   6
 Merc 450SE          | 16.4 |   8
 Merc 450SL          | 17.3 |   8
 Merc 450SLC         | 15.2 |   8
 Cadillac Fleetwood  | 10.4 |   8
 Lincoln Continental | 10.4 |   8
 Chrysler Imperial   | 14.7 |   8
 Fiat 128            | 32.4 |   4
 Honda Civic         | 30.4 |   4
 Toyota Corolla      | 33.9 |   4
 Toyota Corona       | 21.5 |   4
 Dodge Challenger    | 15.5 |   8
 AMC Javelin         | 15.2 |   8
 Camaro Z28          | 13.3 |   8
 Pontiac Firebird    | 19.2 |   8
 Fiat X1-9           | 27.3 |   4
 Porsche 914-2       |   26 |   4
 Lotus Europa        | 30.4 |   4
 Ford Pantera L      | 15.8 |   8
 Ferrari Dino        | 19.7 |   6
 Maserati Bora       |   15 |   8
 Volvo 142E          | 21.4 |   4
 (32 rows)
 ```

In the case you want to select all available columns you can use the `*` symbol as shortcut:

```
ramikrispin=# SELECT * FROM mtcars_csv;
        model        | mpg  | cyc | disp  | hp  | drat |  wt   | qsec  | vs | am | gear | carb
---------------------+------+-----+-------+-----+------+-------+-------+----+----+------+------
 Mazda RX4           |   21 |   6 |   160 | 110 |  3.9 |  2.62 | 16.46 |  0 |  1 |    4 |    4
 Mazda RX4 Wag       |   21 |   6 |   160 | 110 |  3.9 | 2.875 | 17.02 |  0 |  1 |    4 |    4
 Datsun 710          | 22.8 |   4 |   108 |  93 | 3.85 |  2.32 | 18.61 |  1 |  1 |    4 |    1
 Hornet 4 Drive      | 21.4 |   6 |   258 | 110 | 3.08 | 3.215 | 19.44 |  1 |  0 |    3 |    1
 Hornet Sportabout   | 18.7 |   8 |   360 | 175 | 3.15 |  3.44 | 17.02 |  0 |  0 |    3 |    2
 Valiant             | 18.1 |   6 |   225 | 105 | 2.76 |  3.46 | 20.22 |  1 |  0 |    3 |    1
 Duster 360          | 14.3 |   8 |   360 | 245 | 3.21 |  3.57 | 15.84 |  0 |  0 |    3 |    4
 Merc 240D           | 24.4 |   4 | 146.7 |  62 | 3.69 |  3.19 |    20 |  1 |  0 |    4 |    2
 Merc 230            | 22.8 |   4 | 140.8 |  95 | 3.92 |  3.15 |  22.9 |  1 |  0 |    4 |    2
 Merc 280            | 19.2 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.3 |  1 |  0 |    4 |    4
 Merc 280C           | 17.8 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.9 |  1 |  0 |    4 |    4
 Merc 450SE          | 16.4 |   8 | 275.8 | 180 | 3.07 |  4.07 |  17.4 |  0 |  0 |    3 |    3
 Merc 450SL          | 17.3 |   8 | 275.8 | 180 | 3.07 |  3.73 |  17.6 |  0 |  0 |    3 |    3
 Merc 450SLC         | 15.2 |   8 | 275.8 | 180 | 3.07 |  3.78 |    18 |  0 |  0 |    3 |    3
 Cadillac Fleetwood  | 10.4 |   8 |   472 | 205 | 2.93 |  5.25 | 17.98 |  0 |  0 |    3 |    4
 Lincoln Continental | 10.4 |   8 |   460 | 215 |    3 | 5.424 | 17.82 |  0 |  0 |    3 |    4
 Chrysler Imperial   | 14.7 |   8 |   440 | 230 | 3.23 | 5.345 | 17.42 |  0 |  0 |    3 |    4
 Fiat 128            | 32.4 |   4 |  78.7 |  66 | 4.08 |   2.2 | 19.47 |  1 |  1 |    4 |    1
 Honda Civic         | 30.4 |   4 |  75.7 |  52 | 4.93 | 1.615 | 18.52 |  1 |  1 |    4 |    2
 Toyota Corolla      | 33.9 |   4 |  71.1 |  65 | 4.22 | 1.835 |  19.9 |  1 |  1 |    4 |    1
 Toyota Corona       | 21.5 |   4 | 120.1 |  97 |  3.7 | 2.465 | 20.01 |  1 |  0 |    3 |    1
 Dodge Challenger    | 15.5 |   8 |   318 | 150 | 2.76 |  3.52 | 16.87 |  0 |  0 |    3 |    2
 AMC Javelin         | 15.2 |   8 |   304 | 150 | 3.15 | 3.435 |  17.3 |  0 |  0 |    3 |    2
 Camaro Z28          | 13.3 |   8 |   350 | 245 | 3.73 |  3.84 | 15.41 |  0 |  0 |    3 |    4
 Pontiac Firebird    | 19.2 |   8 |   400 | 175 | 3.08 | 3.845 | 17.05 |  0 |  0 |    3 |    2
 Fiat X1-9           | 27.3 |   4 |    79 |  66 | 4.08 | 1.935 |  18.9 |  1 |  1 |    4 |    1
 Porsche 914-2       |   26 |   4 | 120.3 |  91 | 4.43 |  2.14 |  16.7 |  0 |  1 |    5 |    2
 Lotus Europa        | 30.4 |   4 |  95.1 | 113 | 3.77 | 1.513 |  16.9 |  1 |  1 |    5 |    2
 Ford Pantera L      | 15.8 |   8 |   351 | 264 | 4.22 |  3.17 |  14.5 |  0 |  1 |    5 |    4
 Ferrari Dino        | 19.7 |   6 |   145 | 175 | 3.62 |  2.77 |  15.5 |  0 |  1 |    5 |    6
 Maserati Bora       |   15 |   8 |   301 | 335 | 3.54 |  3.57 |  14.6 |  0 |  1 |    5 |    8
 Volvo 142E          | 21.4 |   4 |   121 | 109 | 4.11 |  2.78 |  18.6 |  1 |  1 |    4 |    2
(32 rows)
```



#### Sorting the table

The `ORDER BY` statments enables to order or sort your selected output in ascending or descending order with the use of the `ASC` (default) and `DESC` arguments, respectivelly. For example, let's now select all columns from the `mtcars_csv` table and sort the model name in a descend order:

```
ramikrispin=# SELECT * FROM mtcars_csv ORDER BY model ASC;
        model        | mpg  | cyc | disp  | hp  | drat |  wt   | qsec  | vs | am | gear | carb
---------------------+------+-----+-------+-----+------+-------+-------+----+----+------+------
 AMC Javelin         | 15.2 |   8 |   304 | 150 | 3.15 | 3.435 |  17.3 |  0 |  0 |    3 |    2
 Cadillac Fleetwood  | 10.4 |   8 |   472 | 205 | 2.93 |  5.25 | 17.98 |  0 |  0 |    3 |    4
 Camaro Z28          | 13.3 |   8 |   350 | 245 | 3.73 |  3.84 | 15.41 |  0 |  0 |    3 |    4
 Chrysler Imperial   | 14.7 |   8 |   440 | 230 | 3.23 | 5.345 | 17.42 |  0 |  0 |    3 |    4
 Datsun 710          | 22.8 |   4 |   108 |  93 | 3.85 |  2.32 | 18.61 |  1 |  1 |    4 |    1
 Dodge Challenger    | 15.5 |   8 |   318 | 150 | 2.76 |  3.52 | 16.87 |  0 |  0 |    3 |    2
 Duster 360          | 14.3 |   8 |   360 | 245 | 3.21 |  3.57 | 15.84 |  0 |  0 |    3 |    4
 Ferrari Dino        | 19.7 |   6 |   145 | 175 | 3.62 |  2.77 |  15.5 |  0 |  1 |    5 |    6
 Fiat 128            | 32.4 |   4 |  78.7 |  66 | 4.08 |   2.2 | 19.47 |  1 |  1 |    4 |    1
 Fiat X1-9           | 27.3 |   4 |    79 |  66 | 4.08 | 1.935 |  18.9 |  1 |  1 |    4 |    1
 Ford Pantera L      | 15.8 |   8 |   351 | 264 | 4.22 |  3.17 |  14.5 |  0 |  1 |    5 |    4
 Honda Civic         | 30.4 |   4 |  75.7 |  52 | 4.93 | 1.615 | 18.52 |  1 |  1 |    4 |    2
 Hornet 4 Drive      | 21.4 |   6 |   258 | 110 | 3.08 | 3.215 | 19.44 |  1 |  0 |    3 |    1
 Hornet Sportabout   | 18.7 |   8 |   360 | 175 | 3.15 |  3.44 | 17.02 |  0 |  0 |    3 |    2
 Lincoln Continental | 10.4 |   8 |   460 | 215 |    3 | 5.424 | 17.82 |  0 |  0 |    3 |    4
 Lotus Europa        | 30.4 |   4 |  95.1 | 113 | 3.77 | 1.513 |  16.9 |  1 |  1 |    5 |    2
 Maserati Bora       |   15 |   8 |   301 | 335 | 3.54 |  3.57 |  14.6 |  0 |  1 |    5 |    8
 Mazda RX4           |   21 |   6 |   160 | 110 |  3.9 |  2.62 | 16.46 |  0 |  1 |    4 |    4
 Mazda RX4 Wag       |   21 |   6 |   160 | 110 |  3.9 | 2.875 | 17.02 |  0 |  1 |    4 |    4
 Merc 230            | 22.8 |   4 | 140.8 |  95 | 3.92 |  3.15 |  22.9 |  1 |  0 |    4 |    2
 Merc 240D           | 24.4 |   4 | 146.7 |  62 | 3.69 |  3.19 |    20 |  1 |  0 |    4 |    2
 Merc 280            | 19.2 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.3 |  1 |  0 |    4 |    4
 Merc 280C           | 17.8 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.9 |  1 |  0 |    4 |    4
 Merc 450SE          | 16.4 |   8 | 275.8 | 180 | 3.07 |  4.07 |  17.4 |  0 |  0 |    3 |    3
 Merc 450SL          | 17.3 |   8 | 275.8 | 180 | 3.07 |  3.73 |  17.6 |  0 |  0 |    3 |    3
 Merc 450SLC         | 15.2 |   8 | 275.8 | 180 | 3.07 |  3.78 |    18 |  0 |  0 |    3 |    3
 Pontiac Firebird    | 19.2 |   8 |   400 | 175 | 3.08 | 3.845 | 17.05 |  0 |  0 |    3 |    2
 Porsche 914-2       |   26 |   4 | 120.3 |  91 | 4.43 |  2.14 |  16.7 |  0 |  1 |    5 |    2
 Toyota Corolla      | 33.9 |   4 |  71.1 |  65 | 4.22 | 1.835 |  19.9 |  1 |  1 |    4 |    1
 Toyota Corona       | 21.5 |   4 | 120.1 |  97 |  3.7 | 2.465 | 20.01 |  1 |  0 |    3 |    1
 Valiant             | 18.1 |   6 |   225 | 105 | 2.76 |  3.46 | 20.22 |  1 |  0 |    3 |    1
 Volvo 142E          | 21.4 |   4 |   121 | 109 | 4.11 |  2.78 |  18.6 |  1 |  1 |    4 |    2
(32 rows)
```

Similarly, we can sort the output by multiple fileds. For example, let's sort the output table by number of cylinders (`cyc`) in a descending order (from high to low) and by their full consuption (`mpg`) in a ascending order (from low to high):

```
ramikrispin=# SELECT * FROM mtcars_csv ORDER BY cyc DESC, mpg ASC;
        model        | mpg  | cyc | disp  | hp  | drat |  wt   | qsec  | vs | am | gear | carb
---------------------+------+-----+-------+-----+------+-------+-------+----+----+------+------
 Lincoln Continental | 10.4 |   8 |   460 | 215 |    3 | 5.424 | 17.82 |  0 |  0 |    3 |    4
 Cadillac Fleetwood  | 10.4 |   8 |   472 | 205 | 2.93 |  5.25 | 17.98 |  0 |  0 |    3 |    4
 Camaro Z28          | 13.3 |   8 |   350 | 245 | 3.73 |  3.84 | 15.41 |  0 |  0 |    3 |    4
 Duster 360          | 14.3 |   8 |   360 | 245 | 3.21 |  3.57 | 15.84 |  0 |  0 |    3 |    4
 Chrysler Imperial   | 14.7 |   8 |   440 | 230 | 3.23 | 5.345 | 17.42 |  0 |  0 |    3 |    4
 Maserati Bora       |   15 |   8 |   301 | 335 | 3.54 |  3.57 |  14.6 |  0 |  1 |    5 |    8
 AMC Javelin         | 15.2 |   8 |   304 | 150 | 3.15 | 3.435 |  17.3 |  0 |  0 |    3 |    2
 Merc 450SLC         | 15.2 |   8 | 275.8 | 180 | 3.07 |  3.78 |    18 |  0 |  0 |    3 |    3
 Dodge Challenger    | 15.5 |   8 |   318 | 150 | 2.76 |  3.52 | 16.87 |  0 |  0 |    3 |    2
 Ford Pantera L      | 15.8 |   8 |   351 | 264 | 4.22 |  3.17 |  14.5 |  0 |  1 |    5 |    4
 Merc 450SE          | 16.4 |   8 | 275.8 | 180 | 3.07 |  4.07 |  17.4 |  0 |  0 |    3 |    3
 Merc 450SL          | 17.3 |   8 | 275.8 | 180 | 3.07 |  3.73 |  17.6 |  0 |  0 |    3 |    3
 Hornet Sportabout   | 18.7 |   8 |   360 | 175 | 3.15 |  3.44 | 17.02 |  0 |  0 |    3 |    2
 Pontiac Firebird    | 19.2 |   8 |   400 | 175 | 3.08 | 3.845 | 17.05 |  0 |  0 |    3 |    2
 Merc 280C           | 17.8 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.9 |  1 |  0 |    4 |    4
 Valiant             | 18.1 |   6 |   225 | 105 | 2.76 |  3.46 | 20.22 |  1 |  0 |    3 |    1
 Merc 280            | 19.2 |   6 | 167.6 | 123 | 3.92 |  3.44 |  18.3 |  1 |  0 |    4 |    4
 Ferrari Dino        | 19.7 |   6 |   145 | 175 | 3.62 |  2.77 |  15.5 |  0 |  1 |    5 |    6
 Mazda RX4           |   21 |   6 |   160 | 110 |  3.9 |  2.62 | 16.46 |  0 |  1 |    4 |    4
 Mazda RX4 Wag       |   21 |   6 |   160 | 110 |  3.9 | 2.875 | 17.02 |  0 |  1 |    4 |    4
 Hornet 4 Drive      | 21.4 |   6 |   258 | 110 | 3.08 | 3.215 | 19.44 |  1 |  0 |    3 |    1
 Volvo 142E          | 21.4 |   4 |   121 | 109 | 4.11 |  2.78 |  18.6 |  1 |  1 |    4 |    2
 Toyota Corona       | 21.5 |   4 | 120.1 |  97 |  3.7 | 2.465 | 20.01 |  1 |  0 |    3 |    1
 Datsun 710          | 22.8 |   4 |   108 |  93 | 3.85 |  2.32 | 18.61 |  1 |  1 |    4 |    1
 Merc 230            | 22.8 |   4 | 140.8 |  95 | 3.92 |  3.15 |  22.9 |  1 |  0 |    4 |    2
 Merc 240D           | 24.4 |   4 | 146.7 |  62 | 3.69 |  3.19 |    20 |  1 |  0 |    4 |    2
 Porsche 914-2       |   26 |   4 | 120.3 |  91 | 4.43 |  2.14 |  16.7 |  0 |  1 |    5 |    2
 Fiat X1-9           | 27.3 |   4 |    79 |  66 | 4.08 | 1.935 |  18.9 |  1 |  1 |    4 |    1
 Lotus Europa        | 30.4 |   4 |  95.1 | 113 | 3.77 | 1.513 |  16.9 |  1 |  1 |    5 |    2
 Honda Civic         | 30.4 |   4 |  75.7 |  52 | 4.93 | 1.615 | 18.52 |  1 |  1 |    4 |    2
 Fiat 128            | 32.4 |   4 |  78.7 |  66 | 4.08 |   2.2 | 19.47 |  1 |  1 |    4 |    1
 Toyota Corolla      | 33.9 |   4 |  71.1 |  65 | 4.22 | 1.835 |  19.9 |  1 |  1 |    4 |    1
```

This type of sorting enable us to sort for each cylinder group (e.g., 8, 6, 4) by their mile per galon performance.



