git remote update

if [ $(git rev-parse HEAD) != $(git rev-parse origin/release-prod) ]
then
	git fetch
	git reset --hard origin/release-prod

    python ../api/app.py
	# Cleaning up .git directory
	git gc
fi