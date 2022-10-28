#------------ o que vai rodar quando a imagem for criada (config) -------------#
FROM rocker/r-ver:4.1.1

COPY teste.R teste2.R
COPY . .

RUN Rscript -e "install.packages(c('plumber', 'AzureStor'))"

EXPOSE 8080

#---------------------o que vai rodar quando o container for criado------------#

CMD Rscript minha_api/run_api.R
