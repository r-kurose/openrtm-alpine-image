FROM kuroseaist/omniorb-alpine:latest as omniorb
FROM alpine:3.10

# install omniORB
COPY --from=omniorb /opt/omniorb /usr/local

RUN apk add --no-cache\
 g++\
 ninja\
 cmake\
 util-linux-dev\
 python3-dev\
 && ln -s /usr/bin/python3 /usr/bin/python
# util-linux-dev for libuuid.so and uuid.h

RUN wget -O - 'https://github.com/OpenRTM/OpenRTM-aist/archive/master.zip'\
 | unzip -
RUN cmake -G Ninja -S /OpenRTM-aist-master -B /tmp/build\
 -DCMAKE_BUILD_TYPE=Release\
 -DCMAKE_INSTALL_LIBDIR=lib\
 -DCMAKE_INSTALL_PREFIX=/opt/openrtm
RUN cmake --build /tmp/build -j --target install/strip
