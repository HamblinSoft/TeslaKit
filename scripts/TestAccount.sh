#!/bin/sh

# Read Test Account data from file or create file if one does not exist

filename="TestAccount.json"
filepath="$SRCROOT/$filename"

if [ -e $filepath ]
then
echo "File exists"
else
cat <<EOF > $filepath
{"email": "", "password": ""}
EOF
echo "File created. Please enter your credentials for testing."
fi

cp "$filepath" "${BUILT_PRODUCTS_DIR}/Example.app/$filename"

