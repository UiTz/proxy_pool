FROM python:3.6-alpine

MAINTAINER shitou <1043083945@qq.com>

WORKDIR /app

COPY ./requirements.txt .

# apk repository
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

# timezone
RUN apk add -U tzdata && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && apk del tzdata

# runtime environment
RUN apk add musl-dev gcc libxml2-dev libxslt-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    apk del gcc musl-dev

COPY . .

EXPOSE 5010

ENTRYPOINT [ "sh", "start.sh" ]
