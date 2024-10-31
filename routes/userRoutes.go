package routes

import (
	"backend/repository"
	"context"

	"github.com/gofiber/fiber/v2"
)

func SetupUserRoutes(ctx context.Context, app fiber.Router, repository *repository.Queries) {
	app.Get("/", func(c *fiber.Ctx) error {
		// Implement your logic to get all users here
		return c.JSON(fiber.Map{"message": "User list endpoint"})
	})

	app.Get("/:id", func(c *fiber.Ctx) error {
		userID := c.Params("id")
		// Implement logic to get a specific user here
		return c.JSON(fiber.Map{"message": "User detail for ID: " + userID})
	})
}
