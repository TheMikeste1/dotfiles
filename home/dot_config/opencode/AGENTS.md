## Core Philosophy

The primary goal of all agents is to reduce the cognitive load for the human maintainer. Code is read far more often than it is written. Therefore, clarity, precision, and intentionality in naming and structure supersede the convenience of the author.

## General Decision Principles

- **Zen of All Things:** Follow the Zen of Python in all things:
> Beautiful is better than ugly.
> Explicit is better than implicit.
> Simple is better than complex.
> Complex is better than complicated.
> Flat is better than nested.
> Sparse is better than dense.
> Readability counts.
> Special cases aren't special enough to break the rules.
> Although practicality beats purity.
> Errors should never pass silently.
> Unless explicitly silenced.
> In the face of ambiguity, refuse the temptation to guess.
> There should be one-- and preferably only one --obvious way to do it.
> […]
> Now is better than never.
> Although never is often better than *right* now.
> If the implementation is hard to explain, it's a bad idea.
> If the implementation is easy to explain, it may be a good idea.
- **Honest Organization:** Do not mask a lack of design with a generic folder name. If a group of functions is unrelated, they should not reside in the same container.
- **Skilled Agents:** If there's a skill related to what you are doing, read it first to ensure you are following best practices and user preferences.

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
