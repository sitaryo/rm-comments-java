echo "delete java comments in : $1";
echo "delete properties/sql/xml comments in : $2";

# delete java comments
mvn package -Dmaven.test.skip=true && java -jar ./target/mvcommentsjava-1.0-SNAPSHOT.jar $1

# https://stackoverflow.com/a/37681075 delete multi-line use sed
# use gnu-sed not mac-sed
# remove #
find $2 -type f -name "*.properties" -exec gsed -i 's|#.*$||' {} \;
# remove --
find $2 -type f -name "*.sql" -exec gsed -i 's|--.*$||' {} \;
# remove <!-- -->
find $2 -type f -name "*.xml" -exec gsed -i -e 's|<!--.*-->||' -e '/<!--/{:a;N;/-->/!ba};//d' {} \;
