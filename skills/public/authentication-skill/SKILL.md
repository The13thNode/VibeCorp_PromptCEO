---
name: authentication-skill
description: Implements authentication and authorisation systems including JWT, OAuth2, sessions, MFA, social login, RBAC, and refresh token rotation. Use when building any login/signup system, adding social auth, implementing role-based access, or designing permission systems. Trigger for "authentication", "login system", "JWT", "OAuth", "social login", "Google login", "RBAC", "permissions", "MFA", or "session management". Part of the Founder OS engineering suite.
---

# Authentication — Founder OS

## Framework 1: Auth Strategy Selection

| Method | Best For | Complexity | Use When |
|--------|---------|-----------|---------|
| JWT (stateless) | APIs, SPAs, mobile | Medium | Microservices, need to verify without DB lookup |
| Session (stateful) | Traditional web apps | Low | Simpler to revoke, server-side rendering |
| OAuth2 (social) | User acquisition | Medium | Want Google/GitHub login, reduce friction |
| Magic link | Low-friction onboarding | Low | No password friction, B2C products |
| Passkeys (WebAuthn) | Modern, passwordless | High | Future-proofing, security-focused products |

**Recommendation for most SaaS founders:** Start with a managed auth provider (Clerk, Auth0, Supabase Auth, NextAuth). Don't build auth from scratch — it's a security liability.

---

## Framework 2: JWT Implementation

### JWT Structure
```
Header.Payload.Signature

Header: { "alg": "HS256", "typ": "JWT" }
Payload: {
  "sub": "user_123",          // Subject (user ID)
  "iat": 1704067200,          // Issued at (Unix timestamp)
  "exp": 1704153600,          // Expiry (Unix timestamp)
  "jti": "unique_token_id",   // JWT ID (for revocation)
  "role": "admin",            // Custom claims
  "orgId": "org_456"          // Custom claims
}
```

### Token Rotation Pattern
```typescript
// Access token: short-lived (15 minutes)
// Refresh token: long-lived (7-30 days), stored in httpOnly cookie

// On login
const accessToken = jwt.sign(
  { sub: user.id, role: user.role, orgId: user.orgId },
  process.env.JWT_SECRET,
  { expiresIn: '15m' }
);

const refreshToken = crypto.randomBytes(32).toString('hex');
await db.refreshToken.create({
  data: {
    token: hashToken(refreshToken),  // Hash before storing
    userId: user.id,
    expiresAt: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000)
  }
});

// Set refresh token as httpOnly cookie (not accessible to JS)
res.cookie('refresh_token', refreshToken, {
  httpOnly: true,
  secure: true,       // HTTPS only
  sameSite: 'strict',
  maxAge: 30 * 24 * 60 * 60 * 1000
});

// On refresh
// 1. Validate refresh token from cookie
// 2. Delete old refresh token (rotation)
// 3. Issue new access token + new refresh token
// 4. Set new refresh token cookie
```

### Auth Middleware
```typescript
export async function requireAuth(req: Request, res: Response, next: NextFunction) {
  const token = req.headers.authorization?.replace('Bearer ', '');

  if (!token) {
    return res.status(401).json({
      success: false,
      error: { code: 'UNAUTHORIZED', message: 'Authentication required' }
    });
  }

  try {
    const payload = jwt.verify(token, process.env.JWT_SECRET!) as JWTPayload;
    req.user = { id: payload.sub, role: payload.role, orgId: payload.orgId };
    next();
  } catch {
    return res.status(401).json({
      success: false,
      error: { code: 'TOKEN_INVALID', message: 'Token is invalid or expired' }
    });
  }
}
```

---

## Framework 3: OAuth2 / Social Login

### OAuth2 Flow (Google example)
```
1. User clicks "Sign in with Google"
2. Redirect to Google: GET /oauth2/auth?client_id=...&redirect_uri=...&scope=email+profile
3. User authenticates with Google
4. Google redirects back: GET /auth/callback?code=xyz123
5. Exchange code for tokens: POST /oauth2/token
6. Get user info: GET /userinfo (with access_token)
7. Create/find user in your DB, issue your own session/JWT
```

### State Parameter (CSRF protection — required)
```typescript
// Before redirecting to OAuth provider
const state = crypto.randomBytes(16).toString('hex');
req.session.oauthState = state;

const authUrl = new URL('https://accounts.google.com/o/oauth2/v2/auth');
authUrl.searchParams.set('state', state);  // Include state

// On callback
if (req.query.state !== req.session.oauthState) {
  throw new Error('CSRF attack detected');
}
```

---

## Framework 4: RBAC (Role-Based Access Control)

### Role Design Pattern
```typescript
// Define roles and permissions
const PERMISSIONS = {
  'user:read':    ['viewer', 'member', 'admin', 'owner'],
  'user:write':   ['admin', 'owner'],
  'billing:read': ['admin', 'owner'],
  'billing:write': ['owner'],
  'org:delete':   ['owner'],
} as const;

// Permission check middleware
export function requirePermission(permission: string) {
  return (req: Request, res: Response, next: NextFunction) => {
    const { role } = req.user;
    const allowedRoles = PERMISSIONS[permission];

    if (!allowedRoles?.includes(role)) {
      return res.status(403).json({
        success: false,
        error: { code: 'FORBIDDEN', message: 'Insufficient permissions' }
      });
    }
    next();
  };
}

// Usage
router.delete('/org/:id',
  requireAuth,
  requirePermission('org:delete'),
  deleteOrgHandler
);
```

---

## Framework 5: MFA Implementation

### TOTP (Google Authenticator style)
```typescript
import { authenticator } from 'otplib';

// Setup: generate secret for user
const secret = authenticator.generateSecret();
const otpUri = authenticator.keyuri(user.email, 'YourApp', secret);
// Show QR code of otpUri to user

// Verify during login
const isValid = authenticator.verify({
  token: userProvidedCode,
  secret: storedSecret
});
```

### SMS MFA (simpler, less secure)
Use Twilio Verify — don't build OTP generation yourself.

---

## Managed Auth Providers (recommended for founders)

| Provider | Price | Best For |
|---------|-------|---------|
| Clerk | Free to $25/mo | Best DX, React components, B2B features |
| Supabase Auth | Free tier | If already using Supabase |
| Auth0 | Free to $23/mo | Enterprise features, compliance |
| NextAuth | Free | Next.js apps, self-hosted |
| Firebase Auth | Free tier | Firebase ecosystem |

**When to use managed:** Almost always at seed stage. Building auth yourself costs 2-4 weeks and creates ongoing security liability.

**When to build your own:** When compliance requires it (HIPAA with specific BAA needs), when managed provider costs exceed $1K/month, or when your product IS identity.

---

## Integration

- Before implementing → `backend-dev` (auth middleware plugs into API layer)
- After implementing → `security-auditor` (auth flow security review)
- For database → `database-design` (sessions/tokens schema)
- For compliance → `regulatory-compliance` (GDPR right to deletion of auth data)
