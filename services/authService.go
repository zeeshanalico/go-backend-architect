package services

import (
	"backend/repository" // Import the repository package directly
	"backend/types"
	"context"
)

type AuthService struct {
	users      map[string]string
	repository *repository.Queries
	ctx        context.Context
}

func NewAuthService(b types.BaseController) *AuthService {
	return &AuthService{
		repository: b.Repository,
		ctx:        b.Ctx,
	}
}

func (s *AuthService) Login(username, password string) (bool, interface{}, error) { //'s' means 'this' that is refering to AuthService here

	// user, err := s.repository.GetinternalUsers(s.ctx)
	// if !user {
	// 	return false, nil
	// }

	// err := bcrypt.CompareHashAndPassword([]byte(storedPassword), []byte(password))
	// return err == nil, err
	result := map[string]string{
		"username": username,
		"password": password, // Normally, you wouldn't return the password like this
	}

	// Returning true for success, the result as interface{}, and nil for no error
	return true, result, nil
}

// func (s *AuthService) Register(username, password string) error {
// 	if _, exists := s.users[username]; exists {
// 		return errors.New("username already exists")
// 	}

// 	// Hash the password
// 	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(password), bcrypt.DefaultCost)
// 	if err != nil {
// 		return err
// 	}

// 	// Store the user
// 	s.users[username] = string(hashedPassword)
// 	return nil
// }
