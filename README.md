# shell-tools

![GitHub Tag](https://img.shields.io/github/v/tag/infovista-opensource/shell-tools) ![Static Badge](https://img.shields.io/badge/alpine-3.21.3-brightgreen)



Collection of tools useful for test/troubleshooting 


## Packages

| Tool | Version | Origin |
|---|---|---|
| `PostgreSQL 16 Client` | latest | Package Manager |
| `jq` | latest | Package Manager |
| `yq-go` | latest | Package Manager |
| `curl`  | latest | Package Manager |
| `bash`  | latest | Package Manager |
| `bind-tools`  | latest    | Package Manager |
| `wait-For` | 1.0.0 | [Repo](https://github.com/mrako/wait-for/releases) | 
| `kubectl` | 1.33.0 | [Release](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux) |
| `mc` | RELEASE.2025-04-16T18-13-26Z | [Release](https://dl.min.io/client/mc/release/linux-amd64/) |



## Use Cases

### PostgreSQL client ( psql )

```
$ docker run piccio/shell-tools:1.9.2 psql <psql_args> 
```

```
$ kubectl -n empirix-cloud run foo --image=piccio/shell-tools:1.9.2 -it --rm --command -- /bin/bash
foo:/# psql -h nla-postgres-ha-psqlha-pgpool.empirix-cloud.svc -p 5432 -U postgres
Password for user postgres: 
psql (16.6, server 16.3)
Type "help" for help.

postgres=# \l
                                                       List of databases
   Name    |  Owner   | Encoding | Locale Provider |   Collate   |    Ctype    | ICU Locale | ICU Rules |   Access privileges   
-----------+----------+----------+-----------------+-------------+-------------+------------+-----------+-----------------------
 postgres  | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | 
 repmgr    | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | 
 template0 | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |             |             |            |           | postgres=CTc/postgres
 template1 | postgres | UTF8     | libc            | en_US.UTF-8 | en_US.UTF-8 |            |           | =c/postgres          +
           |          |          |                 |             |             |            |           | postgres=CTc/postgres
(4 rows)

postgres=# \q
foo:/# exit
exit
Session ended, resume using 'kubectl attach foo -c foo -i -t' command when the pod is running
pod "foo" deleted
```

### MinIO client ( mc )


```
$ docker run piccio/shell-tools:1.9.2 mc <mc_args> 
```


### Command line


```
$ docker run -it piccio/shell-tools:1.9.2 /bin/bash
82915c2289a3:/# ls -l /
total 56
drwxr-xr-x    1 root     root          4096 Feb  9 18:19 bin
drwxr-xr-x    5 root     root           360 Feb 13 23:34 dev
drwxr-xr-x    1 root     root          4096 Feb 13 23:34 etc
drwxr-xr-x    2 root     root          4096 Jan  8 11:04 home
drwxr-xr-x    1 root     root          4096 Jan  8 11:04 lib
drwxr-xr-x    5 root     root          4096 Jan  8 11:04 media
drwxr-xr-x    2 root     root          4096 Jan  8 11:04 mnt
drwxr-xr-x    2 root     root          4096 Jan  8 11:04 opt
dr-xr-xr-x  599 root     root             0 Feb 13 23:34 proc
drwx------    2 root     root          4096 Jan  8 11:04 root
drwxr-xr-x    3 root     root          4096 Jan  8 11:04 run
drwxr-xr-x    2 root     root          4096 Jan  8 11:04 sbin
drwxr-xr-x    2 root     root          4096 Jan  8 11:04 srv
dr-xr-xr-x   13 root     root             0 Feb 13 23:34 sys
drwxrwxrwt    2 root     root          4096 Jan  8 11:04 tmp
drwxr-xr-x    1 root     root          4096 Feb  9 18:19 usr
drwxr-xr-x   11 root     root          4096 Jan  8 11:04 var 
```
