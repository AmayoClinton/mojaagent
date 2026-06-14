CREATE TABLE swaps (
  id                TEXT PRIMARY KEY,
  agent_id          TEXT NOT NULL REFERENCES agents(id),
  counterparty_key  TEXT NOT NULL,
  direction         TEXT NOT NULL CHECK (direction IN ('buy_float','sell_float')),
  amount_kes        BIGINT NOT NULL,
  amount_sats       BIGINT NOT NULL,
  rate_kes          BIGINT NOT NULL,
  status            TEXT NOT NULL DEFAULT 'pending',
  nostr_event_id    TEXT,
  lightning_invoice TEXT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at        TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX idx_swaps_agent_id ON swaps(agent_id);
