# Deployment instructions

# 1. First time setup - generate seed and save it
openssl rand -hex 32 > seed.key
echo "SEED_SECRET_KEY=$(cat seed.key)" > .env

# 2. Start the gateway
docker compose up -d

# 3. Check logs
docker compose logs -f

# 4. Restart gateway (will use same seed from .env)
docker compose restart

## Testing

# 1. Basic health check
curl http://localhost:8082/health

# 2. Get OHTTP config to verify gateway is working
curl -H "Accept: application/ohttp-keys" http://localhost:8082/ohttp-keys

<!-- # 3. Test all routes using the client:
go run client.go https://api.tinfoil.sh/surveys/123/config
go run client.go -X POST https://questions.example.com/questions/456/submit -d '{"answer": 42}'
go run client.go https://leader.tinfoil.sh/api/endpoint
go run client.go https://helper.tinfoil.sh/api/endpoint -->