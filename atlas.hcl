env {
  name = atlas.env
  url  = getenv("DATABASE_URL")
  migration {
    dir = "atlas://proglv"
  }
}