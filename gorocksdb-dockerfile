FROM golang:1.9

# update
RUN apt-get update -y

#
# based on Rocksdb install.md:
#

RUN apt-get install -y build-essential checkinstall

# Install gflags
RUN apt-get install -y libgflags-dev

# Install snappy
RUN apt-get install -y libsnappy-dev

# Install zlib
RUN apt-get install -y zlib1g-dev

# Install bzip2
RUN apt-get install -y libbz2-dev

# Clone rocksdb
RUN cd /tmp && git clone https://github.com/facebook/rocksdb.git && cd rocksdb && git checkout v5.12.4 && make clean && make install
