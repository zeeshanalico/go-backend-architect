package routes

import (
	"backend/controllers"
	"backend/repository"
	"backend/types"

	"context"

	"github.com/gofiber/fiber/v2"
)

func SetupAuthRoutes(ctx context.Context, app fiber.Router, repository *repository.Queries) {
	authController := controllers.NewAuthController(types.BaseController{Ctx: ctx, Repository: repository})

	app.Post("/login", authController.Login)
	// app.Post("/register", authController.Register)
}
