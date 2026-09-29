---
name: test-double-principles
description: A philosophical framework for selecting and implementing test doubles to isolate the Unit Under Test (UUT) and minimize coupling.
---

# Universal Principles of Test Doubles

## Core Philosophy: Isolation and Decoupling

The primary goal of test doubles is the **absolute isolation** of the Unit Under Test (UUT). A test should fail if and only if the logic within the UUT is broken, not because a dependency is malfunctioning or unavailable.

### The Dependency Injection Mandate

Decoupling is impossible without **Dependency Injection (DI)**.

- **Requirement**: Dependencies must be injected (via constructor, setter, or interface) rather than hard-coded or instantiated inside the UUT.
- **Mechanism**: The UUT must depend on an abstraction (Interface/Abstract Class) rather than a concrete implementation. This allows the test suite to swap the real component for a double without modifying the UUT's source code.

## Taxonomy of Test Doubles

| Double | Purpose | Behavior | Key Characteristic |
| :--- | :--- | :--- | :--- |
| **Dummy** | Parameter Filling | Does nothing. | Passed around but never actually used. |
| **Stub** | State Control | Provides "canned" responses. | Returns a fixed value to force the UUT down a specific code path. |
| **Spy** | Interaction Recording | Records how it was called. | Captures arguments and call counts for later verification. |
| **Mock** | Behavioral Verification | Expects specific calls. | The test fails if the expected interaction does not occur. |
| **Fake** | Simplified Implementation | Functional but lightweight. | A working implementation (e.g., `InMemoryRepository`) that is unsuitable for production. |
| **Shadow** | State Mirroring | Mirrors real behavior. | Acts as a proxy or a "ghost" that mimics real-world effects without side effects. |

## Decision Framework: The Path of Least Resistance

When advising users on how to decouple a UUT, apply this hierarchy to find the "laziest" (most efficient) effective double:

1. **Can I just pass `nullptr` or an empty object?** $\rightarrow$ **Dummy**.
2. **Do I just need a specific return value to trigger a branch?** $\rightarrow$ **Stub**.
3. **Do I need to verify that a method was called once with X argument?** $\rightarrow$ **Spy**.
4. **Is the dependency too slow, non-deterministic, interfacing with hardware, or complex (e.g., Database, Network)?** $\rightarrow$ **Fake**.
5. **Is the interaction sequence critical to the business logic?** $\rightarrow$ **Mock**.
6. **Does the double need to behave like the real thing across multiple calls?** $\rightarrow$ **Shadow**.

If possible, use a fake instead of a mock.

## Agent Guidance for Decoupling

When a UUT is tightly coupled to a dependency, recommend the following refactoring sequence:

1. **Extract Interface**: Create an interface for the dependency.
2. **Introduce Constructor Injection**: Change the UUT to accept the interface in its constructor.
3. **Swap Implementation**: In the test, inject the appropriate Test Double based on the Decision Framework.
4. **Verify Isolation**: Ensure the test no longer triggers any side effects or requires external infrastructure.

## Related Topics

- [Dependency Injection Patterns]
- [Unit Testing Strategy]
- [TDD (Test Driven Development)]
