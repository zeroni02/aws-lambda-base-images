FROM scratch

ADD 04100e64afe7b3aacda7253b70058af0134dfd9486c04c0d5f2f906e98d9f0d3.tar.xz /
ADD 20f33cb38bdd33a699a737da636369b3d1e27aa66a510cc221cd29af55d13294.tar.xz /
ADD 39fd7264802baa6049f19aa2c48852446309ee0d2da6b52e3b5c0fe03a18fc05.tar.xz /
ADD 7e8f318e1f5e094947750175f3ead06bcbce023d06ca000737e1a8b4cca34476.tar.xz /
ADD cb9dd55cc7fa2df284236b783084c873dd41bb98ba03014267a59f7e5cd15269.tar.xz /
ADD cec9ce2527d27d17a0cfe858b91c14d35e5101300f5d8fb40d97a0ae178ca9fc.tar.xz /

ENV LANG=en_US.UTF-8
ENV TZ=:/etc/localtime
ENV PATH=/var/lang/bin:/usr/local/bin:/usr/bin/:/bin:/opt/bin
ENV LD_LIBRARY_PATH=/var/lang/lib:/lib64:/usr/lib64:/var/runtime:/var/runtime/lib:/var/task:/var/task/lib:/opt/lib
ENV LAMBDA_TASK_ROOT=/var/task
ENV LAMBDA_RUNTIME_DIR=/var/runtime

WORKDIR /var/task

ENTRYPOINT ["/lambda-entrypoint.sh"]
