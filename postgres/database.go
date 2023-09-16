package postgres

import (
	"embed"

	"paganotoni/jumpkit/config"
	"paganotoni/jumpkit/internal/db"

	_ "github.com/lib/pq"
)

var (
	//go:embed migrations/*.sql
	Migrations embed.FS

	//Connection is the database connection builder function
	//that will be used by the application based on the driver and
	//connection string.
	Connection = db.ConnectionFn(config.DatabaseURL)
)
