IMAGES_URL=https://cloud.uni-hamburg.de/s/ZndexSjSH9ZqxTG/download
IMAGES_ARCHIVE=version-control-course-uni-wuerzburg-2025.zip
IMAGES_DIR=images/
CHEATSHEET_URL=https://raw.githubusercontent.com/lnnrtwttkhn/version-control-book/main/cheatsheet.json

.PHONY: all
all: render

.PHONY: preview
preview:
	quarto preview

.PHONY: render
render: clean objectives objectives-datalad exercises cheatsheet images
	quarto render

.PHONY: deploy
deploy: clean images objectives objectives-datalad exercises
	quarto publish gh-pages

.PHONY: images
images:
	curl -L $(IMAGES_URL) -o $(IMAGES_ARCHIVE)
	unzip -j -o $(IMAGES_ARCHIVE) -d $(IMAGES_DIR)
	rm -f $(IMAGES_ARCHIVE)

.PHONY: objectives
objectives: objectives.txt
	rm -rf ./objectives
	mkdir -p objectives
	wget -P ./objectives -i objectives.txt  

.PHONY: objectives-datalad
objectives-datalad:
	rm -rf ./objectives-datalad
	mkdir -p objectives-datalad
	wget -P ./objectives-datalad -i objectives-datalad.txt  

.PHONY: exercises
exercises: exercises.txt
	rm -rf ./exercises
	mkdir -p exercises
	wget -P ./exercises -i exercises.txt 

.PHONY: cheatsheet
cheatsheet:
	rm -rf cheatsheet.json
	wget $(CHEATSHEET_URL)

.PHONY: clean
clean:
	rm -rf _site $(IMAGES_DIR)*
