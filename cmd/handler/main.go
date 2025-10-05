package main

import (
    "context"
    "fmt"
    "strings"

    "github.com/aws/aws-lambda-go/lambda"
)

type Request struct {
    Name string `json:"name"`
}

type Response struct {
    Message string `json:"message"`
}

func handler(ctx context.Context, req Request) (Response, error) {
    name := strings.TrimSpace(req.Name)
    if name == "" {
        name = "World"
    }
    return Response{Message: fmt.Sprintf("Hello, %s!", name)}, nil
}

func main() {
    lambda.Start(handler)
}
