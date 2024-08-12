# Running DuckDB from the CLI

Let's clean up any past runs

```bash
rm -r db
mkdir db
rm -r output
mkdir output
```

Launch duckdb CLI

```bash
duckdb
```

Create a table
```sql
CREATE TABLE ducks AS
SELECT 3 AS age,
    'mandarin' AS breed;
```

Display tables
```sql
SHOW tables;
SELECT * FROM ducks;
FROM ducks;
SHOW ducks;
```

If we exit the duckdb CLI here (Ctrl+D) then the table will be gone (by default, it doesn't persist anything in memory)

```bash
duckdb
```

```sql
SHOW tables;
```

We can relaunch duckdb with a database file to persist the data. This is a custom DuckDB file format that is very lightweight. You can read more [here](https://duckdb.org/2022/10/28/lightweight-compression.html) for more information if you're so inclined (I was not)

```bash
duckdb db/anna_test.db;
```

Show databases and we will see our DB

```sql
show databases;
```

Now we see the database we created in the file explorer

Let's exit and create a new DB and read data into it
```bash
duckdb db/netflix.db;
show databases;
```

Read data from csv ("_auto" means infer the schema automatically). We could also pass the schema or delimeter manually

```sql
FROM read_csv_auto('./data/netflix_daily_top_10.csv')
limit 3;
```

This just reads the data and displays it, it doesn't create a table as we can see
```sql
show tables;
```

Let's create a table from the csv

```sql
CREATE TABLE netflix_daily_top_10 AS
FROM read_csv_auto('./data/netflix_daily_top_10.csv');
SHOW tables;
SHOW netflix_daily_top_10;
```

We can also export the data e.g. export to csv. We just pass the path and tell it to extract the header and use the comma delimiter
```sql
COPY netflix_daily_top_10 TO 'output/output.csv' (HEADER, DELIMITER ',');
```

Or export to parquet, for which we just need the format
```sql
COPY netflix_daily_top_10 TO 'output/output.parquet' (FORMAT PARQUET);
```

We can also output to markdown or json or other file formats.

We can also read directly from a file
```sql
FROM read_parquet('output/output.parquet')
LIMIT 10;
```

We can then do some analysis on the data

e.g. Display the most popular TV Shows

```sql
SELECT Title,
    max("Days In Top 10")
from netflix_daily_top_10
where Type = 'TV Show'
GROUP BY Title
ORDER BY max("Days In Top 10") desc
limit 5;
```

Display the most popular TV Shows
```sql
SELECT Title,
    max("Days In Top 10")
from netflix_daily_top_10
where Type = 'Movie'
GROUP BY Title
ORDER BY max("Days In Top 10") desc
limit 5;
```

And then copy the result to CSV
```sql
COPY (
    SELECT Title,
        max("Days In Top 10")
    from netflix_daily_top_10
    where Type = 'TV Show'
    GROUP BY Title
    ORDER BY max("Days In Top 10") desc
    limit 5
) TO 'output/results.csv' (HEADER, DELIMITER ',');
```

If we want to [read data from GCS](https://duckdb.org/docs/guides/network_cloud_storage/gcs_import), we would need to install and load the httpfs duckdb extension

```sql
INSTALL httpfs;
LOAD httpfs;
```

Create a [HMAC Key](https://console.cloud.google.com/storage/settings;tab=interoperability?project=ocean-ml-sandbox)
```sql
CREATE SECRET (
    TYPE GCS,
    KEY_ID 'GOOGDIMUPPWJXIMN3UFRW5GO',
    SECRET '<SOME-SECRET-KEY>'
);
```

And then you just query the remote file
```sql
FROM read_csv('gs://anna_demo/taxi_zone_lookup.csv');
```

I found this somewhat easier in python just by authenticating with the CLI, but it might be faster with the CLI. Depends what you want to do

We can also use the VSCode extension and SQL file (switch to `duckdb_playground.sql`)