CREATE TABLE agents (
  id            TEXT PRIMARY KEY,
  nostr_pubkey  TEXT NOT NULL UNIQUE,
  name          TEXT NOT NULL,
  phone         TEXT NOT NULL,
  region        TEXT NOT NULL,
  float_balance BIGINT NOT NULL DEFAULT 0,
  sats_balance  BIGINT NOT NULL DEFAULT 0,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
