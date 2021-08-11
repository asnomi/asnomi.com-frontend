#!/bin/bash

## include
. ./devenv

cd ${ROOTDIR}

echo "===================================="
echo "Deploy start: ${BUCKET}"
echo "===================================="

#echo "S3 Cleanup"
#aws s3 rm s3://${BUCKET}/img/ ${OPTION}
#aws s3 rm s3://${BUCKET}/contents/ ${OPTION}
#aws s3 rm s3://${BUCKET}/style/ ${OPTION}
#echo "Cleanup Finished"

echo "Pug Compile"
cd pug
pug *.pug
mv work*.html ../docroot/contents/   
mv discography.html ../docroot/
mv biography.html ../docroot/
mv index.html ../docroot/

echo "Compile Finished"

echo "Upload to S3"
cd ..
aws s3 cp docroot/img/ s3://${BUCKET}/img/ ${OPTION}
aws s3 cp docroot/contents/ s3://${BUCKET}/contents/ ${OPTION}
aws s3 cp docroot/style/ s3://${BUCKET}/style/ ${OPTION}
aws s3 cp docroot/index.html s3://${BUCKET}/
aws s3 cp docroot/discography.html s3://${BUCKET}/
aws s3 cp docroot/biography.html s3://${BUCKET}/

echo "Uploading Finished"

#echo "Cache Parge"
#aws cloudfront create-invalidation --distribution-id ${DISTID} --paths "/*"

echo "===================================="
echo "done"
echo "===================================="
