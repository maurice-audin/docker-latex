FROM debian:buster

# Use local apt cache
RUN apt-get update && apt-get install -y netcat \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
        && echo '#! /bin/bash\nif nc -w1 -z 192.168.42.23 3142; then echo "http://192.168.42.23:3142"; else echo "DIRECT"; fi' > /usr/local/bin/apt-proxy-checker \
        && chmod +x /usr/local/bin/apt-proxy-checker \
        && echo 'Acquire::http::ProxyAutoDetect "/usr/local/bin/apt-proxy-checker";' > /etc/apt/apt.conf.d/proxy

# LaTeX packages
RUN apt-get update && apt-get install -y \
        texlive-xetex texlive-lang-french texlive-fonts-extra texlive-science python3-pygments \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Usage: docker run --rm -v $PWD:/src registry.robespierre.lan:80/latex main.tex
WORKDIR "/src"
ENTRYPOINT ["pdflatex", "--output-directory", "build/"]
