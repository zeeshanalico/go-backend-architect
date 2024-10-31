package middlewares

import (
	"encoding/json"
	"fmt"

	"github.com/gofiber/fiber/v2"

	"github.com/gofiber/fiber/v2/middleware/logger"
)

func Logger() func(c *fiber.Ctx) error {
	return func(c *fiber.Ctx) error {
		logger.New()

		fmt.Println("Request:", c.Method(), c.Path())

		err := c.Next()

		// Log the response after the next handler/middleware
		fmt.Println("Response:", c.Response().StatusCode(), json.Unmarshal(c.Response().Body(), *new(interface{})), string(c.Response().Body()))

		return err
	}
}
