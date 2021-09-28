FROM centos:8
MAINTAINER xm0625

RUN yum install -y cronie \
                       which \
                       wget \
                       net-tools \
                       procps \
    # 用完包管理器后安排打扫卫生可以显著的减少镜像大小
    && yum clean all \
    && mkdir -p /var/spool/cron \
    && mkdir -p /work \
    && echo '*/1 * * * * echo "hello world"' > /var/spool/cron/root \
    && chmod 600 /var/spool/cron/root \
    && rm -rf /tmp/* /var/tmp/*

# 安装nodejs 14 lts
RUN cd /tmp \
    && wget "https://nodejs.org/dist/v14.17.6/node-v14.17.6-linux-x64.tar.xz" \
    && mkdir -p /usr/local/lib/nodejs \
    && tar -xJvf node-v14.17.6-linux-x64.tar.xz -C /usr/local/lib/nodejs \
    && echo 'PATH=/usr/local/lib/nodejs/node-v14.17.6-linux-x64/bin:$PATH' >> /root/.bashrc \
    && rm -rf /tmp/* /var/tmp/*

ADD cron_root.txt /
ADD CronRootSync.sh /
ADD run.sh /

RUN chmod 777 /*.*

WORKDIR /
CMD /run.sh