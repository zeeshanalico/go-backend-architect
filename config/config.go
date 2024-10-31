package config

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

func EnvLoaderFactory(mode string) {
	switch mode {
	case "release":
		err := godotenv.Load(".env.production")
		if err != nil {
			log.Fatal("Error loading .env.production file")
		}
	case "debug":
		err := godotenv.Load(".env.development")
		if err != nil {
			log.Fatal("Error loading .env.development file")
		}
	default:
		log.Fatal("Invalid mode: Choose either 'release' or 'debug'")
	}
}

func GetAppMode() string {
	mode := os.Getenv("APP_MODE")
	if mode == "" {
		mode = "debug" // Default to debug if not set
	}
	return mode
}
