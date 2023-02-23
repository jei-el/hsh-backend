FROM golang:1.20.1-alpine3.17 AS build

WORKDIR /app

COPY ./ ./

RUN go build -o ./server ./src/cmd/http/main.go

FROM scratch

WORKDIR /app

COPY --from=build /app/envs ./envs
COPY --from=build /app/server ./server

EXPOSE 8081

ENTRYPOINT [ "./server" ]
