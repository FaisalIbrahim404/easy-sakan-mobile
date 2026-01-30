# Easy Sakan – Mobile App (Flutter)

## Purpose of This Document

This README defines **how the Flutter mobile project is structured, how the team works inside it, and which rules are non-negotiable**. It exists to:

* Remove ambiguity on day one
* Prevent architectural drift
* Enable parallel work without collisions
* Keep the MVP fast **without** becoming messy

This is **not** a Flutter tutorial. It is a project contract.

---

## High-Level Principles (Read First)

These principles override convenience:

1. **Feature-first, not layer-first**
   We organize by business capability, not by technical type.

2. **Mobile is a client, not an authority**
   All source-of-truth logic lives on the backend.

3. **No shared god folders**
   If something grows too big, it becomes its own feature or shared module.

4. **Predictability > cleverness**
   Anyone should be able to guess where a file lives.

---

## Project Structure (Top Level)

```
lib/
├── app/
├── core/
├── features/
├── shared/
├── main.dart
```

Each folder has a **strict responsibility**.

---

## `main.dart`

* App entry point only
* Environment bootstrap
* No business logic

Allowed:

* App initialization
* Dependency injection bootstrap
* App widget

---

## `app/` – Application Shell

Purpose: Glue everything together.

```
app/
├── app.dart
├── router.dart
├── app_config.dart
```

Responsibilities:

* Global app widget
* Navigation setup
* App-wide configuration

Rules:

* No feature logic
* No API calls
* No domain models

---

## `core/` – Cross-Cutting Foundations

Purpose: Things that are **conceptually global** and **feature-agnostic**.

```
core/
├── auth/
├── networking/
├── storage/
├── error/
├── config/
```

### `core/auth/`

* Token handling
* Session persistence
* Auth guards (client-side only)

### `core/networking/`

* HTTP client
* Interceptors
* API base configuration

### `core/storage/`

* Secure storage
* Local preferences

### `core/error/`

* Error models
* Error mapping (API → UI-safe)

Rules:

* No feature imports allowed here
* Core must be stable and boring

---

## `features/` – Business Capabilities (Most Important)

Each feature is **self-contained**.

```
features/
├── auth/
├── tower/
├── apartment/
├── payments/
├── service_requests/
```

### Feature Internal Structure

Every feature follows the same internal layout:

```
feature_name/
├── presentation/
├── application/
├── domain/
├── data/
```

#### `presentation/`

* Screens
* Widgets
* State management (Bloc / Riverpod)

Rules:

* UI logic only
* No HTTP calls

#### `application/`

* Use cases
* Feature-specific controllers

Rules:

* Orchestrates flows
* No UI widgets

#### `domain/`

* Entities
* Value objects

Rules:

* No Flutter imports
* No JSON / API logic

#### `data/`

* DTOs
* API calls
* Repositories (implementations)

Rules:

* Converts API data → domain models

---

## `shared/` – Reusable UI & Utilities

Purpose: Reuse **without coupling**.

```
shared/
├── ui/
├── utils/
├── constants/
```

### `shared/ui/`

* Buttons
* Inputs
* Dialogs

Rules:

* No business meaning
* Purely visual

---

## State Management

* **Single standard** (decide once): Bloc or Riverpod
* Feature-scoped state only
* No global mutable state

Rule of thumb:

> If two features share state, it probably belongs to the backend.

---

## Navigation Rules

* Centralized routing
* No navigation logic inside widgets
* Navigation reflects backend authority (permissions)

---

## API & Backend Interaction

* All APIs accessed via repositories
* No direct HTTP calls in UI
* DTOs never leak outside `data/`

---

## Error Handling Philosophy

* Backend errors are mapped to **user-safe messages**
* No raw backend messages shown
* Fail visibly, not silently

---

## Naming Conventions

### Files & Folders

* `snake_case` for files and folders
* Feature names are nouns

### Classes

* `PascalCase`

### Variables & Functions

* `camelCase`

---

## Git Workflow (Mandatory)

### Branch Naming

```
feature/mobile-auth
feature/mobile-payments
fix/mobile-login-crash
chore/mobile-deps
```

Pattern:

```
<type>/<scope>-<short-description>
```

---

## Commit Messages

Use **Conventional Commits**:

```
feat(auth): add login screen
fix(payments): handle failed payment state
refactor(tower): simplify apartment mapping
chore(deps): update flutter packages
```

Rules:

* One logical change per commit
* Present tense
* No vague messages

---

## Pull Request Naming

```
[MOBILE][AUTH] Login flow MVP
[MOBILE][PAYMENTS] Rent payment flow
[MOBILE][CORE] Networking setup
```

PR Description must include:

* What was added
* What was intentionally skipped
* Any tech debt introduced

---

## Non-Goals (Explicit)

* No tests in MVP phase
* No offline mode
* No advanced animations
* No deep theming system

---

## Final Rule

If something does not clearly belong somewhere:

> **Stop and document the decision before coding.**

That is cheaper than refactoring later.
