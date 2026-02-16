# Contributing to Dumb NixOS

Thank you for your interest in contributing to Dumb NixOS! This document provides guidelines for contributing to the project.

## How to Contribute

### Reporting Issues

If you find a bug or have a feature request:

1. Check if the issue already exists in the [Issues](https://github.com/BlockG-ws/dumb.nix/issues) section
2. If not, create a new issue with:
   - Clear title and description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Your system information (for bugs)

### Submitting Changes

1. **Fork the Repository**
   ```bash
   git clone https://github.com/YOUR-USERNAME/dumb.nix.git
   cd dumb.nix
   ```

2. **Create a Branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Make Your Changes**
   - Follow the existing code style
   - Test your changes locally
   - Update documentation if needed

4. **Test the Build**
   ```bash
   nix build .#iso
   ```

5. **Commit Your Changes**
   ```bash
   git add .
   git commit -m "Description of your changes"
   ```

6. **Push and Create Pull Request**
   ```bash
   git push origin feature/your-feature-name
   ```
   Then create a Pull Request on GitHub.

## Development Guidelines

### Code Style

- Use consistent indentation (2 spaces for Nix files)
- Comment complex configurations
- Keep changes minimal and focused

### Adding Packages

When adding new packages to `iso.nix`:

1. Ensure the package is necessary for the Live ISO purpose
2. Group packages logically in comments
3. Test that the package works correctly in the Live environment

### Modifying System Configuration

When changing system settings:

1. Test thoroughly to ensure it doesn't break existing functionality
2. Document the change in comments
3. Update README if it affects user-facing features

### Documentation

- Keep both English (README.md) and Chinese (README_CN.md) documentation in sync
- Add usage examples for new features
- Update build instructions if build process changes

## Testing

Before submitting a PR:

1. Build the ISO successfully: `nix build .#iso`
2. Test boot in a VM or physical machine
3. Verify new features work as expected
4. Check that existing features still work

### Testing in QEMU

```bash
nix build .#iso
qemu-system-x86_64 -enable-kvm -m 4096 -cdrom result/iso/*.iso
```

## Pull Request Guidelines

- Provide a clear description of the changes
- Reference related issues
- Keep PRs focused on a single feature or fix
- Be responsive to review feedback

## Code of Conduct

- Be respectful and constructive
- Welcome newcomers
- Focus on the issue, not the person
- Give credit where credit is due

## Questions?

If you have questions about contributing, feel free to:
- Open an issue
- Start a discussion
- Contact the maintainers

Thank you for contributing to Dumb NixOS! 🎉
