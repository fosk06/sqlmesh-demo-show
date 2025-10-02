# SQLMesh POC to show error warnings and errors

The projet use UV to manage the dependencies.
The error logs are in the logs/errors.log file..

We notice a performance issue, running the project with the following command:

uv run sqlmesh plan + apply is taking hours to run those few models.

## Docker Usage

### GCP VM Setup

1. **Create a VM with Docker installed**
2. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd sqlmesh-demo-show
   ```

3. **Build the Docker image**

   ```bash
   docker build -t sqlmesh-demo-show .
   ```

4. **Run container with GCP Application Default Credentials (ADC)**
   ```bash
   docker run -it --rm \
     -v ~/.config/gcloud:/root/.config/gcloud \
     sqlmesh-demo-show /bin/bash
   ```

### Run SQLMesh commands

Once inside the container, you can run SQLMesh commands using UV:

```bash
# Plan and apply changes
uv run sqlmesh plan # then type y

# Other useful commands
uv run sqlmesh info
uv run sqlmesh test
uv run sqlmesh audit
```

### Run commands directly without shell

```bash
# Execute SQLMesh commands directly with GCP ADC
docker run --rm \
  -v ~/.config/gcloud:/root/.config/gcloud \
  sqlmesh-demo-show uv run sqlmesh plan
```

### Local Development (without GCP)

For local development without GCP credentials:

```bash
# Build the image
docker build -t sqlmesh-demo-show .

# Open interactive shell
docker run -it --rm sqlmesh-demo-show /bin/bash
```
