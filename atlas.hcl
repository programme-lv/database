env {
  name = atlas.env
  url  = getenv("DATABASE_URL")
  migration {
    dir = "atlas://proglv"
  }
}
env "local" {
  url = "postgres://proglv:proglv@:5432/proglv?search_path=public&sslmode=disable"
  migration {
    dir = "file://migrations"
  }
}