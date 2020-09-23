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
    fmt.Fprintf(w, "Hello, %s!", r.URL.Path[1:])
    fmt.Fprintln(w,"\nIt's ", t.Format(time.UnixDate), " in my world.")
    fmt.Fprintln(w,"How about you?")
}

