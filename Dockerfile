FROM ubuntu:14.04

# ensure UTF8
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# nginx-php installation
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get update --fix-missing
RUN apt-get install software-properties-common -y
RUN apt-get install -y nginx
RUN add-apt-repository ppa:ondrej/php
RUN apt-get update
RUN apt-get -y install php7.1
RUN apt-get -y install php7.1-fpm php7.1-common php7.1-cli php7.1-mysqlnd php7.1-mcrypt php7.1-curl php7.1-bcmath php7.1-mbstring php7.1-soap php7.1-xml php7.1-zip php7.1-json php7.1-imap php7.1-gd php7.1-sqlite3 php-xdebug

# install supervisor
RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY ./docker/supervisord/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install composer & other useful tools
RUN apt-get install curl -y && curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
RUN apt-get install htop -y && apt-get install nano -y

# Update php config
RUN service php7.1-fpm start && service php7.1-fpm stop

# Install mysql-client only
RUN apt-get install mysql-client -y

# Install git
RUN apt-get install git -y

# Move application files
COPY ./www /var/www/

# Update nginx config
COPY ./docker/nginx/change.com /etc/nginx/sites-available/change.com
RUN rm /etc/nginx/sites-available/default
RUN ln -s /etc/nginx/sites-available/change.com /etc/nginx/sites-enabled/change.com

# Define default command.
COPY ./docker/start-container /usr/local/bin/start-container
RUN chmod +x usr/local/bin/start-container

# Little shell to check the env before running supervisor jobs
COPY ./docker/supervisord/should_run_jobs.sh /var/should_run_jobs.sh
RUN chmod +x /var/should_run_jobs.sh

# Define default command.
CMD ["start-container"]

# Expose ports.
EXPOSE 80
EXPOSE 443