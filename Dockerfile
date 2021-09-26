FROM node:14.17.6-buster
MAINTAINER xm0625

RUN apt-get update && \
    apt-get install -y cronie \
                       wget \
                       net-tools \
                       procps \
    # 用完包管理器后安排打扫卫生可以显著的减少镜像大小
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && mkdir -p /var/spool/cron
    && mkdir -p /work

cat > /var/spool/cron/root <<EOF
*/1 * * * * echo "DemoScript:`date`"
EOF


WORKDIR /
CMD /usr/sbin/crond -n -x proc | grep log_it 