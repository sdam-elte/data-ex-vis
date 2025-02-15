## Create conda environment for the notebooks

Normally we start with `conda init`, but in Kooplex's docker container it does not work. Instead 
```bash
. /opt/conda/bin/activate
conda create -n datavis_shapesmaps --yes --file requirements.txt
```
