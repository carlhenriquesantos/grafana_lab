# Imagem base: Python 3.12 em Alpine (leve)
FROM python:3.12-alpine

# Diretório de trabalho dentro do container
WORKDIR /app

# Dependências do sistema para compilar pacotes Python
RUN apk add --no-cache \
    gcc \
    musl-dev \
    python3-dev

# Copia só o requirements antes, para aproveitar o cache de camadas
COPY requirements.txt .

# Instala as bibliotecas Python da aplicação
RUN pip install --no-cache-dir -r requirements.txt

# Copia o restante do código-fonte
COPY . .

# Cria a pasta de logs (o app.py grava em ./logs/app.log)
RUN mkdir -p /app/logs

# Porta usada pela aplicação (definida no app.py)
EXPOSE 5005

# Inicia a aplicação
CMD ["python", "app.py"]