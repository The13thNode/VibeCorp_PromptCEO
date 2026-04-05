---
name: frontend-data-layer
description: Frontend data fetching patterns — React Query (TanStack Query) setup, custom hooks, caching strategies, optimistic updates, error boundaries, and API layer abstraction. Load this skill before any API integration work in src/.
version: 1.0.0
used_by: [frontend-dev, backend-dev, build-quality-auditor]
---

## Purpose

Defines how the frontend fetches, caches, and manages server state.
Replaces ad-hoc useState-based API calls with structured patterns.

## Architecture Decision

Use TanStack Query (React Query v5) for all server state management.
Local UI state (modals, form inputs, filters) remains in useState/useReducer.

## Setup Pattern
```typescript
// src/lib/query-client.ts
import { QueryClient } from '@tanstack/react-query';

export const queryClient = new QueryClient({
  defaultOptions: {
    queries: {
      staleTime: 5 * 60 * 1000,      // 5 min before refetch
      gcTime: 30 * 60 * 1000,         // 30 min cache retention
      retry: 2,
      refetchOnWindowFocus: false,
    },
  },
});
```

## API Layer Abstraction
```typescript
// src/lib/api.ts
const API_BASE = import.meta.env.VITE_API_URL;

async function apiRequest<T>(path: string, options?: RequestInit): Promise<T> {
  const res = await fetch(`${API_BASE}${path}`, {
    headers: { 'Content-Type': 'application/json', ...options?.headers },
    ...options,
  });
  if (!res.ok) {
    const error = await res.json().catch(() => ({ message: res.statusText }));
    throw new Error(error.message || `API error: ${res.status}`);
  }
  const json = await res.json();
  return json.data ?? json;
}

export const api = {
  listings: {
    list: (params?: URLSearchParams) => apiRequest<Listing[]>(`/api/listings?${params || ''}`),
    get: (id: string) => apiRequest<Listing>(`/api/listings/${id}`),
  },
  bookings: {
    create: (data: CreateBookingInput) => apiRequest<Booking>('/api/bookings', { method: 'POST', body: JSON.stringify(data) }),
    accept: (id: string) => apiRequest<Booking>(`/api/bookings/${id}/accept`, { method: 'PATCH' }),
    decline: (id: string) => apiRequest<Booking>(`/api/bookings/${id}/decline`, { method: 'PATCH' }),
  },
  auth: {
    login: (data: LoginInput) => apiRequest<AuthResponse>('/api/auth/login', { method: 'POST', body: JSON.stringify(data) }),
    me: () => apiRequest<User>('/api/auth/me'),
  },
};
```

## Query Hook Pattern
```typescript
// src/hooks/useListings.ts
import { useQuery } from '@tanstack/react-query';
import { api } from '@/lib/api';

export function useListings(filters?: ListingFilters) {
  const params = new URLSearchParams();
  if (filters?.category) params.set('category', filters.category);
  if (filters?.minPrice) params.set('minPrice', String(filters.minPrice));
  if (filters?.maxPrice) params.set('maxPrice', String(filters.maxPrice));

  return useQuery({
    queryKey: ['listings', filters],
    queryFn: () => api.listings.list(params),
  });
}
```

## Mutation Hook Pattern
```typescript
// src/hooks/useCreateBooking.ts
import { useMutation, useQueryClient } from '@tanstack/react-query';
import { api } from '@/lib/api';

export function useCreateBooking() {
  const queryClient = useQueryClient();

  return useMutation({
    mutationFn: (data: CreateBookingInput) => api.bookings.create(data),
    onSuccess: () => {
      queryClient.invalidateQueries({ queryKey: ['bookings'] });
    },
  });
}
```

## Component Usage Pattern
```typescript
function BrowsePage() {
  const [filters, setFilters] = useState<ListingFilters>({});
  const { data: listings, isLoading, error } = useListings(filters);

  if (isLoading) return <ListingSkeleton count={6} />;
  if (error) return <ErrorState message={error.message} onRetry={() => {}} />;
  if (!listings?.length) return <EmptyState message="No results match your filters" />;

  return <ListingGrid listings={listings} />;
}
```

## Rules

1. Every API call goes through `src/lib/api.ts` — no raw `fetch()` in components
2. Every server-state hook uses TanStack Query — no `useState` + `useEffect` for API data
3. Every query has a `queryKey` array that includes all filter/param dependencies
4. Every page has three states handled: loading (skeleton), error (retry button), empty
5. Mutations that change server data must `invalidateQueries` for affected query keys
6. No API URLs hardcoded in components — all go through the api object
7. Auth token injection happens in `apiRequest` — never in individual hooks or components
8. TypeScript generics on all API calls — no `any` types in the data layer
