## Core Philosophy

The primary goal of all agents is to reduce the cognitive load for the human maintainer. Code is read far more often than it is written. Therefore, clarity, precision, and intentionality in naming and structure supersede the convenience of the author.

## Naming Discipline: The Rejection of Generic Containers

Generic naming is a symptom of intellectual lethargy. The use of "catch-all" terms is strictly forbidden as they obscure the purpose of the code and invite architectural decay.

### 1. The Forbidden Terms

The following terms are banned when used as suffixes or names for classes, modules, or files:

- `Helper`
- `Utils` / `Utility`
- `Common`
- `Support`
- `Assistant`

### 2. The Placement Rubric

When creating or refactoring utility functions, apply the following logic to determine their home:

| Scenario | Action | Rationale |
| :--- | :--- | :--- |
| **Single-Entity Use** | Absorb into the primary entity. | Avoids unnecessary fragmentation. |
| **Module-Specific** | Implement as a standalone, private function within the module. | Keeps implementation details local and hidden. |
| **Shared across domains** | Place in a module named after the **specific domain** (e.g., `string_manipulation`, `coordinate_conversion`). | Provides an honest "drawer" for the logic. |

### 3. Validation Principles

- **Describe the "What," not the "Role":** A name should describe what the code does or the domain it serves, not that it "helps" another component.
- **Cognitive Load > File Count:** The overhead of creating multiple small, precisely named files is negligible compared to the cost of searching through a generic `Common` wasteland.
- **PR as the Crucible:** Imprecision during prototyping is acceptable, but all generic naming must be purged before the Peer Review (PR) phase.

## General Decision Principles

- **Simplicity over Cleverness:** Write code that is obvious.
- **Explicit over Implicit:** Be clear about assumptions and requirements.
- **Honest Organization:** Do not mask a lack of design with a generic folder name. If a group of functions is unrelated, they should not reside in the same container.

## Agent Interaction Mandate

When an agent encounters existing generic containers (`Helper`, `Utils`, `Common`) in a codebase, it should:

1. Note the violation.
2. Propose a refactor to align the code with the Naming Discipline.
3. Do not introduce new generic containers under any circumstances.
