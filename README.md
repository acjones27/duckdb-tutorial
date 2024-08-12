# DuckDB

## Installation

See the [DuckDB website](https://duckdb.org/docs/installation/?version=stable&environment=cli&platform=macos&download_method=package_manager) for information on how to install. You can install the CLI or python client 


### For the CLI

On MacOS we can install with brew

```bash
brew install duckdb
```

And then launch the CLI with

```bash
duckdb
```

### For the Python Client

As a bare minimum, we can just `pip install duckdb`. See the [notebook](duckdb_python_client.ipynb) for more packages that might be needed to connect to GCS or run from a jupyter notebook

### VSCode Extension

The `DuckDB Sql Tools` extension is quite useful for viewing and quering the data like a normal DB from VSCode

### Tutorials

- DuckDB into tutorial: https://www.youtube.com/watch?v=ZX5FdqzGT1E
- [CLI examples](duckdb_cli.md)
- [SQL examples](duckdb_sql_extension.sql)
- [Python client examples](duckdb_python_client.ipynb)