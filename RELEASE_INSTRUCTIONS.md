# Release Instructions for v0.1.0

This document provides instructions for creating the initial v0.1.0 release of Dumb NixOS.

## Prerequisites

1. The PR fixing the build.yml workflow must be merged to the `master` branch
2. You must have push permissions to create tags on the repository

## Creating the Release

### Option 1: Using GitHub CLI (gh)

```bash
# Ensure you're on the master branch with the latest changes
git checkout master
git pull origin master

# Create and push the v0.1.0 tag
git tag -a v0.1.0 -m "Release v0.1.0 - Initial Dumb NixOS Live ISO"
git push origin v0.1.0
```

The GitHub Actions workflow will automatically:
- Build the NixOS ISO
- Calculate checksums
- Create a GitHub release with the ISO and checksums attached

### Option 2: Using GitHub Web Interface

1. Navigate to the repository on GitHub
2. Go to the "Releases" page
3. Click "Draft a new release"
4. In "Choose a tag", enter `v0.1.0` and select "Create new tag: v0.1.0 on publish"
5. Set the target to `master`
6. Set the release title to: `v0.1.0 - Initial Dumb NixOS Live ISO`
7. The release description will be automatically populated by the workflow
8. Click "Publish release"

The workflow will be triggered and will build and attach the ISO file to the release.

## What Happens After Tag Creation

When the tag is pushed, the GitHub Actions workflow (`.github/workflows/build.yml`) will:

1. Checkout the tagged commit
2. Install Nix with experimental features enabled
3. Build the ISO using `nix build .#iso`
4. Calculate SHA256 checksums
5. Upload the ISO as a build artifact (retained for 30 days)
6. Create a GitHub release with:
   - The built ISO file
   - SHA256SUMS file
   - Release notes describing features and usage

## Verifying the Release

After the workflow completes (typically 20-40 minutes depending on GitHub Actions queue):

1. Check the Actions tab to verify the workflow succeeded
2. Navigate to the Releases page
3. Verify the release contains:
   - The ISO file (typically 2-3 GB)
   - SHA256SUMS file
   - Complete release notes

## Troubleshooting

### Workflow Fails
- Check the Actions tab for detailed logs
- Common issues:
  - Nix build failures: Check flake.nix and iso.nix configurations
  - Permission issues: Ensure the workflow has `contents: write` permission
  - Network issues: May require retry

### Release Not Created
- Verify the tag starts with 'v' (e.g., v0.1.0, not 0.1.0)
- Check that the workflow has `contents: write` permission
- Ensure the GITHUB_TOKEN has release creation permissions

## Post-Release

After a successful release:

1. Test the ISO by downloading and testing in a VM
2. Update project documentation if needed
3. Announce the release to users
4. Monitor for any issues or feedback
