---
name: api-design
description: Designs REST APIs, GraphQL schemas, OpenAPI specs, webhook systems, and API versioning strategies. Use when a founder or team needs to design or document an API before building it, create an OpenAPI/Swagger spec, design a webhook system, plan API versioning, or build developer-facing APIs. Trigger for "design an API", "API spec", "OpenAPI", "REST vs GraphQL", "webhook design", "API versioning", "developer API", or "document my endpoints". Part of the Founder OS suite — the API contract layer that connects frontend and backend.
---

# API Design — Founder OS

Great APIs are designed before they are built. The contract between frontend and backend — and between your product and other developers — should be explicit, versioned, and stable.

---

## REST API Design Principles

### URL Structure
```
# Resources are nouns, never verbs
GET    /api/v1/users              ✓
GET    /api/v1/getUsers           ✗

# Nested resources show relationships
GET    /api/v1/users/:id/posts    ✓
GET    /api/v1/getUserPosts       ✗

# Actions that don't fit CRUD use sub-resources
POST   /api/v1/users/:id/activate    ✓
POST   /api/v1/activateUser          ✗
```

### HTTP Methods
| Method | Action | Success Code | Body |
|--------|--------|-------------|------|
| GET | Fetch resource(s) | 200 | Response data |
| POST | Create resource | 201 | Created resource |
| PUT | Replace resource | 200 | Updated resource |
| PATCH | Update fields | 200 | Updated resource |
| DELETE | Remove resource | 204 | Empty |

### Standard Response Envelope
```typescript
// Always use this shape — never break it
interface ApiResponse<T> {
  success: boolean;
  data?: T;
  error?: {
    code: string;         // Machine-readable: "USER_NOT_FOUND"
    message: string;      // Human-readable: "No user with that ID exists"
    field?: string;       // For validation errors: "email"
  };
  meta?: {
    total: number;        // For paginated lists
    page: number;
    limit: number;
    hasMore: boolean;
  };
}

// Success example
{ "success": true, "data": { "id": "123", "name": "Alice" } }

// Error example
{ "success": false, "error": { "code": "VALIDATION_ERROR", "message": "Email is invalid", "field": "email" } }

// Paginated list
{ "success": true, "data": [...], "meta": { "total": 500, "page": 2, "limit": 20, "hasMore": true } }
```

### Error Code Standard
```
HTTP 400 — Bad Request      → Validation errors, malformed input
HTTP 401 — Unauthorized     → Not authenticated (no/invalid token)
HTTP 403 — Forbidden        → Authenticated but not permitted
HTTP 404 — Not Found        → Resource doesn't exist
HTTP 409 — Conflict         → Duplicate, state conflict
HTTP 422 — Unprocessable    → Semantically invalid (valid JSON, bad business logic)
HTTP 429 — Too Many Requests → Rate limit hit
HTTP 500 — Internal Error   → Something broke on server side
```

---

## OpenAPI Spec Template

```yaml
openapi: 3.0.3
info:
  title: [Your Product] API
  version: 1.0.0
  description: |
    [Brief description of what this API does]

    ## Authentication
    All endpoints require Bearer token authentication.
    Get a token via POST /api/v1/auth/login

servers:
  - url: https://api.yourproduct.com/v1
    description: Production
  - url: https://api-staging.yourproduct.com/v1
    description: Staging

security:
  - bearerAuth: []

components:
  securitySchemes:
    bearerAuth:
      type: http
      scheme: bearer
      bearerFormat: JWT

  schemas:
    User:
      type: object
      required: [id, email, createdAt]
      properties:
        id:
          type: string
          format: uuid
          example: "550e8400-e29b-41d4-a716-446655440000"
        email:
          type: string
          format: email
          example: "alice@example.com"
        name:
          type: string
          example: "Alice Smith"
        createdAt:
          type: string
          format: date-time

    Error:
      type: object
      required: [success, error]
      properties:
        success:
          type: boolean
          example: false
        error:
          type: object
          required: [code, message]
          properties:
            code:
              type: string
              example: "USER_NOT_FOUND"
            message:
              type: string
              example: "No user found with that ID"
            field:
              type: string
              example: "email"

paths:
  /users/{id}:
    get:
      summary: Get a user by ID
      tags: [Users]
      parameters:
        - name: id
          in: path
          required: true
          schema:
            type: string
            format: uuid
      responses:
        '200':
          description: User found
          content:
            application/json:
              schema:
                type: object
                properties:
                  success:
                    type: boolean
                    example: true
                  data:
                    $ref: '#/components/schemas/User'
        '404':
          description: User not found
          content:
            application/json:
              schema:
                $ref: '#/components/schemas/Error'
```

---

## API Versioning Strategy

### URL Versioning (recommended for public APIs)
```
/api/v1/users    ← stable
/api/v2/users    ← new version (v1 still works)
```

### Versioning Rules
- **Never break a published version** — add v2 instead of changing v1
- **Deprecation window** — announce deprecation 6+ months before removal
- **Version in URL for major changes** — new resource shape, removed fields
- **Header versioning for minor changes** — `API-Version: 2024-01-15`

### What Requires a New Version
```
Breaking changes (require new version):
✗ Removing a field from response
✗ Changing a field's type
✗ Changing URL structure
✗ Changing authentication method

Non-breaking (can add to existing version):
✓ Adding new optional fields to response
✓ Adding new optional query parameters
✓ Adding new endpoints
✓ Making a required field optional
```

---

## Webhook Design

### Webhook Payload Standard
```typescript
interface WebhookPayload {
  id: string;           // Unique event ID (for deduplication)
  type: string;         // "user.created", "payment.succeeded"
  createdAt: string;    // ISO 8601 timestamp
  data: object;         // The event data
  version: string;      // "1.0" — your API version
}

// Example
{
  "id": "evt_1234abcd",
  "type": "payment.succeeded",
  "createdAt": "2025-03-15T10:30:00Z",
  "data": {
    "paymentId": "pay_5678efgh",
    "amount": 9900,
    "currency": "usd",
    "userId": "usr_9012ijkl"
  },
  "version": "1.0"
}
```

### Webhook Security (Signing)
```typescript
// Sign every webhook with HMAC-SHA256
import crypto from 'crypto';

function signWebhook(payload: string, secret: string): string {
  return crypto
    .createHmac('sha256', secret)
    .update(payload)
    .digest('hex');
}

// Add to request headers
headers['X-Webhook-Signature'] = `sha256=${signWebhook(JSON.stringify(payload), webhookSecret)}`;
headers['X-Webhook-Timestamp'] = Date.now().toString();

// Receiver validates:
function validateWebhook(payload: string, signature: string, timestamp: string, secret: string): boolean {
  // 1. Check timestamp is within 5 minutes (replay attack prevention)
  const age = Date.now() - parseInt(timestamp);
  if (age > 300000) return false;

  // 2. Verify signature
  const expected = `sha256=${signWebhook(payload, secret)}`;
  return crypto.timingSafeEqual(Buffer.from(signature), Buffer.from(expected));
}
```

### Webhook Retry Policy
```
Attempt 1: Immediately
Attempt 2: 5 minutes later
Attempt 3: 30 minutes later
Attempt 4: 2 hours later
Attempt 5: 24 hours later
After 5 failures: Mark as failed, alert developer
```

---

## Rate Limiting Design

```typescript
// Standard rate limit headers (always include these)
response.headers['X-RateLimit-Limit'] = '1000';      // Requests per window
response.headers['X-RateLimit-Remaining'] = '997';   // Requests left
response.headers['X-RateLimit-Reset'] = '1710000000'; // Unix timestamp when resets
response.headers['Retry-After'] = '60';               // Seconds until retry (on 429)

// Rate limit tiers
const rateLimits = {
  anonymous:   { requests: 10,    window: '1m' },
  free:        { requests: 100,   window: '1h' },
  pro:         { requests: 1000,  window: '1h' },
  enterprise:  { requests: 10000, window: '1h' },
};
```

---

## REST vs GraphQL Decision

| Criteria | Choose REST | Choose GraphQL |
|----------|-------------|---------------|
| Client needs | Well-defined, stable | Flexible, varies per screen |
| Team expertise | General | GraphQL experience |
| Caching | Simple HTTP caching | Need custom caching layer |
| API consumers | Third-party developers | Your own frontend only |
| Over/under-fetching | Acceptable | Critical to avoid |
| Tooling | Universal | Requires GraphQL ecosystem |

**Rule of thumb**: Start with REST. Move to GraphQL when you have multiple clients (web, mobile, partner APIs) with significantly different data needs.

---

## Integration with Founder OS

- **Contract with** → `frontend-dev` (frontend builds against this spec)
- **Implemented by** → `backend-dev` (backend implements this spec)
- **Tested against** → `qa-engineer` (tests verify contract is met)
- **Secured by** → `security-auditor` (reviews auth, rate limits, input validation)
- **Published for** → `distribution-engine` (developer API as distribution channel)
