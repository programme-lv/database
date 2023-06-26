CREATE TABLE tags
(
    id         TEXT PRIMARY KEY,
    created_at TIMESTAMP WITH TIME ZONE,
    updated_at TIMESTAMP WITH TIME ZONE,
    color_rgb_hex      TEXT -- #RRGGBB
        CHECK (color_rgb_hex ~* '^#[0-9a-f]{6}$'),
    description_lv     TEXT
);