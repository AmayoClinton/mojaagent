# MojaAgent

**Bitcoin float management for M-Pesa agents**

M-Pesa agents are small business operators who provide cash-in and cash-out services for Safaricom's mobile money platform. Their core operational problem is float management: they need liquid KES balance in their M-Pesa till at all times. When float runs low, agents cannot serve customers. Rebalancing today requires physical travel to a super-agent or bank — costly in time and lost revenue.

MojaAgent solves this by letting agents swap Bitcoin/Lightning sats for M-Pesa float using the **Pontmore** protocol — a Nostr-native coordination layer for Bitcoin-fiat swaps. Agents never need to understand Bitcoin. The UI speaks in KES, float balance, and swap cost. Bitcoin infrastructure is invisible plumbing.

## Solution

- **PWA** — mobile-first installable web app for smartphone agents
- **USSD (*384#)** — Africa's Talking menu for basic phones and poor connectivity
- **Pontmore/Nostr** — discover swap counterparty agents, coordinate swap lifecycle
- **Lightning (LND)** — instant Bitcoin settlement
- **Daraja 3.0** — M-Pesa float balance and payments (or Pesa Playground locally)

## Architecture

```
Agent phone (PWA) ──→ Go API ──→ PostgreSQL
Agent dumbphone (USSD *384#) ──→ Africa's Talking ──→ Go API
Go API ──→ Pontmore/Nostr relays ──→ swap counterparty
Go API ──→ LND ──→ Lightning Network
Go API ──→ Daraja 3.0 / Pesa Playground ──→ M-Pesa
```

## Quick Start

```bash
# Backend (mock mode, no credentials needed)
export MOCK_MODE=true
docker-compose up -d postgres
go run ./cmd/server

# Frontend
cd frontend && npm install && npm run dev
```

Full stack with Docker:

```bash
cd frontend && npm install && npm run build && cd ..
MOCK_MODE=true docker-compose up --build
```

- PWA: http://localhost:3000
- API: http://localhost:8080
- USSD callback: `POST http://localhost:8080/ussd/callback`

### USSD demo (curl)

```bash
curl -X POST http://localhost:8080/ussd/callback \
  -d "sessionId=demo&serviceCode=*384%23&phoneNumber=%2B254712345678&text="
```

## Pesa Playground

For local Daraja 3.0 testing without Safaricom credentials, use [Pesa Playground](https://github.com/DaveOuma/pesa-playground):

```bash
export MPESA_BASE_URL=http://localhost:8400
```

With `MOCK_MODE=true`, M-Pesa calls are bypassed with realistic demo balances (KES 45,230 float).

## daraja-go

The `pkg/daraja/` package is a **standalone** Daraja 3.0 Go SDK with zero non-stdlib dependencies. It will be published separately as [daraja-go](https://github.com/yourusername/daraja-go). See [pkg/daraja/README.md](pkg/daraja/README.md).

Official Daraja docs: https://developer.safaricom.co.ke

## Hackathon Tracks

- **Best Tool for Mobile Money Agents** (210K sats)
- **Best Use of Pontmore** (210K sats)

## Post-Hackathon Funding

- [BTrust Starter Grant](https://btrust.tech)
- [OpenSats General Fund](https://opensats.org)

## Demo Scenario

With `MOCK_MODE=true`:

1. Dashboard shows KES 45,230 float and 124,500 sats
2. USSD hint: "Dial *384#"
3. Swap flow: 10,000 KES → 3 agents on Kisumu map → Lightning invoice QR
4. History with P/L and CSV export
5. Disputes publish evidence to Nostr

## LND (production)

Build with LND support:

```bash
go build -tags lnd ./...
```

Set `MOCK_MODE=false` and provide `LND_HOST`, `LND_MACAROON_HEX`, `LND_TLS_CERT`.
