FROM golang:1.17 AS builder

# Copie o código-fonte do aplicativo para o contêiner.
WORKDIR /app
COPY main.go .

# Compile o aplicativo Go e o chame de "appgo".
RUN CGO_ENABLED=0 GOOS=linux go build -o appgo main.go

# Crie uma nova imagem "scratch" para a imagem final.
FROM scratch

# Copie o binário compilado do estágio anterior para a imagem "scratch".
COPY --from=builder /app/appgo /app

# Comando para executar o aplicativo quando o contêiner for iniciado.
CMD ["/app"]