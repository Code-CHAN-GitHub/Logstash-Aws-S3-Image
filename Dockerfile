FROM ubuntu:20.04
RUN apt-get upgrade && apt-get update && apt-get install -y wget
RUN apt-get install -y openjdk-11-jdk
RUN apt-get install -y gnupg
RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-7.x.list
RUN apt-get update && apt-get install logstash=1:7.4.2-1 -y
RUN apt-get install jq cron less -y
RUN cd /usr/share/logstash/ \
    && for plugin in logstash-codec-cloudfront logstash-codec-cloudtrail logstash-input-cloudwatch logstash-input-s3 logstash-input-sqs logstash-output-cloudwatch logstash-output-sns logstash-output-sqs logstash-output-s3; do  /usr/share/logstash/bin/logstash-plugin remove $plugin;done \
    && /usr/share/logstash/bin/logstash-plugin install logstash-integration-aws
