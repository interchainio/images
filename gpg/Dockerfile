FROM alpine:3.9 AS build

ENV STOML_VERSION=0.3.0
ENV PINENTRY_VERSION=1.1.0

RUN apk update && apk upgrade && apk add make ncurses-dev libcap-dev gtk+-dev libgpg-error-dev libassuan-dev gcc g++ libsecret-dev && \
    wget ftp://ftp.gnupg.org/gcrypt/pinentry/pinentry-${PINENTRY_VERSION}.tar.bz2 && \
    echo "5012672925bcb5f683358c259e55e4b87c67cf063ad52c759308933733025c33f7ce08e5b8019ffc101cbf7ef30499040ef2fd34a7611698e65e1593f80948cd  /pinentry-${PINENTRY_VERSION}.tar.bz2" > pinentry-sha && \
    sha512sum -c pinentry-sha && \
    tar -xjf pinentry-${PINENTRY_VERSION}.tar.bz2 && \
    cd pinentry-${PINENTRY_VERSION} && \
    ./configure --prefix=/usr --disable-pinentry-gtk2 --disable-pinentry-qt --disable-pinentry-curses --disable-fallback-curses \
      --disable-pinentry-curses --disable-pinentry-emacs --disable-inside-emacs \
      --enable-pinentry-tty --enable-libsecret --enable-maintainer-mode && \
    make && \
    cp /pinentry-${PINENTRY_VERSION}/tty/pinentry-tty /pinentry-tty

RUN wget https://github.com/freshautomations/stoml/releases/download/v${STOML_VERSION}/stoml_linux_amd64 && chmod +x stoml_linux_amd64


FROM alpine:3.9

COPY --from=build --chown=root:root /stoml_linux_amd64 /usr/bin/stoml
COPY --from=build --chown=root:root /pinentry-tty /usr/bin/pinentry-tty
COPY --chown=root:root ./gpg-import /usr/bin/gpg-import
COPY --chown=root:root ./gpg-cache-passphrase /usr/bin/gpg-cache-passphrase
RUN adduser -h /home/circleci -s /bin/bash -D -u 3434 circleci && apk update && apk upgrade && apk add git openssh tar ca-certificates curl wget bash gnupg libsecret expect && rm -rf /usr/bin/pinentry && ln -sf /usr/bin/pinentry-tty /usr/bin/pinentry && chmod +x /usr/bin/gpg-import /usr/bin/gpg-cache-passphrase

USER circleci:circleci
SHELL ["/bin/bash", "-c"]
WORKDIR /home/circleci

