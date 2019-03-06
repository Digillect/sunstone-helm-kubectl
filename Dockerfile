ARG SUNSTONE_VERSION=0.3.1
ARG HELM_VERSION=2.13.0
ARG KUBECTL_VERSION=1.13.4

FROM digillect/sunstone:${SUNSTONE_VERSION}

ARG SUNSTONE_VERSION
ARG HELM_VERSION
ARG KUBECTL_VERSION

RUN set -ex; \
    apk add -U openssl curl tar gzip

RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://raw.githubusercontent.com/sgerrand/alpine-pkg-glibc/master/sgerrand.rsa.pub; \
    wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.23-r3/glibc-2.23-r3.apk
	
RUN apk add glibc-2.23-r3.apk; \
    rm glibc-2.23-r3.apk

RUN curl https://kubernetes-helm.storage.googleapis.com/helm-v${HELM_VERSION}-linux-amd64.tar.gz | tar zx; \
    mv linux-amd64/helm /usr/bin/; \
	mv linux-amd64/tiller /usr/bin/; \
    /usr/bin/helm init --client-only

RUN curl -L -o /usr/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl; \
    chmod +x /usr/bin/kubectl

WORKDIR /data

CMD /bin/sh
