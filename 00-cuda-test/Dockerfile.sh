
apt-get update && apt-get install -y --no-install-recommends make g++
#COPY ./tmp/docker-build/samples /tmp/samples

#WORKDIR /tmp/samples/1_Utilities/deviceQuery
cd ./tmp/docker-build/samples
make clean
make
./deviceQuery
