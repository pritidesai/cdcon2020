package main

import (
    "fmt"
    "net/http"
    "time"
)

func main() {
    http.HandleFunc("/", HelloServer)
    http.ListenAndServe(":8080", nil)
}

func HelloServer(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintln(w, "Its ", time.Now())
    fmt.Fprintf(w, "Hello, %s!", r.URL.Path[1:])
}

