all:
	stow --adopt --target=$$HOME --stow */
	git checkout HEAD
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */
