FROM jenkins/jenkins:2.167-alpine

ENV JAVA_OPTS="-Djenkins.install.runSetupWizard=false"

COPY plugins.txt /tmp/plugins.txt

COPY --chown=jenkins:root admin.groovy /usr/share/jenkins/ref/init.groovy.d/admin.groovy
COPY --chown=jenkins:jenkins ./dsl_builder.xml /var/jenkins_home/jobs/dsl_builder/config.xml

RUN /usr/local/bin/install-plugins.sh plugins.txt

USER jenkins

