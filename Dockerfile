
FROM apache/airflow:2.6.3

USER root
RUN echo "Asia/Seoul" > /etc/timezone
RUN ln -sf /usr/share/zoneinfo/Asia/Seoul /etc/localtime
COPY requirements.txt /requirements.txt
RUN echo "airflow ALL=(ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
RUN echo "default ALL=(ALL:ALL) NOPASSWD: ALL" | tee -a /etc/sudoers
RUN echo "root:root" | chpasswd
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    unixodbc \
    unixodbc-dev \
    gcc \
    g++ \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* 
RUN apt-get install -y curl     
RUN curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
RUN curl https://packages.microsoft.com/config/debian/11/prod.list > /etc/apt/sources.list.d/mssql-release.list \
    && exit
RUN apt-get update \
    && ACCEPT_EULA=Y apt-get install -y msodbcsql17 \
    && ACCEPT_EULA=Y apt-get install -y mssql-tools \ 
    && echo 'export PATH="$PATH:/opt/mssql-tools/bin"' >> ~/.bashrc \
    && source ~/.bashrc \
    && apt-get install -y unixodbc-dev \
    && apt-get install -y libgssapi-krb5-2
USER airflow
RUN python -m pip install --upgrade pip
RUN python -m pip install wheel
RUN python -m pip install -r /requirements.txt

