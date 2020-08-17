FROM debian:buster

RUN apt-get update && apt-get install -y \
        texlive-xetex texlive-lang-french texlive-fonts-extra texlive-science python3-pygments \
        && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR "/src"
ENTRYPOINT ["pdflatex", "--output-directory", "build/"]
