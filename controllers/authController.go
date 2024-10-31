package controllers

import (
	"backend/services"
	"backend/types"

	"github.com/gofiber/fiber/v2"
)

type AuthController struct {
	AuthService    *services.AuthService
	BaseController types.BaseController
}

func NewAuthController(b types.BaseController) *AuthController {
	authService := services.NewAuthService(types.BaseController{Ctx: b.Ctx, Repository: b.Repository})
	return &AuthController{
		BaseController: b,
		AuthService:    authService,
	}
}

func (ac *AuthController) Login(c *fiber.Ctx) error {
	var body struct {
		Username string `json:"username"`
		Password string `json:"password"`
	}

	// if err := c.BodyParser(&body); err != nil {
	// 	return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
	// }

	isValid, result, err := ac.AuthService.Login(body.Username, body.Password)
	if err != nil {
		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Internal server error"})
	}

	if !isValid {
		return c.Status(fiber.StatusUnauthorized).JSON(fiber.Map{"error": "Invalid username or password"})
	}

	return c.Status(fiber.StatusOK).JSON(fiber.Map{"message": "Login successful", "result": result})
}

// func (ac *AuthController) Register(c *fiber.Ctx) error {
// 	var body struct {
// 		Username string `json:"username"`
// 		Password string `json:"password"`
// 	}

// 	if err := c.BodyParser(&body); err != nil {
// 		return c.Status(fiber.StatusBadRequest).JSON(fiber.Map{"error": "Invalid request"})
// 	}

// 	err := ac.AuthService.Register(body.Username, body.Password)
// 	if err != nil {
// 		if err.Error() == "username already exists" {
// 			return c.Status(fiber.StatusConflict).JSON(fiber.Map{"error": "Username already exists"})
// 		}
// 		return c.Status(fiber.StatusInternalServerError).JSON(fiber.Map{"error": "Internal server error"})
// 	}

// 	return c.Status(fiber.StatusCreated).JSON(fiber.Map{"message": "User registered successfully"})
// }
