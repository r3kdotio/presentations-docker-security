
# Motivation

I am not a software security expert. I have an interest in promoting more secure environments by exploring practical weakness and their resolution.

# FOREWORD

I am a member of OWASP and comply with their [code of ethics](https://www.owasp.org/index.php/About_The_Open_Web_Application_Security_Project#Code_of_Ethics).
NEVER DO SECURITY TESTING ON SYSTEMS YOU DON'T OWN WITHOUT WRITTEN PERMISSION.

Target audience: You will need to have experience in using Docker on the command line.

# Setup

For this demonstration
Virtual box with docker registry
Virtual box with docker client and docker daemon


# Not being security conscious make you vulnerable

Consider the following scenario:
> sudo docker run -it alpine:3.7 sh

Even as a root user in the container, commands like halt and reboot have no effect on the container and container host, but there are several vulnerabilities still.

senario_haltshutdownrm.apng

## Problem:

A container running as root user can delete privileged files in the container like rm /bin/ls

## Solution:

Applications inside a docker container should run as a non-privileged user and should not be able to delete any critical files

## Problem:

A container with a volume shared with the host may allow a process in the docker container to edit files on the host.

> cat /etc/resolv.conf
> sudo docker run -v /etc/resolv.conf:/etc/resolv.conf  -it alpine:3.7 sh
> vi cat /etc/resolv.conf; # Add I was here text comment
> exit; # Exit from container
> cat /etc/resolv.conf

senario_rootisbadforhostvolumes.apng

## Solution:

Force all volumes shared with the host to be read-only. sudo docker run -v /etc/resolv.conf:/etc/resolv.conf:ro  -it alpine:3.7 sh

## Problem:

> docker build -t dockeruser2001  - < Dockerfile.dockeruser2001
> docker run -v/tmp:/tmp  dockeruser2001
> ls -l /tmp/createdbydockeruser 

senario_uuid.apng

## Solution:

Make sure UID of users in containers don't map to an unintentional user or use [Linux user namespaces](https://docs.docker.com/engine/security/userns-remap/).

## Problem:

A container that does not have any memory limits can crash the host. The source of the excessive memory usage can be a DOS attack like https://www.cvedetails.com/cve/CVE-2017-11468/: Docker Registry before 2.6.2 in Docker Distribution does not properly restrict the amount of content accepted from a user, which allows remote attackers to cause a denial of service (memory consumption) via the manifest endpoint. 

Consider the following c program that allocates all the memory available to it. Running the program in a docker container with no restrictions will cause the host machine to be unresponsive.

    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>

    int main() {
       printf("BEWARE : about to consume all memory");
       while(1==1){
          malloc( 1024*1024*1024*1024 );
       }
    }

## Solution:

Limit memory usage sudo docker run -m 200m -it alpine:3.7 sh

> docker stats

## Problem:

The Alpine container I ran as a bitcoin mining tool installed.

(Dockerfile.bit-coin-mine)

  FROM alpine:3.7
  add bit-coin-mine.sh /bin/bit-coin-mine.sh

> docker build - < Dockerfile.bit-coin-mine
> sudo docker tag ecc29a43438b  myregsitry/alpine:3.7
> docker push  myregsitry/alpine:3.7

## Solution:

The standard docker registry does not have role-based access control and auditing.

## Problem:

The standard docker registry typically has no password policies. A single user is usually shared among users and it is usually easily brute force attacked. 

> docker run \
  --entrypoint htpasswd \
  registry:2 -Bbn user1 password1 > auth/htpasswd

The standard docker registry should be replaced with Sonatype nexus, Azure Container Registry or any registry with role-based access control and auditing.




