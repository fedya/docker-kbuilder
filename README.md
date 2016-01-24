## Quickstart

Create image:

```bash
docker build --tag=eewiki/builder --file $HOME/docker-kbuilder/Dockerfile .
```

## Remove stopped containers
```bash
docker rm -v $(docker ps -a -q -f status=exited)
```

## Run kernel builder
```bash
docker run -ti --rm -v /tmp/:/tmp/deploy -e KERNEL_VER="v4.4.x" eewiki/builder
```

Where is KERNEL_VER could be kernel version from 
- https://github.com/RobertCNelson/armv7-multiplatform
- https://eewiki.net/display/linuxonarm/Wandboard#Wandboard-LinuxKernel

## Results
When kernel build is done you can find results in

```bash
/tmp/deploy
```


