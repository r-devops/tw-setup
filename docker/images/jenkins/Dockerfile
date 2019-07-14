FROM jenkins/jenkins:lts-alpine 
ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"
COPY security.groovy /usr/share/jenkins/ref/init.groovy.d/security.groovy
## For Seed Jobs
COPY config.xml /usr/share/jenkins/seed-job-config.xml
COPY create-seed-job.groovy /usr/share/jenkins/ref/init.groovy.d/create-seed-job.groovy
COPY authorize.groovy /usr/share/jenkins/ref/init.groovy.d/authorize.groovy
# Install plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt
## Install Tools 
USER root 
RUN wget https://releases.hashicorp.com/terraform/0.12.3/terraform_0.12.3_linux_amd64.zip 
RUN unzip terraform_0.12.3_linux_amd64.zip 
RUN mv terraform /bin && rm -f terraform_0.12.3_linux_amd64.zip 
RUN apk add ansible 
RUN apk add python ruby ruby-json
USER jenkins 
