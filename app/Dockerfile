# ---- build stage: full Go toolchain ----
  FROM golang:1.26 AS build
  WORKDIR /src
  COPY go.mod go.sum ./
  RUN go mod download
  COPY . .
  RUN CGO_ENABLED=0 GOOS=linux go build -o /app .

  # ---- final stage: minimal, no shell, non-root ----
  FROM gcr.io/distroless/static-debian12:nonroot
  COPY --from=build /app /app
  EXPOSE 8080
  USER nonroot:nonroot
  ENTRYPOINT ["/app"]
