function handler () {
  echo "dropping target database $TARGET_DB@$TARGET_HOST" 1>&2;
  mysql \
    --user $TARGET_USER\
    --password=$TARGET_PASSWORD \
    --host $TARGET_HOST \
    -e "drop database if exists $TARGET_DB;"

  echo "creating an empty target database $TARGET_DB@$TARGET_HOST" 1>&2;
  mysql \
    --user $TARGET_USER\
    --password=$TARGET_PASSWORD \
    --host $TARGET_HOST \
    -e "create database $TARGET_DB;"

  echo "dumping data from source database $SOURCE_DB@$SOURCE_HOST to target database $TARGET_DB@$TARGET_HOST" 1>&2
  mysqldump \
    --user $SOURCE_USER\
    --password=$SOURCE_PASSWORD \
    --host $SOURCE_HOST \
    --set-gtid-purged=OFF \
    --ignore-table=$SOURCE_DB.versions \
    --ignore-table=$SOURCE_DB.tmp_profile_versions \
    --ignore-table=$SOURCE_DB.credit_cards \
    --ignore-table=$SOURCE_DB.encrypted_attributes \
    --ignore-table=$SOURCE_DB.old_passwords \
    --ignore-table=$SOURCE_DB.user_authentications \
    --ignore-table=$SOURCE_DB.user_passports \
    --ignore-table=$SOURCE_DB.user_passport_visas \
    --ignore-table=$SOURCE_DB.company_logos \
    --column-statistics=0 \
    $SOURCE_DB | mysql \
    --user $TARGET_USER\
    --password=$TARGET_PASSWORD \
    --host $TARGET_HOST \
    $TARGET_DB
    
  echo "updating target database $TARGET_DB@$TARGET_HOST" 1>&2;
  mysql \
    --user $TARGET_USER\
    --password=$TARGET_PASSWORD \
    --host $TARGET_HOST \
    -e "update $TARGET_DB.auth0_connections set code = 'uom-demo' where company_id = 6432;"

  echo "mysqldump from source database $SOURCE_DB@$SOURCE_HOST to target database $TARGET_DB@$TARGET_HOST is completed" 1>&2;
}
