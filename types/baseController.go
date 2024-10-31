package types

import (
	"backend/repository"
	"context"
)

type BaseController struct {
	Ctx        context.Context
	Repository *repository.Queries
}
