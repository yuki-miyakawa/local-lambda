package main

import (
	"context"

	"github.com/aws/aws-lambda-go/lambda"
)

type Request struct {
	Name   string `json:"name"`
	Age    int    `json:"age"`
	Job    string `json:"job"`
	Gender string `json:"gender"`
}

type Response struct {
	Name   string `json:"name"`
	Age    int    `json:"age"`
	Job    string `json:"job"`
	Gender string `json:"gender"`
}

func handler(ctx context.Context, req Request) (Response, error) {
	res := Response(req)
	return res, nil
}

func main() {
	lambda.Start(handler)
}
