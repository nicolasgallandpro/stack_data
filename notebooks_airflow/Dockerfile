FROM pre_notebooks_airflow

RUN apt install python-is-python3
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]