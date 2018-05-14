#!/usr/bin/env bash
ls
version=""
for LINE in `cat VERSION`
do   
    version=$LINE
done

# env = test/prod ...

image_name=192.168.1.5:5000/starter:v$version.$BUILD_NUMBER

docker build --force-rm -t $image_name . 

dangling=`docker images -f "dangling=true" -q`
echo $dangling
if [ "$dangling" != "" ]
then
docker rmi $(docker images -f "dangling=true" -q)

fi

echo 
echo image: $image_name


echo 
echo build ok!!!


docker push $image_name
echo 
echo push ok!!!

