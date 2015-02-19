FROM ubuntu:trusty
RUN apt-get update && apt-get install -y ruby-dev wget build-essential && wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb && dpkg -i puppetlabs-release-trusty.deb && rm puppetlabs-release-trusty.deb && apt-get update && apt-get install -y puppet nginx supervisor
RUN /usr/bin/gem install unicorn rack && mkdir /etc/puppetmaster
RUN mkdir /var/lib/puppetmaster
ADD nginx.conf /etc/nginx/nginx.conf
ADD unicorn.conf /etc/puppetmaster/unicorn.conf
ADD puppet.conf /etc/puppetmaster/puppet.conf
ADD auth.conf /etc/puppetmaster/auth.conf
ADD fileserver.conf /etc/puppetmaster/fileserver.conf
ADD https://raw.githubusercontent.com/puppetlabs/puppet/master/ext/rack/config.ru /var/lib/puppetmaster/config.ru
ADD run.sh /run.sh
ADD supervisord-unicorn.conf /etc/supervisor/conf.d/unicorn.conf
ADD supervisord-nginx.conf /etc/supervisor/conf.d/nginx.conf
ADD supervisord.conf /etc/supervisor/supervisord.conf
RUN chmod 755 /*.sh && chown -R puppet: /var/log/supervisor
RUN mkdir /var/run/supervisor && chown puppet: /var/run/supervisor /var/log/nginx
RUN touch /var/run/supervisord.pid && chown puppet: /var/run/supervisord.pid /var/lib/puppet /var/lib/puppetmaster /var/lib/nginx && chmod 644 /var/lib/puppetmaster/config.ru
USER puppet
ENTRYPOINT ["/run.sh"]
CMD ["run"]
EXPOSE 8140

