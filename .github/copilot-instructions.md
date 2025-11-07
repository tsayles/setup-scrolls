# Copilot Coding Style Instructions

- All code must adhere to an 80 column line length limit.
- Break long statements into multiple lines with proper indentation.
- Use spaces for indentation (4 spaces per level for Python, 2 for JS/C++).
- For function definitions and calls, wrap arguments to new lines if needed.
- For lists, dictionaries, arrays, and objects, wrap and align elements if
  they exceed 80 columns.
- For comments and docstrings, wrap text at 80 columns.
- Avoid trailing whitespace on any line.
- Use explicit imports and avoid wildcard imports.
- Prefer clear, descriptive variable and function names.
- For Python, follow PEP 8 except where overridden by these instructions.
- For C++ and JavaScript, follow the project's existing style, but always
  respect the 80 column rule.

## Python Doc Comments

- Use PEP 257 style docstrings for all public modules, classes, methods,
  and functions.
- The docstring should be a triple-quoted string, starting with a summary
  line.
- Include descriptions of parameters, return values, and exceptions if
  applicable.
- Wrap all docstrings at 80 columns.

## Code Security
- Avoid using deprecated or insecure functions and libraries.
- Validate and sanitize all user inputs to prevent injection attacks.
- Handle sensitive data (like passwords and API keys) securely, avoiding
  hardcoding them in the source code.
- Follow best practices for error handling to avoid exposing sensitive
  information.
  Run security linters or static analysis tools like CodeQL to identify potential
  vulnerabilities before finalizing the code.

## Unit Tests

- All new functions and classes must include corresponding unit tests.
- Unit should be generated before the implementation. Ask clarification
  questions if the requirements are ambiguous.
- Place tests in dedicated test files or folders as per project convention.
- create a reference output for the unit tests to compare against under the 
  tests/sample_results folder, grouped in subfolders by the name of the unit 
  being tested.
- Use the standard testing framework for the language (e.g., `unittest` or
  `pytest` for Python).
- Unit test code must also follow the 80 column rule and include PEP 257 doc 
  comments.
- Test cases should be clear, descriptive, and cover edge cases.

## Performance Benckmarks test
- For performance-critical functions, include benchmark tests to measure
  execution time and memory usage.
- Benchmarks should be placed in a separate file or folder named
  `benchmarks`.
- Use appropriate benchmarking tools or libraries available for the
  programming language.

## GUI Development Best Practices

- See the GUI development guidance in
  `.github/gui-development-best-practices.md` for more detail.

- Documentation and examples:

