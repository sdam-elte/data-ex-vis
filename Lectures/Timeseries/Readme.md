## Create conda environment for the notebooks

Normally we start with `conda init`, but in Kooplex's docker container it does not work. Insted
. /opt/conda/bin/activate
conda create -n datavis_timeseries python==3.12
conda activate datavis_timeseries 
conda install --yes --file requirements.txt
