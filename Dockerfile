FROM centos:8
MAINTAINER xm0625

RUN yum install -y cronie \
                       wget \
                       net-tools \
                       procps \
    # 用完包管理器后安排打扫卫生可以显著的减少镜像大小
    && yum clean all \
    && mkdir -p /var/spool/cron \
    && mkdir -p /work \
    && echo '*/1 * * * * echo "DemoScript"' > /var/spool/cron/root \
    && rm -rf /tmp/* /var/tmp/*

# 安装nodejs 14 lts
RUN cd /tmp \
    && wget "https://nodejs.org/dist/v14.17.6/node-v14.17.6-linux-x64.tar.xz" \
    && mkdir -p /usr/local/lib/nodejs \
    && tar -xJvf node-v14.17.6-linux-x64.tar.xz -C /usr/local/lib/nodejs \
    && rm -rf /tmp/* /var/tmp/*

ENV PATH /usr/local/lib/nodejs/node-v14.17.6-linux-x64/bin:$PATH

WORKDIR /
CMD /usr/sbin/crond -n -x proc | grep log_it 
