FROM varunkaushish/sfdx-12102018
RUN mkdir /etc/sfdx
ADD builder.sh /etc/sfdx
ADD build/server.key /etc/sfdx
COPY . /etc/sfdx
RUN chmod +x /etc/sfdx/builder.sh
WORKDIR /etc/sfdx
#ENTRYPOINT ["./builder.sh"]