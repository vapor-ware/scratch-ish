package main

import (
	"fmt"
	"os"
)

func main() {
	if len(os.Args[1:]) != 1 {
		fmt.Println("error: no path provided")
		os.Exit(1)
	}

	if _, err := os.Stat(os.Args[1]); err != nil {
		fmt.Printf("error: %s\n", err)
		os.Exit(1)
	}
}
