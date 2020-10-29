# go-streamnet
StreamNet implemented in Golang.

## Modules

* config: parsing the configuration file.
* dag: the dag structure and methods.
* streamwork:  the algorithm to 'drag' DAG to chain.
* tipselection: selecting two tips from dag.
* server: the http server.
* store: the storage module.
* forward: the genesis forward module.
* network: the network module, for broadcasting and synchronization.
* docs: documents.
* examples: all the tests and examples.
* types: all the common types.
* utils: all common libs.
* commands: parsing all subcommands.


## Install
### From Binary
(not supported yet)

### From Source

#### prerequisite 

* Golang version >= v1.14.2, [installed](https://golang.org/doc/install) 

#### Ubuntu
You'll need  [[gorocksdb]](https://github.com/triasteam/go-streamnet/blob/master/docs/software/gorocksdb%20%E5%AE%89%E8%A3%85.md) installed first.

##### Get Source Code

```bash
mkdir -p $GOPATH/src/github.com/triasteam
cd $GOPATH/src/github.com/triasteam
git clone https://github.com/triasteam/go-streamnet.git
cd go-streamnet
```

##### Compile

```bash
make install
```

to put the binary in `$GOPATH/bin` or use:

```bash
make build
```

to put the binary in `./build`.

#### MacOS

##### dependencies
- RocksDb
  ```
  $ brew install rocksdb
  ```

##### Get Source Code

```bash
mkdir -p $GOPATH/src/github.com/triasteam
cd $GOPATH/src/github.com/triasteam
git clone https://github.com/triasteam/go-streamnet.git
cd go-streamnet
```

##### Compile

```bash
make install
```

to put the binary in `$GOPATH/bin` or use:

```bash
make build
```

to put the binary in `./build`.

__The binary's name is '**gsn**', which is standing for Go-StreamNet.__

## Run
```bash
./build/gsn
```
***Note***:
    Now you should start another terminal to input commands, or you can start the binary background with '&'.

## Client save & get
### save
```bash
curl -X POST -d '{"Attester": "192.168.1.1", "Attestee": "192.168.1.2", "Score": "1"}' http://127.0.0.1:14700/save
```

### get
```
curl -X POST -d '{"key": "0xXXXXXXXXXXX"}' http://127.0.0.1:14700/get
```

For better display, you can use `jq` to format the output.
