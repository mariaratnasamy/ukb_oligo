#!/bin/bash

chr_num=$1
notebook_path="exome_annot/annot_run/notebooks/chr${chr_num}/MT.ipynb"

echo Creating MT for $chr_num

source /opt/anaconda/bin/activate /data6/deepro/miniconda3/envs/dnanexus
dx login --token {your-token}

my_cmd="papermill MT.ipynb MT_out.ipynb"

dx run dxjupyterlab_spark_cluster \
    -ifeature="HAIL" \
    -icmd="$my_cmd" \
    -iin="${notebook_path}" \
    --destination "exome_annot/annot_run/notebooks/chr${chr_num}" \
    --instance-type "mem2_ssd1_v2_x48" -y
