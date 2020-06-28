## setting
# basic information
container_name="cgrg-postgresql"
image_name="postgres:12.2"
hostname_in_container="cgrg_postgresql"

# postgresql port
host_port_postgres=5432
container_port_postgres=5432
port_postgres="${host_port_postgres}:${container_port_postgres}"

# postgresql environment variables
POSTGRES_USER="root"
POSTGRES_PASSWORD="rootPassHERE"
POSTGRES_DB="admin"

# postgresql mount volumes
entrypoint="${PWD}/entrypoint"
db="${PWD}/datadir"

# timezone
# method 1: mount volume "/etc/localtime"
# TZ="/etc/localtime:/etc/localtime:ro"
# method 2: set timezone environment variable
TZ="Asia/Taipei"

# other options
force_remove_container=true


## run container
# remove tf container
if [ "$force_remove_container" = true ]; then
    docker container rm -v -f ${container_name}
fi

docker run -d \
    -e "TZ=${TZ}" \
    -e "POSTGRES_USER=${POSTGRES_USER}" \
    -e "POSTGRES_PASSWORD=${POSTGRES_PASSWORD}" \
    -e "POSTGRES_DB=${POSTGRES_DB}" \
    -p ${port_postgres} \
    -v "${entrypoint}:/docker-entrypoint-initdb.d" \
    -v "${db}:/var/lib/postgresql/data" \
    --hostname ${hostname_in_container} \
    --name ${container_name} \
    ${image_name}
