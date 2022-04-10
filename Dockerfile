# Docker file to build an image for shapes demo example.
# The image is configured to run a shapes demo 'publisher'
# with topic 'Square'. 
# 
# Eg: Run an image 'dds-shape-demo:1.2' as,
#
#     docker run --network="host" -ti --rm dds-shape-demo:1.2

FROM rust:1.60.0-slim-buster AS build-env
WORKDIR /app
COPY . /app
RUN cargo build --release --example=shapes_demo

FROM gcr.io/distroless/cc
COPY --from=build-env /app/target/release/examples/shapes_demo /
ENTRYPOINT ["./shapes_demo"]
CMD ["-S", "-t", "Square"]
