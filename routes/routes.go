package routes

import (
	m "backend/middlewares"
	"backend/repository"
	"context"

	"github.com/gofiber/fiber/v2"
)

func SetupRoutes(ctx context.Context, app *fiber.App, repository *repository.Queries) {
	// Create a new group for API routes
	api := app.Group("/api", m.Logger())

	// Create subgroups for different route categories
	auth := api.Group("/auth")
	user := api.Group("/user")

	// Setup the routes for authentication and user handling
	SetupAuthRoutes(ctx, auth, repository)
	SetupUserRoutes(ctx, user, repository) // Assuming you have this defined
}
