ARG PHP_VERSION

FROM httpd:2.4
LABEL maintainer="Frank Lemanschik <frank@dspeed.eu>"

# Install TYPO3
ARG TYPO3_VERSION
WORKDIR /var/www/
RUN apt-get -y update \
 && apt-get -y upgrade \
 && apt-get -y install wget curl \
 && wget -O - https://get.typo3.org/$TYPO3_VERSION | tar -xzf - \
 && ln -s typo3_src-* typo3_src \
 && touch FIRST_INSTALL \
 && chown -R www-data .
WORKDIR /var/www/html
RUN ln -s ../typo3_src && \
    ln -s typo3_src/index.php && \
    ln -s typo3_src/typo3 && \
    ln -s typo3_src/_.htaccess .htaccess && \
    mkdir typo3temp && \
    mkdir typo3conf && \
    mkdir fileadmin && \
    mkdir uploads && \
    touch FIRST_INSTALL && \
    chown -R www-data .

# Configure volumes
# VOLUME /var/www/html/fileadmin
# VOLUME /var/www/html/typo3conf
# VOLUME /var/www/html/typo3temp
# VOLUME /var/www/html/uploads
VOLUME /var/www/html
