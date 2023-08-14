default:
	@echo What are you doing?

build:
	@docker build --progress=plain -t foxcapades/apache-kafka:latest .
	@docker build --progress=plain -t foxcapades/apache-kafka:3.4.0 .

run:
	@docker run -it --rm -p 9092:9092 foxcapades/apache-kafka:latest

publish:
	@docker push foxcapades/apache-kafka:latest
	@docker push foxcapades/apache-kafka:3.4.0