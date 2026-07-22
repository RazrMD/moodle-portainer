# Update

Patch updates on the same Moodle branch are handled by rebuilding the image and redeploying the stack in Portainer.

For major Moodle branch upgrades:

1. Back up the database and `moodle_data` volume.
2. Read Moodle's official upgrade notes for the target version.
3. Change `MOODLE_BRANCH` in the Portainer stack environment.
4. Redeploy with image rebuild enabled.
5. Run Moodle's web or CLI upgrade.

Automated upgrade helpers will be added in a later release.
