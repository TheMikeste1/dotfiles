---
name: test-implementation
description: Implement and validate tests for requirements, behavior, edge cases, and regressions without modifying non-test code.
---

# Test Implementation

Use this skill when implementing, updating, or validating tests.

## Scope

Implement tests that provide confidence that the relevant requirements and behavior are correctly satisfied.

Test implementation may include:

- Unit tests
- Integration tests
- System tests
- Regression tests
- Other project-appropriate tests

Prefer the smallest test scope that adequately verifies the behavior.

## Test Design

Follow established test-design practices and the conventions of the project and test framework.

- Test one specific behavior or requirement per test where practical.
- Cover both explicit requirements and relevant observable behavior.
- Prefer unit tests when they provide sufficient coverage.
- Keep unit tests fast and focused.
- Aim for 100% coverage where practical and meaningful.
- Cover relevant edge cases, boundary conditions, and failure paths.
- Add an explicit regression test when a bug or regression is identified.
- Treat security requirements as first-class test requirements.
- Use the available test framework to its fullest.
    - Follow framework idioms.
    - Prefer modern framework features.
    - Use fixtures where appropriate.
    - Use parameterized or template tests where appropriate.
    - Reuse appropriate test helpers rather than duplicating setup.

## External Interfaces

Hardware, syscalls, operating-system behavior, network interfaces, and other external interfaces can be difficult to test.

Test these interfaces when practical, but do not introduce unorthodox hacks, undefined behavior, or fragile mechanisms solely to make them testable.

When an interface cannot be fully tested:

- Test as much of the behavior as reasonably possible.
- Clearly identify what remains untested.
- Use an explicit skipped test with an explanation when the framework supports it.
- When behavior is conditionally testable, use a conditional test where appropriate and report when the required conditions are unavailable.
- Document the limitation in the completion report.

## Test Execution

Run the smallest relevant set of tests necessary to validate the changes.

Prioritize:

1. Newly implemented or modified tests.
2. Tests directly related to the requirements.
3. Tests covering closely related behavior.
4. Broader tests when warranted by the scope of the changes or discovered failures.

Do not run the entire test suite unless necessary.

Run implemented tests whenever the environment permits. If tests cannot be executed, determine why and document the limitation.

## Handling Failures

A failing test does not justify changing the implementation to make the test pass.

When a failure occurs:

- Determine whether it appears to be a test defect, implementation defect, environmental problem, or unrelated failure.
- Preserve tests that correctly express the intended behavior.
- Do not weaken, remove, skip, or alter a test merely to accommodate an existing bug.
- If possible, add a regression test that captures the intended behavior.
- Report suspected implementation bugs rather than fixing them.

## Requirements and Uncertainty

Use the available requirements, existing tests, and project conventions to resolve minor ambiguities.

When requirements are materially ambiguous:

- Make the smallest reasonable assumption necessary to proceed.
- Avoid inventing requirements.
- Document important assumptions and unresolved ambiguity in the completion report.

## Non-Test Code

**Do not modify non-test code.**

This includes production code and other non-test project files unless they are themselves part of the project's test infrastructure and the requested work explicitly requires changing them.

If non-test code prevents the desired behavior from being tested:

1. Look for another way to test the intended behavior.
2. Add a regression test when appropriate.
3. Report the implementation problem.

Do not modify production code merely to make a test pass.

## Completion Report

Report the outcome of the test implementation.

Include:

### Implemented

- Tests added or modified.
- Requirements and behaviors covered.
- Significant edge cases covered.

### Executed

- Tests or commands run.
- Results.
- Relevant warnings or failures.

### Gaps

- Important edge cases not covered.
- Behaviors that could not be tested.
- Environmental or infrastructure limitations.

### Problems

- Suspected bugs or regressions.
- Requirements that appear unmet.
- Problems preventing complete validation.

### Uncertainty

- Important assumptions.
- Ambiguous requirements.
- Other limitations relevant to interpreting the results.
