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


### Loading SQL script


``` SQL
DROP TABLE mtcars_csv;

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

COPY mtcars_csv (
  model, mpg, cyc, disp, hp, drat, wt, qsec, vs, am, gear, carb
  )
FROM 'YOUR_PATH/csv/mtcars.csv'
DELIMITER ','
CSV HEADER;

```





### Sources
* **Tutrial -** https://www.youtube.com/watch?v=qw--VYLpxG4&t=1073s&ab_channel=freeCodeCamp.org
* **PostgreSQL -** https://en.wikipedia.org/wiki/PostgreSQL
* **Documentation -** https://www.postgresql.org/docs/



<sup>1</sup> https://www.freecodecamp.org/news/postgresql-full-course/

<sup>2 </sup> Source [Postgres Wikipedia](https://en.wikipedia.org/wiki/PostgreSQL) page

<sup>3</sup> The `mtcars` data was extracted from the 1974 Motor Trend US magazine, and comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models). This dataset can be found on the R `datasets` package.


