FROM python:3.8

# Instalar dependencias necesarias
RUN pip install virtualenv

# Crear y activar un entorno virtual
RUN virtualenv /venv
ENV PATH="/venv/bin:$PATH"

# Instalar Tutor y otras dependencias
RUN pip install tutor

# Clonar el repositorio de Tutor
RUN git clone --branch=nightly --depth=1 https://github.com/overhangio/tutor.git /tutor
WORKDIR /tutor
RUN chmod 777 /tutor -R
RUN pip install -e ".[full]"

# Definir el directorio de trabajo y copiar el código de la acción
WORKDIR /github/workspace
COPY . .

# Ejecutar el comando principal de la acción
CMD ["bash", "entrypoint.sh"]