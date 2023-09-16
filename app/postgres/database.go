package postgres

import (
	"embed"

	"github.com/paganotoni/jumpkit/app/config"
	"github.com/paganotoni/jumpkit/core/db"

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
