# SQLMesh POC to show error warnings and errors

The projet use UV to manage the dependencies.
The error logs are in the logs/errors.log file.

We notice a performance issue, running the project with the following command:

uv run sqlmesh plan + apply is taking hours to run those few models.
