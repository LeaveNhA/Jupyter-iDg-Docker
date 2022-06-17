FROM python:3.6

EXPOSE 8888

RUN pip install --no-cache-dir jupyterlab \
    && useradd -ms /bin/bash lab

USER lab

# Copy the requirements list
COPY --chown=${NB_UID}:${NB_GID} requirements.txt /tmp/

RUN /usr/local/bin/python -m pip install --upgrade pip

RUN pip install --quiet --no-cache-dir --requirement /tmp/requirements.txt

RUN cd /tmp/ && \
    git clone https://github.com/LeaveNhA/idg idg-source-91724987 && \
    cd idg-source-91724987 && \
    jupyter kernelspec install --user idg

WORKDIR /home/lab

CMD PYTHONPATH='/home/lab/.local/share/jupyter/kernels/:' jupyter notebook --ip=0.0.0.0
