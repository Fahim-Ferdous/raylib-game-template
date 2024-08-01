for plat in linux web windows; do
	docker build -f ./dockerfiles/build-$plat.dockerfile -t raybuild-$plat .
	id=$(docker create raybuild-$plat)
	docker cp $id:/game/dist .
	docker rm -v $id

	tar -czf ./dist/$plat.tar.gz -C dist/$plat/ .
done
