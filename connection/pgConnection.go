package connection

import (
	"context"

	"github.com/jackc/pgx/v5"
)

func PgConnection() (context.Context, *pgx.Conn, error) {
	ctx := context.Background()
	conn, err := pgx.Connect(ctx, "user=postgres password=admin dbname=cis sslmode=disable host=localhost port=5432")

	if err != nil {
		return nil, nil, err
	}
	// defer conn.Close(ctx)
	return ctx, conn, nil
}
