# Jenkins Project

This project runs a Jenkins BlueOcean environment with a sidecar "MyApp" service, managed via Docker Bake and Docker Compose. It features a robust multi-service versioning strategy.

## 1. Building the Stack (Docker Bake)

We use `docker buildx bake` to build all images. This tool reads the current versions and tags the images accordingly.

### Build All Services
```bash
docker buildx bake
```
This builds:
- `jenkins` (tagged with version in `VERSION`)
- `myapp` (tagged with version in `myapp/VERSION`)
- `myservice` (tagged with version in `myservice/VERSION`)

### Build Specific Service
```bash
docker buildx bake myapp
```

### Inspect Configuration
To see exactly what tags and contexts will be used:
```bash
docker buildx bake --print
```

---

## 2. Running the Stack (Docker Compose)

Once built, you can run the entire environment with Docker Compose.

### Start Services
```bash
docker-compose up -d
```
Access Jenkins at: http://localhost:8080

### Stop Services
```bash
docker-compose down
```

### View Logs
```bash
docker-compose logs -f
```

---

## 3. Versioning Strategy

This project follows a strict **Monorepo Versioning Strategy**. Each service is versioned independently using explicit **Conventional Commits**.

### Scope Rule
To trigger a version bump for a specific service, the **Scope** in your commit message MUST match the directory name of that service.

Format: `type(scope): message`

### Valid Scopes

| Scope | Target Version File |
| :--- | :--- |
| `myapp` | `myapp/VERSION` |
| `myservice` | `myservice/VERSION` |
| `jenkins` | `VERSION` (Root/Jenkins) |
| `ci` / `scripts` | *No version bump (Internal Tooling)* |

### Commit Types

The **Type** determines the magnitude of the version bump:

- **fix(...)**: **Patch Bump** (e.g., `0.1.0` -> `0.1.1`)  
  Used for bug fixes.
- **feat(...)**: **Minor Bump** (e.g., `0.1.0` -> `0.2.0`)  
  Used for new features.
- **BREAKING CHANGE**: **Major Bump** (e.g., `0.1.0` -> `1.0.0`)  
  MUST be in the commit footer.

### Global vs Specific
Commits without a scope (e.g., `feat: update global config`) may default to bumping the Root version (`VERSION`) or might be rejected by the pipeline depending on strictness.
**Preference:** Always use scoped commits (e.g., `feat(jenkins): update config`) to ensure the correct service is versioned.

### Automatic Changelog
The `scripts/update_changelog.py` script automatically parses these commits and updates the [Versions.md](Versions.md) file.

---

## Credits
Inspiration: https://www.youtube.com/watch?v=6YZvp2GwT0A
