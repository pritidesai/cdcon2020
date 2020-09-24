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
    t := time.Now()
    fmt.Fprintf(w, "\n\nHello, %s!", r.URL.Path[1:])
    fmt.Fprintln(w,"\n\n\nLocal time: ", t.Format(time.UnixDate))
    fmt.Fprintln(w, "\n\nThis is an app running as part of Tekton Demo for 04-build-test-deploy-cleanup :-)")
}

