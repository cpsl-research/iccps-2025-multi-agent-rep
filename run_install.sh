#!/usr/bin/env bash

set -e

SECONDS=0

DATAD="/data/test-iccps/data"
MODELD="/data/test-iccps/models"

# download carla aerial dataset
# NOTE: our data server is not cooperating, so we will use a google drive download instead
# bash ../submodules/lib-avstack-api/data/download_CARLA_datasets.sh multi-agent-aerial-dense
# (uncomment this to run in script)
# bash ./download_data_gdown.sh

# download the mmcv wheel (only needed for building dockerfile/install poetry env)
wget -P packages https://g-b0ef78.1d0d8d.03c0.data.globus.org/packages/mmcv/torch1.13.1_cu11.7/mmcv-2.0.1-cp310-cp310-linux_x86_64.whl

# download camera-based perception models
bash download_models.sh $MODELD

# check time elapsed
duration=$SECONDS
echo -e "\n\n$(($duration / 60)) minutes and $(($duration % 60)) seconds to set everything up.\n\n"

# Add symbolic links to data here
ln -sfnT "${DATAD}/multi-agent-aerial-dense" "./data/multi-agent-aerial-dense"

# start the docker container after downloads are complete
bash run_docker.sh $DATAD $MODELD

exit 0