#!/bin/bash

# Activar el entorno virtual
source /venv/bin/activate

# Clonar el repositorio del plugin de Edunext
git clone https://github.com/edunext/${edunext_plugin}.git /github/workspace/${edunext_plugin}
original_dir=$(pwd)
cd /github/workspace/${edunext_plugin}
git checkout ${plugin_branch_name}

# Volver al directorio original
cd ${original_dir}

# Configurar Tutor y lanzar el entorno
tutor --version
tutor config save
tutor plugins disable mfe
tutor mounts add lms,cms,lms-worker,cms-worker:/github/workspace/${edunext_plugin}:/openedx/${edunext_plugin}
chmod 777 /github/workspace -R
tutor images build openedx

# Lanzar el entorno local de Tutor
tutor local launch -I

# Ejecutar pruebas de integración

tutor local run lms bash /openedx/${edunext_plugin}/${edunext_plugin_folder}/test/tutor/integration.sh
