# Assignment: Timeseries analyisis and visualization

## Use existing virtual environment for the notebooks
There is an already installed uv environment for this topic.
In order to use it in Jupyter Notebook/Lab, you need to add it as a kernel. To do this, run the following command:
```# activate the environment
source /v/courses/2026-dataexplorationandvisualization2026.public/uv_envs/<name_of_the_env>/bin/activate
# install the kernel
python -m ipykernel install --user --name=<name_of_the_env> --display-name "Python (<name_of_the_env>)"
```
After running the above command, you should see the new kernel option "Python (<name_of_the_env>)" when you create a new notebook in Jupyter Notebook/Lab. You can select this kernel to use the virtual environment for your image exploration tasks.
You might have to reload the page first to see the new kernel option.


## Create virtual environment with `uv`
Create an environment first:
```
uv venv
```
Then install the required packages using a 'requirements.txt' file:
```
uv pip install -r requirements.txt
``` 

You need to have the 'ipykernel' package installed, which is included in the 'requirements.txt' file. This package allows you to use the virtual environment as a kernel in Jupyter Notebook.
To add the virtual environment as a kernel in Jupyter Notebook/Lab, run the following command:
```
# activate the environment
source .venv/bin/activate
# install the kernel
python -m ipykernel install --user --name=dataexp_networks --display-name "Python (dataexp_networks)"
```
After running the above command, you should see the new kernel option "Python (dataexp_networks)" when you create a new notebook in Jupyter Notebook/Lab. You can select this kernel to use the virtual environment for your image exploration tasks.
You might have to reload the page first to see the new kernel option.

## Create `conda` environment for the notebooks

```bash
conda env create -f environment.yml -n dataexp_networks
```
Refreshing the notebooks page should be enough to see the new kernel option "Python (dataexp_networks)". You can select this kernel to use the conda environment for your image exploration tasks.

If you use the environment in the terminal you will need to activate it first:
```bash
. /opt/conda/bin/activate
conda activate dataexp_networks
```

If the above installation method doesn't work:
```bash
. /opt/conda/bin/activate
conda create -n dataexp_networks python==3.12
conda activate dataexp_networks
conda install --yes --file requirements.txt
```
