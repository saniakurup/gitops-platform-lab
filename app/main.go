package main

  import (
        "log"
        "net/http"

        "github.com/prometheus/client_golang/prometheus"
        "github.com/prometheus/client_golang/prometheus/promauto"
        "github.com/prometheus/client_golang/prometheus/promhttp"
  )

  // A custom metric: counts requests per path. Prometheus will scrape this.
  var requestsTotal = promauto.NewCounterVec(
        prometheus.CounterOpts{
                Name: "app_http_requests_total",
                Help: "Total HTTP requests, by path.",
        },
        []string{"path"},
  )

  func hello(w http.ResponseWriter, r *http.Request) {
        requestsTotal.WithLabelValues("/").Inc()
        w.Write([]byte("Hello from gitops-platform-lab!\n"))
  }

  func healthz(w http.ResponseWriter, r *http.Request) {
        requestsTotal.WithLabelValues("/healthz").Inc()
        w.WriteHeader(http.StatusOK)
        w.Write([]byte("ok\n"))
  }

  func main() {
        http.HandleFunc("/", hello)
        http.HandleFunc("/healthz", healthz)
        http.Handle("/metrics", promhttp.Handler()) // exposes Go + custom metrics

        addr := ":8080"
        log.Printf("listening on %s", addr)
        log.Fatal(http.ListenAndServe(addr, nil))
  }
