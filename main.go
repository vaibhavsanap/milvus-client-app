package main

import (
    "context"
    "fmt"
    "github.com/milvus-io/milvus-sdk-go/v2/client"
)

func main() {
    ctx := context.Background()

    milvusClient, err := client.NewGrpcClient(ctx, "milvus-standalone:19530")
    if err != nil {
        panic(fmt.Sprintf("failed to connect to Milvus: %v", err))
    }
    defer milvusClient.Close()

    fmt.Println("Connected to Milvus successfully!")
}
