FROM tendermint/tendermint:v0.32.9

COPY --chown=tmuser:tmuser tmhome/ /tendermint
CMD ["node"]
EXPOSE 26656/tcp 26657/tcp 26660/tcp
