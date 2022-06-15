FROM registry.ng.bluemix.net/product_master/ipm-admin-ubi8:12.0.5.1

USER root

WORKDIR /home/default

RUN echo "/home/default/custom-jars/MDMJavaExtensions.jar" >> /opt/MDM/bin/conf/classpath/jars-custom.txt

RUN mkdir -p /home/default/custom-jars; \
    mkdir -p /home/default/files; \
    mkdir -p /home/default/user-scripts
COPY ./common/custom-jars/MDMJavaExtensions.jar /home/default/custom-jars/
COPY ./common/files/* /home/default/files/
COPY ./common/user-scripts/*.sh /home/default/user-scripts/

RUN chmod 755 /home/default/user-scripts/*.sh; \
    chown 5000:0 /opt/mdmlogs -R; \
    chown 5000:0 /opt/MDM -R; \
    chown 5000:0 /home/default/ -R


USER default

WORKDIR /home/default

ENTRYPOINT ["./cmd.sh"]


