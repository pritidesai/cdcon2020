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
    location, err := time.LoadLocation("PST")
    if err != nil {
        fmt.Println(err)
    }
    fmt.Fprintf(w, "Hello, %s!", r.URL.Path[1:])
    fmt.Fprintln(w,"It's ", t.In(location), " in my world.")
    fmt.Fprintln(w,"How about you?")
}

