function handler () {
  # testing 123
  mysql \
    --user $UAT_USERNAME \
    --password=$UAT_PASSWORD \
    --host $UAT_HOSTNAME \
    -e "drop database if exists $UAT_DBNAME;" 1>&2;
}
