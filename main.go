package main

import (
	"backend/config"
	"backend/connection"
	"backend/repository"
	"backend/routes"
	"log"

	"github.com/gofiber/fiber/v2"
)

func main() {
	// Environment loading
	appMode := config.GetAppMode()
	config.EnvLoaderFactory(appMode)

	app := fiber.New()

	// Set log level based on environment
	if appMode == "release" {
		log.SetFlags(log.LstdFlags | log.Lshortfile) // Optional: Adjust logging for production
	} else {
		log.SetFlags(log.LstdFlags | log.Lshortfile) // Optional: Debug logging
	}

	// Database connection
	ctx, conn, err := connection.PgConnection()
	if err != nil {
		log.Fatalf("Failed to connect to the database: %v", err)
	}
	q := repository.New(conn)

	// Setup routes
	routes.SetupRoutes(ctx, app, q)

	if err := app.Listen(":8080"); err != nil {
		log.Fatalf("Error starting server: %v", err)
	}
}
