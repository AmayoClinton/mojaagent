CREATE TABLE disputes (
  id             TEXT PRIMARY KEY,
  swap_id        TEXT NOT NULL REFERENCES swaps(id),
  agent_id       TEXT NOT NULL REFERENCES agents(id),
  description    TEXT NOT NULL,
  media_url      TEXT,
  nostr_event_id TEXT,
  created_at     TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
