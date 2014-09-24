#!/bin/bash
echo "first pull than see the changes since the last pull"
echo "git log --oneline --name-status ORIG_HEAD.."
git log --oneline --name-status ORIG_HEAD..
