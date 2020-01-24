package main

import (
	"fmt"
	"net/http"
)

func main(){
	greeting("Deploy Contínuo")

	fmt.Println(http.ListenAndServe(":8000", nil))
}

func greeting(s string){
	http.HandleFunc("/", func( w http.ResponseWriter, r *http.Request ){
		fmt.Fprintf(w, "<b>%s</b>", s)
	})
}