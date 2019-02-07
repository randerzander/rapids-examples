FROM cudf

ENV CONDA_ENV=cudf
RUN source activate ${CONDA_ENV} && conda install jupyterlab bokeh

RUN git clone https://github.com/rapidsai/dask-cudf /dask-cudf
WORKDIR /dask-cudf
RUN source activate ${CONDA_ENV} && python setup.py install

RUN git clone https://github.com/rapidsai/dask-cuda /dask-cuda
WORKDIR /dask-cuda
RUN source activate ${CONDA_ENV} && python setup.py install

ADD notebooks /notebooks
WORKDIR /notebooks
CMD source activate ${CONDA_ENV} && jupyter-lab --allow-root --ip='0.0.0.0' --NotebookApp.token=''
