FROM 125277160564.dkr.ecr.us-east-1.amazonaws.com/cobis/cts-cis-serverless:cobis-cloud-cis-microservice-3.0.8
USER root
RUN chmod -R 777 /opt/cobishome-cis-micro/
RUN addgroup -S appgroup && adduser --shell /sbin/nologin --disabled-password --no-create-home -S appuser -G appgroup
USER appuser
COPY target/app.jar /opt
COPY install.xml /opt
RUN ["java","-jar","/opt/app.jar","-file","/opt/install.xml"]

ENTRYPOINT ["java","-cp","/opt/cobis/jar/cobis-cloud-cis-microservice-3.0.8.jar","-Dloader.main=com.cobis.cloud.infra.cis.Application","-DCOBIS_HOME=/opt/cobishome-cis-micro","-Dloader.path=/opt/cobishome-cis-micro/ATM/plugins,/opt/cobishome-cis-micro/ATM/bls","org.springframework.boot.loader.PropertiesLauncher"]