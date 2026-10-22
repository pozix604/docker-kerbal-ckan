FROM debian

# ckan mono missing one dependency
# https://github.com/KSP-CKAN/CKAN/issues/4600#issuecomment-4461671609

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl ca-certificates \
 && curl -sS -o /usr/share/keyrings/ksp-ckan-archive-keyring.gpg https://raw.githubusercontent.com/KSP-CKAN/CKAN/master/debian/ksp-ckan.gpg \
 && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/ksp-ckan-archive-keyring.gpg] https://ksp-ckan.s3-us-west-2.amazonaws.com/deb stable main' > /etc/apt/sources.list.d/ksp-ckan.list \
 && apt-get update \
 && apt-get install -y libmono-system-componentmodel-composition4.0-cil ckan \
 && mkdir -p /app \
 && rm -rf /var/lib/apt/lists/*

COPY --chmod=755 entrypoint.sh /app/entrypoint.sh
ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["bash"]
